#!/usr/bin/env bash
# validate-compliance.sh
# Checks a JANUS service repository against mandatory compliance requirements
# Usage: ./scripts/validate-compliance.sh [--repo-path PATH] [--suite-version VERSION]

set -euo pipefail

REPO_PATH="${PWD}"
SUITE_VERSION=""
VIOLATIONS=0
WARNINGS=0
CHECKS_PASSED=0

usage() {
  echo "Usage: $0 [--repo-path PATH] [--suite-version VERSION]"
  echo ""
  echo "  --repo-path     Path to the service repository to check (default: current directory)"
  echo "  --suite-version Suite version to validate against (default: declared in .janus-compliance.yaml)"
  exit 1
}

while [[ $# -gt 0 ]]; do
  case $1 in
    --repo-path) REPO_PATH="$2"; shift 2 ;;
    --suite-version) SUITE_VERSION="$2"; shift 2 ;;
    --help) usage ;;
    *) echo "Unknown argument: $1"; usage ;;
  esac
done

# Colors
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color
BOLD='\033[1m'

fail() { echo -e "${RED}[FAIL]${NC} $1"; VIOLATIONS=$((VIOLATIONS + 1)); }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; WARNINGS=$((WARNINGS + 1)); }
pass() { echo -e "${GREEN}[PASS]${NC} $1"; CHECKS_PASSED=$((CHECKS_PASSED + 1)); }

echo ""
echo -e "${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BOLD}JANUS Compliance Check${NC}"
echo -e "${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo "Repository: ${REPO_PATH}"
echo ""

# Check 1: .janus-compliance.yaml exists
COMPLIANCE_FILE="${REPO_PATH}/.janus-compliance.yaml"
if [[ ! -f "${COMPLIANCE_FILE}" ]]; then
  fail ".janus-compliance.yaml not found. Run scaffold-service.sh to create it."
  echo ""
  echo -e "${RED}Cannot continue: compliance declaration file is required.${NC}"
  exit 1
fi
pass ".janus-compliance.yaml exists"

# Read declared suite version
DECLARED_VERSION=$(grep "janus_engineering_suite_version:" "${COMPLIANCE_FILE}" | awk '{print $2}' | tr -d '"')
if [[ -z "${DECLARED_VERSION}" ]]; then
  fail ".janus-compliance.yaml missing janus_engineering_suite_version field"
else
  pass "Suite version declared: ${DECLARED_VERSION}"
fi

echo ""
echo -e "${BOLD}[Required Files]${NC}"

# Check required root files
required_root_files=(
  "README.md"
  "CLAUDE.md"
  "AGENTS.md"
  "CHANGELOG.md"
  ".gitignore"
  ".editorconfig"
)

for file in "${required_root_files[@]}"; do
  if [[ -f "${REPO_PATH}/${file}" ]]; then
    pass "${file} exists"
  else
    fail "${file} missing"
  fi
done

# Check CLAUDE.md contains suite version reference
if [[ -f "${REPO_PATH}/CLAUDE.md" ]]; then
  if grep -q "janus-engineering@" "${REPO_PATH}/CLAUDE.md"; then
    pass "CLAUDE.md contains janus-engineering suite version reference"
  else
    fail "CLAUDE.md does not contain a janus-engineering suite version reference"
  fi
fi

echo ""
echo -e "${BOLD}[Required Governance Documents]${NC}"

required_governance_docs=(
  "docs/governance/repository-governance.md"
  "docs/governance/development-workflow.md"
  "docs/governance/branching-strategy.md"
  "docs/governance/commit-convention.md"
  "docs/governance/pull-request-rules.md"
  "docs/governance/definition-of-done.md"
  "docs/governance/quality-gates.md"
  "docs/governance/release-strategy.md"
  "docs/governance/versioning-strategy.md"
)

for doc in "${required_governance_docs[@]}"; do
  if [[ -f "${REPO_PATH}/${doc}" ]]; then
    pass "${doc}"
  else
    fail "${doc} missing"
  fi
done

echo ""
echo -e "${BOLD}[Required Architecture Documents]${NC}"

required_arch_docs=(
  "docs/architecture/engineering-principles.md"
  "docs/architecture/adr/README.md"
)

for doc in "${required_arch_docs[@]}"; do
  if [[ -f "${REPO_PATH}/${doc}" ]]; then
    pass "${doc}"
  else
    fail "${doc} missing"
  fi
done

echo ""
echo -e "${BOLD}[Required Security Documents]${NC}"

if [[ -f "${REPO_PATH}/docs/security/security-baseline.md" ]]; then
  pass "docs/security/security-baseline.md"
else
  fail "docs/security/security-baseline.md missing"
fi

echo ""
echo -e "${BOLD}[Secret Management Compliance]${NC}"

