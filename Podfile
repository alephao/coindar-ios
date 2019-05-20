using_bundler = defined? Bundler
unless using_bundler
    puts "\nPlease re-run using Bundler:".red
    puts "  bundle exec pod #{ARGV.join(" ")}\n\n"
    exit!
end

platform :ios, '10.0'
use_frameworks!

abstract_target 'App' do
  pod 'CoindarAPI', '~> 1.1.6'
  pod 'SnapKit'
  pod 'Overture', '~> 0.5'
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxDataSources'
  pod 'Nuke', '~> 7.0'

  target 'Coindar'
  target 'CoindarFramework'
  target 'CoindarTests'
end

target 'CoindarMocks' do
  pod 'CoindarAPI', '~> 1.1.6'
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'Fakery'
end
