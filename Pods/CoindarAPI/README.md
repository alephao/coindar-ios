# CoindarAPI

[![CI Status](https://img.shields.io/travis/alaphao/CoindarAPI.svg?style=flat)](https://travis-ci.org/alaphao/CoindarAPI)
[![Version](https://img.shields.io/cocoapods/v/CoindarAPI.svg?style=flat)](https://cocoapods.org/pods/CoindarAPI)
[![License](https://img.shields.io/cocoapods/l/CoindarAPI.svg?style=flat)](https://cocoapods.org/pods/CoindarAPI)
[![Platform](https://img.shields.io/cocoapods/p/CoindarAPI.svg?style=flat)](https://cocoapods.org/pods/CoindarAPI)
[![Swift 4.2](https://img.shields.io/badge/Swift-4.2-orange.svg?style=flat)](https://developer.apple.com/swift/)

A wrapper around the [Coindar API](https://coindar.org/en/api) written in Swift

## Quick Start

Import `CoindarAPI` and create an instance of `Coindar` with your token.

You can get a Coindar token [here](https://coindar.org/en/api/tokens)

```swift
import CoindarAPI

let api = Coindar(token: "MyCoindarToken")
```

Available methods:

```swift
func getEvents(params: EventsParams, onSuccess: ([Event]) -> Void, onError: (Error) -> Void) -> Cancellable

func getCoins(progress: (Double) -> Void, onSuccess: ([Coin]) -> Void, onError: (Error) -> Void) -> Cancellable

func getTags(progress: (Double) -> Void, onSuccess: ([Tag]) -> Void, onError: (Error) -> Void) -> Cancellable

func getSocial(coins: [Coin], onSuccess: ([Social]) -> Void, onError: (Error) -> Void) -> Cancellable
```

## Installation

CoindarAPI is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CoindarAPI'
```

## License

CoindarAPI is available under the MIT license. See the LICENSE file for more info.
