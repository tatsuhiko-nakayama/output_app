## アプリケーション名
Output App

<img width="600" alt="スクリーンショット 2020-11-17 12 58 15" src="https://user-images.githubusercontent.com/70306357/99345033-b2085380-28d4-11eb-8c3d-f14170bfb752.png">


非ログイン状態でも記事の閲覧は可能です。
ゲストログインをしていただくことで記事の投稿やいいね等各アクションが可能になります。

## リンク
- URL : https://outputapp.herokuapp.com/

## 概要
日々のアウトプットを記録する日記SNS

## 特徴
- デフォルトが非公開でログアプリとして使いやすい
- インプット情報を検索してネタ探し、共有ができる

<img width="600" alt="スクリーンショット 2020-11-17 13 07 37" src="https://user-images.githubusercontent.com/70306357/99345591-fc3e0480-28d5-11eb-8620-ca6b6a7a2f1e.png">

## 開発背景
- 自己成長に集中できるログ＆コミュニケーションツールが欲しかったから
- インプットの情報源を共有したかったから


## 使用技術
- Ruby 2.6.5 / Rails 6.0.3.4
- MySQL
- JavaScript
- jQuery
- Git / GitHub
- AWS(EC2,S3,Route53)
- Nginx
- Capistrano

## 機能一覧（開発中の機能含む）

◆ユーザー機能
- deviseを使用
- ユーザーページ
  - 投稿一覧表示
  - 投稿アナリティクス表示 ※開発中
  - ステータス表示(投稿/フォロー/いいね/コメント 各総数)
  - プロフィール編集（本人のみ）
  - フォロワー数表示（本人のみ）

ログインユーザー自身のユーザーページ

<img width="600" alt="スクリーンショット 2020-11-17 13 13 13" src="https://user-images.githubusercontent.com/70306357/99345939-d2391200-28d6-11eb-8474-6314156cdc2f.png">

本人以外のユーザーページ

<img width="600" alt="スクリーンショット 2020-11-17 13 15 30" src="https://user-images.githubusercontent.com/70306357/99346023-fd236600-28d6-11eb-818b-36e2d775a637.png">

◆投稿機能
- マークダウン記法
- 画像投稿機能
- ハッシュタグ機能
- 投稿プレビュー機能 ※開発中
- カウントアップタイマー機能 ※開発中

<img width="600" alt="スクリーンショット 2020-11-17 13 05 07" src="https://user-images.githubusercontent.com/70306357/99345413-96517d00-28d5-11eb-924c-c466bfd9d048.png">

<img width="600" alt="スクリーンショット 2020-11-17 13 20 49" src="https://user-images.githubusercontent.com/70306357/99346338-bd10b300-28d7-11eb-9848-4cece72981be.png">


◆一覧表示機能
- ページネーション機能
- 画像サムネイル表示

◆検索機能
- カテゴリ別検索
- ハッシュタグ検索
- ユーザー名検索
- 投稿タイトル検索

◆トレンド表示機能 ※開発中
- 最新×人気の投稿をピックアップ

◆サジェスト機能 ※開発中
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