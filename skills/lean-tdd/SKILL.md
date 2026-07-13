---
name: lean-tdd
description: Use when implementing a behavior change or bug fix test-first inside an existing task, especially when time pressure or a small diff could turn tests into an afterthought.
---

# Lean TDD

Drive one observable behavior at a time through the highest stable public seam. Keep the loop small; keep the evidence real.

## Start Gate

1. Read the current task and its observable contract. Do not create a parallel spec, plan, or tracker.
2. Find the repo's existing test framework, nearby test pattern, and highest stable seam. Prefer a seam already named by the design, task, or tests.
3. If the seam is genuinely undecided, ask once before writing a test. If no viable framework or seam exists, stop and report the verification gap; do not invent a weak test or silently add infrastructure.

## One Slice

1. **RED** — Write one minimal behavior test, using an agreed spec example when available. Run the narrowest command and observe the expected failure.
2. **GREEN** — Make the smallest implementation change that passes that test. Run the same focused command.
3. **REFACTOR** — Improve names or structure only while green. Do not add behavior without another RED cycle.
4. Run the task's repo-defined verification before completion. The full suite belongs at the task or repository gate, not every inner loop.

For a bug, the first RED test must reproduce the reported failure. For behavior that already works but lacks coverage, write a characterization test and prove its sensitivity with a temporary mutation before restoring the implementation.

## Pressure Rules

- A small behavior change is not an exception. Test-first can still use a focused command.
- Tests written after implementation are coverage, not TDD.
- Do not broaden scope, refactor unrelated code, or add speculative cases.
- Do not mark the task done when RED was skipped, the failure reason was wrong, or required verification is still failing.
- Do not commit, archive, or push unless the user separately authorized it.
