## アプリケーション概要
Output App

width: 400px

<kbd><img width="398" alt="スクリーンショット 2020-12-01 16 20 10" src="https://user-images.githubusercontent.com/70306357/100709516-9da67980-33f1-11eb-9e2d-62bed4e86c40.png"></kbd>

width: 1024px

<kbd><img width="1021" alt="スクリーンショット 2020-12-01 16 25 21" src="https://user-images.githubusercontent.com/70306357/100709665-dd6d6100-33f1-11eb-88ac-36a8b4130e74.png"></kbd>


非ログインでも記事の閲覧は可能です。
ログインしていただくことで記事の投稿やいいね等各アクションが可能になります。

最小画面サイズ => 320pxまで対応しています。

## リンク
- URL : http://output-app.com

## ジャンル
日々のアウトプットを記録する日記SNS

## 特徴
- デフォルトが非公開
- インプット情報を検索できる
- 週間のログ状況を表示

フォロワーやいいねを集めるためではなく、気軽にアウトプットをするための機能を揃えています。

## 開発背景
- 既存のSNSでは吐き出せないことを吐き出せるアプリを作りたい
- アウトプットをしやすい環境を作って人の成長や喜びに貢献したい

## 影響を受けた本
- ゼロ秒思考

## 使用技術
- Ruby 2.6.5 / Rails 6.0.3.4
- MySQL
- JavaScript
- jQuery
- Git / GitHub
- AWS(EC2,S3,Route53)
- Nginx
- Capistrano

## 機能一覧

◆ユーザー系
- ユーザーページ
  - ユーザーインフォメーション
  - アクション数
  - 週間アナリティクス
  - 投稿一覧

<kbd><img width="597" alt="スクリーンショット 2020-12-01 16 36 35" src="https://user-images.githubusercontent.com/70306357/100710715-79e43300-33f3-11eb-8935-c54538f323b7.png"></kbd>


◆投稿
- 公開選択
- 画像投稿
- ハッシュタグ登録
- マークダウン

<kbd><img width="488" alt="スクリーンショット 2020-12-01 16 42 52" src="https://user-images.githubusercontent.com/70306357/100711202-4ce45000-33f4-11eb-9a97-989dc62e620c.png"></kbd>

◆一覧表示
- ページネーション
- 画像サムネイル表示

◆検索
- カテゴリ
- ハッシュタグ
- ユーザー
- タイトル

◆その他機能
- いいね
- コメント
- タイムライン
- SNSシェア
- 通知
- スマホ用コマンド


## ER図
![Output App ER図 (1)](https://user-images.githubusercontent.com/70306357/100713974-7901d000-33f8-11eb-9d74-971ba1cfa135.png)

## テーブル設計

### users テーブル

| Column       | Type    | Options                   |
| ------------ | ------- | ------------------------- |
| username     | string  | null: false, unique: true |
| email        | string  | null: false               |
| password     | string  | null: false               |

### Association

- has_one  :profile
- has_many :items
- has_many :comments
- has_many :commented_items, through: :comments, source: :item
- has_many :likes
- has_many :liked_items, through: :likes, source: :item
- has_many :relationships
- has_many :followings, through: :relationships, source: :follow
- has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
- has_many :followers, through: :reverse_of_relationships, source: :user
- has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id'
- has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id'

### profiles テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| lastname     | string     |                                |
| firstname    | string     |                                |
| website      | string     |                                |
| intro        | text       |                                |
| user         | references | null: false, foreign_key: true |

### Association

- belongs_to       :user
- has_one_attached :image

### relationships テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| user         | references | null: false, foreign_key: true |
| follow       | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :follow, class_name: 'User'

### items テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| title        | string     | null: false                    |
| url          | string     |                                |
| tagbody      | string     |                                |
| body         | text       | null: false                    |
| status       | integer    | null: false, default: 0        |
| category_id  | integer    | null: false                    |
| user         | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :likes
- has_many :liked_users, through: :likes, source: :user
- has_many :comments
- has_many :commented_users, through: :comments, source: :user
- has_many :item_tags
- has_many :tags, through: :item_tags
- belongs_to_active_hash :category
- has_one_attached :image
- has_many :notifications, dependent: :destroy

### tags テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| name         | string     || null: false, unique: true     |

### Association

- has_many :item_tags
- has_many :items, through: :item_tags

### item_tags テーブル

| Column | Type       | Options           |
| ------ | ---------- | ----------------- |
| item   | references | foreign_key: true |
| tag    | references | foreign_key: true |

### Association

- belongs_to :item
- belongs_to :tag

### likes テーブル

| Column | Type       | Options           |
| ------ | ---------- | ----------------- |
| user   | references | foreign_key: true |
| item   | references | foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item

### comments テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| message | text       | null: false                    |
| user    | references | null: false, foreign_key: true |
| item    | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_many :notifications

### notification テーブル

| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| visitor_id | integer    | null: false                    |
| visited_id | integer    | null: false                    |
| item_id    | integer    |                                |
| comment_id | integer    |                                |
| action     | string     | null: false, default: ''       |
| checked    | boolean    | null: false, default: false    |

### Association

- belongs_to :item, optional: true
- belongs_to :comment, optional: true
- belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
- belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true