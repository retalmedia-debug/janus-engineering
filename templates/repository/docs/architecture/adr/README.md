<!-- Template: janus-engineering@{{JANUS_SUITE_VERSION}}/templates/repository/docs/architecture/adr/README.md -->

# Architecture Decision Records — {{SERVICE_NAME}}

This directory contains Architecture Decision Records for `{{SERVICE_REPO}}`.

ADR format and process follow the JANUS Engineering Standard:
[ADR Format](https://github.com/janus/janus-engineering/blob/v{{JANUS_SUITE_VERSION}}/standards/architecture/adr-format.md)

Ecosystem-level ADRs (binding on all JANUS services) are maintained in:
`janus-engineering/adr/ecosystem/`

---

## ADR Index

| ADR | Title | Status | Date |
|---|---|---|---|
| _(no ADRs yet)_ | | | |

---

## ADR Numbering

Service ADRs use plain sequential numbers: `ADR-0001`, `ADR-0002`, ...

Numbers are never reused. A rejected ADR retains its number.

Next available number: `ADR-0001`

---

## Process

1. Create: `docs/architecture/adr/ADR-XXXX-kebab-case-title.md` with `Status: Proposed`
2. Open a PR with the ADR as the only change
3. Tag the CSA for review and decision
4. Update `Status` to `Accepted` or `Rejected` before merging
5. Update this README's ADR Index

ADRs are immutable after acceptance. If a decision changes, a new ADR supersedes the original.
