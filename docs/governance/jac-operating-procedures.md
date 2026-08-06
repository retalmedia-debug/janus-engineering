# JAC Operating Procedures

**Classification:** [JES] JANUS Governance Document
**Suite Version:** 1.0.0
**Status:** Active
**Owner:** JANUS Principal Architect
**Last Reviewed:** 2026-08-06

Related: `docs/governance/how-this-repo-is-governed.md` · `docs/governance/rfc-process.md` · `docs/governance/ecosystem-service-roadmap.md`

---

## Purpose

The JANUS Architecture Council (JAC) is the governing body for all ecosystem-level decisions. This document defines how the JAC operates: meeting cadence, decision protocols, quorum rules, and member responsibilities. These procedures apply to all matters within JAC authority.

---

## JAC Composition

| Role | Count | Voting Rights |
|---|---|---|
| JANUS Principal Architect | 1 | Yes — permanent seat with tie-breaking vote |
| Service Chief Software Architects | 1 per production service | Yes — seat activates when service enters production |
| Security Lead | 1 | Yes |
| Observer (CSA of services in governance-establishment) | 1 per applicable service | No — advisory only |

**Minimum composition for a functioning JAC:** Principal Architect + Security Lead. Additional seats activate as services reach production.

---

## Meeting Cadence

| Meeting Type | Frequency | Required Attendees | Duration |
|---|---|---|---|
| JAC Regular Meeting | Monthly | All voting members | ≤ 2 hours |
| RFC Disposition Meeting | As needed (min. 14 days after RFC filed) | All voting members | ≤ 1 hour per RFC |
| Emergency Session | As needed | Principal Architect + available voting members | No fixed duration |
| Annual Review | Annually | All voting members + all CSA observers | ≤ half day |

---

## Quorum

**Regular Meeting:** Majority of voting members (50% + 1)
**RFC Disposition:** All voting members must have had opportunity to vote (in-person or async). Quorum is reached when all members have voted or explicitly abstained.
**Emergency Session:** Principal Architect + one other voting member.

A meeting without quorum may proceed for discussion but may not issue binding decisions.

---

## RFC Disposition Process

1. RFC is filed (GitHub Issue using the RFC template)
2. 14-day minimum comment period begins
3. The Principal Architect schedules an RFC Disposition Meeting no earlier than day 14
4. At the Disposition Meeting:
   - RFC author presents (10 minutes maximum)
   - Discussion (open to all; voting members have floor priority)
   - Formal vote
5. Outcome options:

| Outcome | Meaning |
|---|---|
| **Accepted** | RFC is approved. PR implementing the change may be merged. Suite version bumped accordingly. |
| **Accepted with Modifications** | RFC is approved subject to specific changes listed in the disposition notes. Modified RFC must be re-reviewed by the Principal Architect before merge. |
| **Deferred** | Needs more information or the timing is wrong. RFC reopened with a due date for additional information. |
| **Rejected** | RFC is not consistent with JANUS principles or causes unacceptable ecosystem impact. Rejection must be accompanied by written rationale. |

---

## Voting Protocol

### Standard Decisions

- Each voting member casts one vote: **Approve / Reject / Abstain**
- Decision reached by simple majority
- **Tie:** Principal Architect's vote is the deciding vote
- **Principal Architect recusal:** If the Principal Architect has a conflict, the Security Lead breaks ties

### Super-Majority Decisions

The following decisions require a **2/3 super-majority of all voting members** (not just present):

- Amending the canonical implementation sequence (MAJOR ecosystem change)
- Removing a service from the ecosystem (deprecation/retirement)
- Changing the governance model itself (composition, voting rules)
- Elevating a security-related standard to Mandatory (from Recommended)

### Emergency Decisions

In a P0 incident, the Principal Architect may make ecosystem-level decisions unilaterally. All emergency decisions must be:

1. Documented in the incident issue at the time of the decision
2. Ratified (or overturned) by a full JAC vote at the next Regular Meeting

---

## Meeting Records

Every JAC meeting must produce:

1. **Attendance record** — who attended, who voted, who abstained
2. **Decision log** — every decision made with the vote count
3. **Action items** — owner and due date for each
4. **Next meeting date**

Meeting records are committed to `docs/governance/jac-decisions.md` (a running log) within 5 business days of the meeting.

---

## JAC Authority Boundaries

The JAC governs:
- JANUS Engineering Standards
- The canonical implementation sequence
- Cross-service integration approvals
- Suite version releases
- Service admission and retirement

The JAC does **not** govern:
- Implementation decisions within a single service (that is the CSA's authority)
- Hiring and organizational decisions
- Product roadmap and feature prioritization
- Commercial agreements

---

## Conflicts of Interest

A JAC member must recuse themselves from a vote when:
- The decision directly affects their own service's compliance status
- They have a personal stake in the outcome

Recusal is declared before discussion begins. Recused members may participate in discussion but not vote.

---

## Member Onboarding

When a new CSA seat is activated (service enters production):

1. The Principal Architect sends a JAC onboarding briefing covering this document, the RFC process, and governance authority boundaries
2. The new member reviews the last 6 months of JAC decisions
3. The new member attends one full Regular Meeting as observer before their first vote
4. Seat is formally activated and the member votes at the following meeting

---

## Annual Review

The JAC Annual Review covers:

- Ecosystem health metrics (incident frequency, compliance rates, suite version adoption)
- Retrospective on RFC decisions — were they correct? Any reversals needed?
- Review of this document and all governance documents for needed updates
- Forward-looking: what standards gaps exist for the next year's planned services?
