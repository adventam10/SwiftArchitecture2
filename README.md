# SwiftArchitecture2 (fat_fat_fat)
[これ](https://github.com/adventam10/SwiftArchitecture)の再考版

iOSアプリのアーキテクチャについて考える

master は Cocoa MVC を意識して作成しました。

[livedoor天気のWeb API](http://weather.livedoor.com/weather_hacks/webservice)(商用利用不可)を利用した各都道府県の天気を表示するアプリ。

アーキテクチャは意識せずとにかくViewControllerのみで作りました！

## 環境
* Xcode 11.4
* Target iOS 12.0
* iPhone (Portrait)

## アプリ
| 一覧 | 地方フィルター | お天気 |
| --- | --- | --- |
| ![prefecture_list](https://user-images.githubusercontent.com/34936885/78892673-c1086700-7aa4-11ea-94d9-930932220219.png) | ![area_filter](https://user-images.githubusercontent.com/34936885/78892763-eb5a2480-7aa4-11ea-9208-679b9a7afeed.png) | ![weather](https://user-images.githubusercontent.com/34936885/78892837-09c02000-7aa5-11ea-922a-cb4e31e0164e.png) |

### 一覧
* 都道府県一覧を表示する
* お気に入り登録ができる
* お気に入りで絞り込み表示ができる
* 地方で絞り込み表示ができる
* 都道府県選択でお天気を取得してお天気画面に遷移する

### 地方フィルター
* 地方で絞り込み表示ができる

### お天気
* 3日分の天気を表示する
* リフレッシュボタンで天気を再取得