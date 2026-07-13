# Forward-test report

Date：2026-07-13

## RED baseline

在沒有 `lean-tdd` 的小改動壓力情境中，agent 選擇先修改實作；測試只有在低成本時才補，否則以事後腳本驗證代替。失敗模式是把 coverage／verification 當成 test-first。

## GREEN results

| Scenario | Result |
|---|---|
| `feature-pressure.md` | 先找既有 Vitest seam，觀察正確 RED，才做最小實作；完整 suite 留在 repository gate |
| `bugfix-pressure.md` | 以回報中的精確輸入建立 regression RED，把已知一行修正視為待驗證假設 |
| `missing-seam.md` | 停止 TDD，回報 verification gap；未建立弱測試或未授權 harness |

三個情境均符合 skill 契約，未發現需要增加文字的新 loophole。

## Static prompt budget

| Skill body | Words |
|---|---:|
| Superpowers `test-driven-development` 6.1.1 | 1,496 |
| `lean-tdd` | 334 |

`lean-tdd` 的 skill body 約減少 77.7％。這是靜態輸入規模，不等同真實 API token；真實成本仍受 system prompt、repo context、測試輸出與模型行為影響。
