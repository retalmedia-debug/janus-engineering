# How to Scaffold a New JANUS Service

**Suite Version:** 1.0.0
**Status:** Active
**Owner:** JANUS Principal Architect
**Last Reviewed:** 2026-08-06

Related: `docs/guides/new-service-lifecycle.md` · `docs/governance/ecosystem-service-roadmap.md` · `scripts/scaffold-service.sh`

---

## Prerequisites

Before running the scaffold script, these gates must be cleared:

1. The service's JAC-approved domain brief exists (Phase 0, Gate 0.1)
2. The service appears in `services/registry.yaml` with status `approved` or higher
3. The service's implementation position in the canonical sequence is confirmed
4. The service is next in sequence (or a JAC ADR waives the sequence requirement)
5. You have `janus-engineering` cloned locally and know the current suite version (`cat VERSION`)

---

## Running the Scaffold Script

```bash
cd /path/to/janus-engineering

./scripts/scaffold-service.sh \
  --name "SERVICE_NAME" \
  --repo "service-repo-name" \
  --domain "Brief domain description" \
  --csa "CSA Full Name" \
  --suite-version "$(cat VERSION)" \
  --target-dir "/path/to/parent/directory"
```

### Parameters

| Parameter | Description | Example |
|---|---|---|
| `--name` | Service display name (SCREAMING_CAPS) | `GCS` |
| `--repo` | Repository name | `gcs-v1` |
| `--domain` | One-line domain description | `Ground Control System` |
| `--csa` | Full name of the Chief Software Architect | `Jane Smith` |
| `--suite-version` | JANUS suite version to stamp in templates | `1.0.0` |
| `--target-dir` | Parent directory where the repo will be created | `/Users/you/projects/janus` |

The script will:
1. Create `[target-dir]/[repo-name]/` directory structure
2. Copy all templates from `templates/repository/` with placeholders substituted
3. Create `.janus-compliance.yaml` with correct metadata
4. Run `git init` in the new repository
5. Print next-steps instructions

---

## What the Script Does Not Do

The scaffold creates the structural skeleton — it does not:
- Create a GitHub repository (you do this manually or via `gh repo create`)
- Push to remote
- Fill in `[[FILL:]]` sections (you do this manually)
- Make the initial commit (you do this after filling in the required sections)

---

## After Scaffolding: Required Fill-In

After the script runs, open each file and complete every `[[FILL:]]` marker. Priority order:

### 1. Immediate (before git init commit)

- `CLAUDE.md` — Fill all service-specific sections. This is the AI's primary instruction set.
- `docs/governance/repository-governance.md` — Decision authority matrix, branch protection rules
- `docs/governance/definition-of-done.md` — Service-specific DoD criteria
- `docs/governance/onboarding.md` — Prerequisites and setup steps

### 2. Before architecture work begins

- `docs/architecture/domain-model.md` — Core entities and ubiquitous language
- `docs/architecture/system-context.md` — C4 Level 1 diagram
- `docs/architecture/ecosystem-integration.md` — Integration points
- `docs/architecture/folder-strategy.md` — Source directory structure

### 3. Before implementation begins

- `docs/security/threat-model.md` — STRIDE analysis
- `docs/security/security-baseline.md` — Service-specific security controls
- `docs/operations/environment-management.md` — Environment topology
- `docs/api/api-governance.md` — API versioning and authentication (if service has an API)

---

## Making the Initial Commit

After completing required `[[FILL:]]` sections:

```bash
cd /path/to/new-service-repo
git add .
git commit -m "chore: scaffold [SERVICE_NAME] — JANUS suite v[VERSION]

Establishes repository structure from janus-engineering@[VERSION] template.
Phase 1, Gate 1.1: Repository created."
```

---

## Updating Services Registry

After the repository is created and the initial commit is made, update `services/registry.yaml` in `janus-engineering`:

```yaml
- name: [SERVICE_NAME]
  status: bootstrapping  # Update from 'approved'
  suite_version: "[VERSION]"
  created_date: "[YYYY-MM-DD]"
  csa: "[CSA Name]"
```

Open a PR against `janus-engineering` with this change.

---

## Running the Compliance Check

Before declaring Phase 1 complete:

```bash
./scripts/validate-compliance.sh --repo-path /path/to/new-service-repo
```

All `[FAIL]` results must be resolved. `[WARN]` results should be addressed or documented. The compliance check must pass before Phase 2 begins.

---

## Troubleshooting

### "Placeholder not substituted"

Run: `grep -r '{{' /path/to/new-service-repo/` to find unsubstituted `{{}}` placeholders. These indicate a parameter was missing from the scaffold command. Fix the value manually and update the script invocation for future reference.

### "Script failed on sed substitution"

On macOS, `sed` requires `-i ''` for in-place editing. The script handles this, but if you encounter errors, ensure you're running bash (not sh): `bash scripts/scaffold-service.sh ...`

### "git init failed"

The target directory likely already exists. Check: `ls /path/to/target/service-repo-name`. If it exists and was a failed scaffold, remove it: `rm -rf /path/to/target/service-repo-name` and re-run.
