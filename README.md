# SwiftArchitecture2 (mvvm)
[これ](https://github.com/adventam10/SwiftArchitecture)の再考版

iOSアプリのアーキテクチャについて考える

[livedoor天気のWeb API](http://weather.livedoor.com/weather_hacks/webservice)(商用利用不可)を利用した各都道府県の天気を表示するアプリ。

MVVM (ReactiveSwift) を意識して作成しました！

## 環境
* Xcode 11.4
* Target iOS 12.0
* iPhone (Portrait)

## 使用ライブラリ
Cocoa Pods で導入（プル後にすぐビルドできるように Carthage ではなく Cocoa Pods を利用）

| ライブラリ | 用途 |
| --- | --- |
| [pkluz/PKHUD](https://github.com/pkluz/PKHUD) | プログレスの表示 |
| [Alamofire/Alamofire](https://github.com/Alamofire/Alamofire) | 通信 |
| [Ahmed-Ali/JSONExport](https://github.com/Ahmed-Ali/JSONExport) | JSONパース用（ファイルを作成） |
| [realm/SwiftLint](https://github.com/realm/SwiftLint) | Lint ツール |
| [mono0926/LicensePlist](https://github.com/mono0926/LicensePlist) | ライセンス表記用（ライセンス表記は大事😇） |
| [mac-cain13/R.swift](https://github.com/mac-cain13/R.swift) | リソースファイルのコード補完 (標準装備にしたい) |
| [ReactiveCocoa/ReactiveSwift](https://github.com/ReactiveCocoa/ReactiveSwift) | バインディングしたい |
| [ReactiveCocoa/ReactiveCocoa](https://github.com/ReactiveCocoa/ReactiveCocoa) | バインディングしたい |

## Scheme
* SwiftArchitecture2  
通信してデータを取得する
* DummySwiftArchitecture2  
通信はせずプロジェクト内のJSONファイルを取得する

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
