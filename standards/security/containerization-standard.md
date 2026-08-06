# Containerization Standard

**Suite Version:** 1.0.0
**Binding Level:** Mandatory-if-applicable
**Status:** Active
**Owner:** JANUS Architecture Council
**Last Reviewed:** 2026-08-06

Applies to: all JANUS services that deploy containerized workloads.

---

## Base Image Requirements

- Base images must come from official sources or verified publisher images only
- Prefer distroless or Alpine variants to minimize attack surface
- No `latest` tag — pin to an explicit version: `node:20.15.1-alpine3.20`
- Base image versions are updated as part of the quarterly dependency review
- The base image version is documented in the service's `docs/operations/configuration-management.md`

---

## Required Dockerfile Patterns

```dockerfile
# Correct
FROM node:20.15.1-alpine3.20 AS base

# Build stage
FROM base AS builder
WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN npm install -g pnpm && pnpm install --frozen-lockfile
COPY . .
RUN pnpm build

# Production stage — minimal image
FROM base AS production
WORKDIR /app
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
COPY --from=builder --chown=appuser:appgroup /app/dist ./dist
COPY --from=builder --chown=appuser:appgroup /app/node_modules ./node_modules
USER appuser
EXPOSE 3000
CMD ["node", "dist/index.js"]
```

---

## Non-Root User Requirement

Containers must not run as root. Every production container:
- Creates a dedicated non-root user and group during build
- Switches to that user before the `CMD` / `ENTRYPOINT` instruction
- Owns only the files it needs to read and execute

Running as root in production is a compliance violation regardless of the deployment platform.

---

## Image Scanning

- Container images are scanned for vulnerabilities before deployment to any shared environment
- Scanning runs in CI after the build step
- Critical and High severity findings block deployment — the image is not pushed if findings exist
- Scanning uses a tool configured per the service's CI pipeline (Trivy, Snyk, or equivalent)

---

## Secrets in Containers

- No secrets in environment variables baked into the image at build time
- No secrets in Dockerfile instructions (`ARG`, `ENV` with sensitive values, `RUN` commands that use secrets)
- Secrets are injected at runtime via the deployment platform's secret management mechanism
- Build arguments (`ARG`) that are values (not flags) are scrutinized — they appear in image history

---

## Port Exposure

- Containers expose only the ports they actually use
- No debugging ports are exposed in production images (no `--inspect`, no remote debugging ports)
- The exposed port is documented in the service's `docs/operations/configuration-management.md`

---

## Resource Limits

Production deployments specify resource limits. A container without resource limits can consume all available resources on its host, affecting other services.

Minimum configuration for any production deployment:
```yaml
resources:
  limits:
    cpu: "1"
    memory: "512Mi"
  requests:
    cpu: "100m"
    memory: "128Mi"
```

Specific limits are calibrated based on the service's observed behavior in staging and documented in the service's deployment configuration.

---

## Health Checks

Every containerized service exposes:
- A `/health` endpoint returning `200 OK` when the service is operational
- A `/ready` endpoint returning `200 OK` when the service is ready to receive traffic

These endpoints do not require authentication. They return minimal response bodies.

Health check configuration is included in the Dockerfile and the deployment configuration.