# Check for common secret anti-patterns in the repository
# (Only check committed files, not unstaged)
if git -C "${REPO_PATH}" rev-parse --git-dir > /dev/null 2>&1; then
  if git -C "${REPO_PATH}" ls-files | xargs grep -l "process\.env\." -- 2>/dev/null | grep -v "node_modules" | grep -v ".md" | head -1 > /dev/null 2>&1; then
    warn "Direct process.env usage detected — verify secrets are not hardcoded. See secret-management-standard.md"
  else
    pass "No obvious secret anti-patterns detected"
  fi

  # Check for .env files committed
  if git -C "${REPO_PATH}" ls-files | grep -E "^\.env$" > /dev/null 2>&1; then
    fail ".env file is tracked by git — remove from tracking and add to .gitignore"
  else
    pass ".env not committed to git"
  fi
fi

echo ""
echo -e "${BOLD}[Observability Compliance]${NC}"

if [[ -f "${REPO_PATH}/docs/operations/observability-strategy.md" ]]; then
  pass "docs/operations/observability-strategy.md exists"
else
  warn "docs/operations/observability-strategy.md missing — required before production (observability-standard.md)"
fi

if [[ -f "${REPO_PATH}/docs/operations/incident-response-runbook.md" ]]; then
  pass "docs/operations/incident-response-runbook.md exists"
else
  warn "docs/operations/incident-response-runbook.md missing — required before production (runbook-standard.md)"
fi

echo ""
echo -e "${BOLD}[GitHub Templates]${NC}"

if [[ -f "${REPO_PATH}/.github/pull_request_template.md" ]]; then
  pass ".github/pull_request_template.md exists"
else
  fail ".github/pull_request_template.md missing"
fi

if ls "${REPO_PATH}/.github/ISSUE_TEMPLATE/"*.md 2>/dev/null | head -1 > /dev/null; then
  pass ".github/ISSUE_TEMPLATE/ contains templates"
else
  fail ".github/ISSUE_TEMPLATE/ is empty or missing"
fi

echo ""
echo -e "${BOLD}[Package Manager]${NC}"

if [[ -f "${REPO_PATH}/package.json" ]]; then
  if [[ -f "${REPO_PATH}/package-lock.json" ]]; then
    fail "package-lock.json found — npm was used instead of pnpm"
  fi
  if [[ -f "${REPO_PATH}/yarn.lock" ]]; then
    fail "yarn.lock found — yarn was used instead of pnpm"
  fi
  if [[ -f "${REPO_PATH}/pnpm-lock.yaml" ]]; then
    pass "pnpm-lock.yaml found"
  else
    warn "package.json exists but no pnpm-lock.yaml — run pnpm install"
  fi

  # Check @janus tooling packages
  if grep -q '"@janus/eslint-config"' "${REPO_PATH}/package.json"; then
    pass "@janus/eslint-config declared"
  else
    fail "@janus/eslint-config not in package.json devDependencies"
  fi

  if grep -q '"@janus/prettier-config"' "${REPO_PATH}/package.json"; then
    pass "@janus/prettier-config declared"
  else
    fail "@janus/prettier-config not in package.json devDependencies"
  fi

  if grep -q '"@janus/commitlint-config"' "${REPO_PATH}/package.json"; then
    pass "@janus/commitlint-config declared"
  else
    fail "@janus/commitlint-config not in package.json devDependencies"
  fi

  if grep -q '"typescript"' "${REPO_PATH}/package.json"; then
    if grep -q '"@janus/tsconfig"' "${REPO_PATH}/package.json"; then
      pass "@janus/tsconfig declared (TypeScript service)"
    else
      fail "@janus/tsconfig not in package.json (TypeScript detected)"
    fi
  fi
else
  warn "No package.json found — skipping tooling checks (pre-implementation phase)"
fi

echo ""
echo -e "${BOLD}[CI Configuration]${NC}"

if ls "${REPO_PATH}/.github/workflows/"*.yml 2>/dev/null | head -1 > /dev/null; then
  if grep -rq "\-\-no-verify" "${REPO_PATH}/.github/workflows/"; then
    fail "--no-verify found in CI workflows — hooks must not be bypassed"
  else
    pass "No --no-verify in CI workflows"
  fi
else
  warn "No CI workflows found — add compliance-check.yml from janus-engineering templates"
fi

# Check for active compliance exceptions
EXCEPTIONS_COUNT=$(grep -c "waiver_id:" "${COMPLIANCE_FILE}" 2>/dev/null || echo "0")
if [[ "${EXCEPTIONS_COUNT}" -gt 0 ]]; then
  warn "${EXCEPTIONS_COUNT} active compliance exception(s) — verify they have not expired"
fi

echo ""
echo -e "${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BOLD}Results${NC}"
echo -e "${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}Passed:${NC}   ${CHECKS_PASSED}"
echo -e "${YELLOW}Warnings:${NC} ${WARNINGS}"
echo -e "${RED}Failed:${NC}   ${VIOLATIONS}"
echo ""

if [[ "${VIOLATIONS}" -gt 0 ]]; then
  echo -e "${RED}COMPLIANCE CHECK FAILED — ${VIOLATIONS} mandatory violation(s)${NC}"
  exit 1
elif [[ "${WARNINGS}" -gt 0 ]]; then
  echo -e "${YELLOW}COMPLIANCE CHECK PASSED WITH WARNINGS${NC}"
  exit 0
else
  echo -e "${GREEN}COMPLIANCE CHECK PASSED${NC}"
  exit 0
fi
