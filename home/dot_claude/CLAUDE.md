## Token efficiency

1. Batch independent tool calls into one message (reads, greps, git). No serial round-trips without a real data dependency.
2. Locate with Grep/Glob first, then read only the needed ranges (offset/limit). Never read a whole file to find one symbol.
3. Never re-read what is already in context, including files you just edited.
4. Cap command output: pipe through head/tail/wc. Run the single targeted spec file, never the full suite unless asked.
5. Standing approval: for anything spanning >5 files, use a read-only subagent (Explore / cavecrew-investigator) and report conclusions only.
6. Answer from context. Do not re-derive or re-verify what this session already established.
7. No unrequested output: no recap of edits just applied, no echoing file contents or diffs back, no option menus when a sensible default exists.
8. Cite file:line instead of quoting code back to me.
9. Durable state goes to disk (.claude/temp/\*.md) and is referenced by path, not carried in the conversation.
10. When context passes 150k tokens, say so in one line and recommend /clear.

## Code principles

1. Prefer explicit code over magic: no hidden behavior, implicit conventions, or clever indirection.
2. Choose boring, proven tech. Keep dependencies few and interfaces small.
3. Write code that is readable, easy to maintain, and hard to break or misuse.
4. Reject complexity that does not earn its place. The simpler working solution wins.

## Workflow

1. Spec first for non-trivial work: write or update the spec before any code. Cover goal, scope, interfaces, edge cases, and how to validate the result.
2. Check the spec against the existing code. If they conflict, surface the conflict and ask; do not resolve it silently.
3. Start coding only once the spec holds.
4. Docs ship with the change: when code, behavior, features, or architecture change, update every related doc (README, specs, architecture notes, comments) in the same change. Stale docs count as a bug.
5. Before adding a package or tool, read the vendor's official install docs and cite them. A package with a matching name is not proof it is the right one.
