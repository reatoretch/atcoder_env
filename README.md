# atcoder_env

## 競技開始前準備

docker起動
```bash
docker compose up -d
```

接続
```bash
docker compose exec -it dev /bin/bash
```

Login

```bash
acc login
```

```bash
oj login https://atcoder.jp
```
それぞれusername, passwordを聞かれるのでAtCoderのusenameとpasswordを入力

## 競技開始後

コンテストページの末尾URLがContestIdなのでテストケースを実行したい回のURLからContestIdを持ってくる

```bash
acc new {ContestId}
```
生成されたフォルダの実行したい問題の階層まで移動する

ex. A問題を実行したい場合
```bash
cd {ContestId}/a
```

テスト実行
```bash
# TypeScript
check ts-node main.ts
# Python3
check python main.py
# PyPy3
check pypy main.py
```

提出
```bash
# TypeScript
submit ts-node main.ts
# Python3
submit python main.py
# PyPy3
submit pypy main.py
```