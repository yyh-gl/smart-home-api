
# スマートホーム化計画 〜API編〜

## API一覧
| エンドポイント |           機能 |
|:---------------|---------------:|
| /weather       | 今日の天気予報 |
| /alarm/:time   |       アラーム |


## 今後の予定
- [雑談対話](https://dev.smt.docomo.ne.jp/?p=docs.api.index)に対応

- アラーム予約日時の削除

-> `at -l | grep 15:35 | awk '{print $1}' | xargs at -d`コマンドで削除可能
