using_bundler = defined? Bundler
unless using_bundler
    puts "\nPlease re-run using Bundler:".red
    puts "  bundle exec pod #{ARGV.join(" ")}\n\n"
    exit!
end

platform :ios, '10.0'
use_frameworks!

abstract_target 'App' do
  pod 'CoindarAPI', '~> 1.1.2'
  pod 'SnapKit'
  pod 'Overture', '~> 0.3'
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxDataSources'
  pod 'ReSwift'

  target 'Coindar' do
  end
  
  target 'CoindarFramework' do
  end

  target 'CoindarTests'
end
