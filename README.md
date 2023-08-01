# [Debu Prison]

## サービス概要
Debu Prisonは、ダイエットを継続したい人に向けた
プラットフォームサービスです。
https://debuprison.com/

## 想定されるユーザー層
ダイエットを継続したいが、一人では継続できなかった人
ダイエット仲間が欲しい人
ダイエットを始めたいと思っている人
らんてっくダイエット部員

## このサービスの背景
私はひょんなことから、RUNTEQコミュニティ内のダイエット部に入部しました。
しかし私はどちらかというと痩せ型の体型のため、他の部員を取り締まるデブ警察に就任しました。
ダイエット部員たちはしばしばラーメンなど高カロリーなものを食べ、SNSに投稿しているため
それらを取り締まるサービスの必要性を感じ、このアプリの作成に至りました。
なお自身も中年太りが始まっているので自身でも使いたいアプリを目指しています。

## サービスコンセプト
この「Debu Prison」Webアプリが解決しようとする主な課題は次の通りです：

モチベーションの維持: ダイエットや健康的な生活習慣を維持する最大の挑戦の一つはモチベーションを維持することです。アプリは進捗を視覚的に表示し、ユーザーが自分で設定した目標を達成したときにバッジを付与するなど、モチベーションを引き立てる要素を提供します。

適切な情報の提供: 適切なダイエットや運動方法についての情報は多種多様で、何が最適か判断するのは困難です。このアプリは、基本的なダイエット情報や健康的な食事・運動方法についてのリソースを提供することで、ユーザーが適切な知識を得る手助けをします。

一貫性の維持: 日々の食事や運動の習慣を記録することは、一貫性を保つ上で有効です。しかし、これを手動で行うのは時間と労力を要します。このアプリはユーザーが簡単に食事や運動を記録でき、自動的にカロリーや栄養素を計算します。

個々の進捗の追跡: ユーザーがダイエットの進捗を正確に把握することは、成功への道のりを理解し、必要な調整を行うために重要です。アプリは個々のダッシュボードを提供し、ユーザーが自分の進捗を追跡できるようにします。

コミュニティの欠如: ダイエットは孤独な経験になりがちで、これが挫折につながることもあります。アプリ内のコミュニティフォーラムはユーザーが互いに支え合い、経験や知識を共有できる場を提供します。

## 実装を予定している機能
### MVP
* 会員登録
* ログイン（ゲストログインも作る予定）
* 進捗ダッシュボード（グラフで目標と日々の消費・摂取カロリーを表示。）
* 目標設定と進捗追跡
* コミュニティフォーラム
* 食事と運動の記録機能（自動でカロリー計算）
* プロフィール機能(公開設定も付けたい。体重を他の人に見せないなど。)
* 投稿などにはtwitter投稿ボタン付ける
* 利用規約とプライバシーポリシー（健康を損なうダイエットはしないようダッシュボード等でも注記したい）

### その後の機能
* 食事のレコメンド機能（API使った自動レコメンド）
* チャレンジとリワード（バッジ機能）
* イベント機能（一定期間で〇〇運動など）
* ダイエット情報（コラムみたいなの）
* 進捗ダッシュボード機能追加（カレンダー、体脂肪率など）
* 既存のヘルスデバイスとの連携（Apple Watchなど）

https://www.figma.com/file/wlCx53FhaGrOURnEpFs1ML/diet_challenge?type=design&node-id=0%3A1&mode=design&t=ybv9J5Ez5aKTb7H9-1 

### 使用技術
全体の構成
バックエンド
Ruby(3.2.2)
Ruby on Rails(7.0.6)

フロントエンド
TailwindCSS
daisyUI

インフラ
PostgreSQL
Fly.io
AWS(Amazon S3)

API	その他
DeepL API
Nutrition by API-Ninjas API(RapidAPI)	Cloudflare(独自ドメインの SSL 化)
Google アナリティクス(GA4)
Google サーチコンソール

主要ライブラリ（gem）
devise（ユーザー登録、ログイン/ログアウト、パスワードリセット）
kaminari（ページネーション）
simple_calendar（カレンダー機能）
rails-i18n（i18n 国際化対応）
enum_help（enum 定義の i18n）
config（環境別の定数管理）
sitemap_generator（サイトマップの作成）
meta-tags（OGP、メタタグの設定）
faraday（HTTP クライアント）
なお、画像アップロードにはCarrierwaveを使用
