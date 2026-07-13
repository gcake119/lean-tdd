# lean-tdd

`lean-tdd` 是一個低 token、可組合的 Test-Driven Development skill。它用於既有 task 內的行為變更與 bug fix，只保留 test-first 所需的最小紀律，不接管需求、規格、任務追蹤、commit 或發布流程。

## 設計目標

- 一次只推進一個可觀察行為。
- 從既有 design、spec、task 或 tests 找到最高且穩定的 test seam。
- 每個內迴圈只跑 focused test；完整 verification 留在 task 或 repository gate。
- 在小改動、趕時間或 sunk cost 壓力下，仍先看到正確原因的 RED。
- 沒有可行 seam 或測試框架時，回報 verification gap，不用弱測試製造假信心。

這個 skill 適合放在 Spectra、OpenSpec、issue 或其他既有工作追蹤流程的實作階段。它不建立第二套 spec 或 task SSOT。

## 安裝

```bash
git clone https://github.com/gcake119/lean-tdd.git
cd lean-tdd
./scripts/install.sh
```

預設安裝到 `${CODEX_HOME:-$HOME/.codex}/skills/lean-tdd`。如果目的地已存在，安裝程式會先建立時間戳備份。安裝後請重新啟動 Codex，讓新的 skill inventory 生效。

## 使用

```text
$lean-tdd implement the current Spectra task one behavior at a time
```

建議路由：

```text
Spectra／既有 tracker 定義 task
→ lean-tdd 執行 RED／GREEN／REFACTOR
→ repo-defined verification
→ review／archive／commit 由既有流程負責
```

## 驗證

```bash
./scripts/validate.sh
./tests/install-smoke.sh
```

`scripts/validate.sh` 會檢查必要檔案、placeholder、word budget、shell syntax，並在 Codex 官方 skill validator 可用時一併執行。`tests/scenarios/` 提供 feature、bug fix 與 missing-seam 的 forward-test 情境。

## 專案結構

```text
skills/lean-tdd/       Codex skill SSOT
scripts/install.sh     保守且可備份的本機安裝
scripts/validate.sh    靜態與官方 validator 驗證
tests/install-smoke.sh 安裝流程 smoke test
tests/scenarios/       Agent forward-test 情境
```

## 概念來源

本專案受到 [mattpocock/skills](https://github.com/mattpocock/skills) 的小型、可組合 skill 與 test-seam TDD 方法啟發，並針對 Spectra／SDD、repo-local verification、明確授權邊界與低 token 使用情境重新設計；不是原 skill 的直接複製。

## License

MIT
