import PlaygroundSupport
import UIKit
import CoindarFramework
import CoindarAPI
import Moya
import CoindarMocks

Current.coindar = CoindarMock(getCoinsResponse: .progressAndSuccess,
                              getTagsResponse: .progressAndSuccess)

let viewController = SplashViewController()

PlaygroundPage.current.liveView = viewController
