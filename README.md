## アプリケーション名
Output App

## 概要
日々のアウトプットを記録するログアプリ

## 特徴
- デフォルトが非公開なので、ログアプリとして使いやすい
- インプット情報（書籍やYoutubeなど）をハッシュタグで検索できるため、ネタ探しが簡単
- カウントアップタイマー付なので、締切効果で生産性アップ
- 積み上げを重視しているため、フォロワー数は非公開

## 開発背景
- 自己成長に集中できるログ＆コミュニケーションアプリが欲しかったから
- インプットの情報源を共有したかったから


## リンク
- URL : 制作中
- GitHubリポジトリ : https://github.com/tatsuhiko-nakayama/output_app

## 使用技術
- Ruby 2.6.5 / Rails 6.0.3.4
- MySQL
- Git / GitHub

（開発中のため随時更新）

## 利用方法

（開発中のため随時更新）

## 機能一覧（開発中の機能含む）

◆ユーザー機能
- deviseを使用
- ユーザーページ
  - 投稿一覧表示
  - 投稿アナリティクス表示
  - ステータス表示(投稿数/フォロー数/コメント数)
  - プロフィール編集（本人のみ）
  - フォロワー数表示（本人のみ）

◆投稿機能
- マークダウン記法
- ハッシュタグ機能
- 投稿プレビュー機能
- カウントアップタイマー機能

◆検索機能
- カテゴリ別検索
- ハッシュタグ検索
- ユーザー名検索
- 投稿タイトル検索

◆トレンド表示機能
- 最新×人気の投稿をピックアップ

◆サジェスト機能
- 類似投稿のサジェスト

◆フォロー機能

◆いいね機能

◆コメント機能


## ER図
![Output App ER図](https://user-images.githubusercontent.com/70306357/97796045-d9162280-1c50-11eb-8c5a-117fa3e51e60.png) 

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
- has_many :likes
- has_many :relationships
- has_many :followings, through: :relationships, source: :follow
- has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
- has_many :followers, through: :reverse_of_relationships, source: :user

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
- has_many   :likes
- has_many   :comments
- has_many   :item_tags
- has_many   :tags, through: :item_tags
- belongs_to_active_hash :category

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