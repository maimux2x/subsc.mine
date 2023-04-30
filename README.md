# Subsc.mine
![OGP](https://user-images.githubusercontent.com/76797372/235334976-87bd86ed-06d3-49ed-b884-1bc82244a7e6.png)
## 概要
Subsc.mineは複数のサブスクリプションサービスを契約している人向けの、利用サブスク一覧ツールです。
利用しているサブスクと更新日を一覧画面で確認することができ、自動でカレンダーアプリに更新日を連携することが可能です。
### 特徴
- 以下の項目を登録し、一覧画面で確認が可能です
  - サービス名
  - お支払基準日
  - 次回お支払日
  - 金額
  - ステータス（継続中か停止中か）
  - 周期
- お支払基準日から次回お支払日を ***本日*** を起点に自動で計算します
- iCalendar形式でカレンダーアプリと連携が可能です
- 一時的にサブスクの利用を止める場合、ステータスを「停止」に変更し、カレンダー連携から除外できます
- 停止から再開する場合、新しいお支払基準日を設定すると改めて次回お支払日を算出しカレンダーと連携できます

### 使い方
#### 1. Googleアカウントでログインする

<img width="25%" alt="カレンダー連携" src="https://user-images.githubusercontent.com/76797372/235335062-1e6cb8e0-e0d7-4a5b-8e5e-5dae2c01b7bf.png">


#### 2. 新規登録画面から必要情報を入力して保存する

<img width="10%" alt="カレンダー連携" src="https://user-images.githubusercontent.com/76797372/235335041-ba438ae0-7283-47d1-9356-f03aef2c5ef4.png">

#### 3. 一覧画面にデータが反映される

<img width="25%" alt="カレンダー連携" src="https://user-images.githubusercontent.com/76797372/235335069-b3539449-f91d-4879-848a-9f2dce4a4609.png">

マイアカウントURLをクリックすると別タブで該当のリンクに飛ぶことができます。

#### 4. カレンダーと連携する
カレンダー連携ボタンをクリックします。

<img width="25%" alt="カレンダー連携1" src="https://user-images.githubusercontent.com/76797372/235335339-690745e2-1b04-4fe9-9434-e07b088eb756.png">

連携の説明が表示されるため、「カレンダーと連携する」をクリックします。

<img width="25%" alt="カレンダー連携2" src="https://user-images.githubusercontent.com/76797372/235335109-6e1b349e-d354-47ba-9f94-f47a179b3670.png">

連携用のURLが発行されるため「照会」をクリックします。

<img width="25%" alt="カレンダー連携" src="https://user-images.githubusercontent.com/76797372/235335193-dbca4bdb-a528-4523-9072-4ccfe615619c.png">

連携用の名前や更新間隔を設定して保存します。

<img width="25%" alt="カレンダー連携" src="https://user-images.githubusercontent.com/76797372/235335216-4955992d-3992-48e6-b4c5-fd53bad2a269.png">

Googleカレンダーと連携する場合は連携用のURLをコピーして、「他のカレンダー > + マーク > URLで追加」から連携が可能です。
※Googleカレンダーとの連携はPCからのみ操作ができます。
<img width="25%" alt="カレンダー連携5" src="https://user-images.githubusercontent.com/76797372/235335030-7eb9b69d-7284-43e3-ac9b-aa83da8e5ebc.png">


このカレンダー連携操作は一度URLをカレンダーと連携するのみで、それ以降は新規データの登録をSubsc.mine上で行っていただくと自動で次回お支払日が連携されます。

### 技術スタック
- Ruby 3.1.0
- Ruby on Rails 7.0.4
- Hotwire

### インストール

```
$ bundle install
$ foreman start -f Procfile.dev
```

#### 環境変数

| 環境変数名 | 説明 |
|---|---|
| GOOGLE_ID | GoogleクライアントID |
| GOOGLE_SECRET | Googleクライアント シークレット |

#### テスト

```
$ bundle exec rspec
```

#### lint

```
$ bundle exec rubocop
$ bundle exec slim-lint app/views -c .slim-lint.yml
$ yarn fix
```
