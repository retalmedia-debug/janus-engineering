#!/usr/bin/env bash
# check-standards-drift.sh
# Identifies documents in a service repo that were copied from an older template version
# Usage: ./scripts/check-standards-drift.sh [--repo-path PATH]

set -euo pipefail

REPO_PATH="${PWD}"

usage() {
  echo "Usage: $0 [--repo-path PATH]"
  echo ""
  echo "  --repo-path  Path to the service repository to check (default: current directory)"
  exit 1
}

while [[ $# -gt 0 ]]; do
  case $1 in
    --repo-path) REPO_PATH="$2"; shift 2 ;;
    --help) usage ;;
    *) echo "Unknown argument: $1"; usage ;;
  esac
done

COMPLIANCE_FILE="${REPO_PATH}/.janus-compliance.yaml"
if [[ ! -f "${COMPLIANCE_FILE}" ]]; then
  echo "Error: .janus-compliance.yaml not found at ${REPO_PATH}"
  exit 1
fi

DECLARED_VERSION=$(grep "janus_engineering_suite_version:" "${COMPLIANCE_FILE}" | awk '{print $2}' | tr -d '"')

echo ""
echo "Standards Drift Report"
echo "Repository: ${REPO_PATH}"
echo "Declared suite version: ${DECLARED_VERSION}"
echo ""

DRIFT_COUNT=0

# Find all markdown files that contain a Template metadata comment
find "${REPO_PATH}/docs" -name "*.md" -exec grep -l "<!-- Template: janus-engineering@" {} \; 2>/dev/null | while read -r file; do
  TEMPLATE_VERSION=$(grep "<!-- Template: janus-engineering@" "${file}" | sed 's/.*janus-engineering@\([0-9.]*\).*/\1/' | head -1)
  if [[ "${TEMPLATE_VERSION}" != "${DECLARED_VERSION}" ]]; then
    echo "[DRIFT] ${file#"${REPO_PATH}/"}"
    echo "        Template version: ${TEMPLATE_VERSION} → Current: ${DECLARED_VERSION}"
    DRIFT_COUNT=$((DRIFT_COUNT + 1))
  fi
done

if [[ "${DRIFT_COUNT}" -eq 0 ]]; then
  echo "No template drift detected. All documents match the declared suite version."
else
  echo ""
  echo "${DRIFT_COUNT} document(s) use an older template version."
  echo "Review the CHANGELOG for the relevant suite version to identify what changed."
  echo "Apply template updates as part of your suite version upgrade PR."
fi
