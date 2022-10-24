#!/bin/bash

# Step: Bundler
if ! command -v bundle >/dev/null 2>&1; then
  echo "Please install bundler before proceeding (run `gem install bundler`)"
  exit 1
fi
bundle install

# Step: Cocoapods
if ! command -v pod >/dev/null 2>&1; then
  echo "Please install Cocoapods before proceeding (run `gem install cocoapods`)"
  exit 1
fi
bundle exec pod install


cp SampleConfig.swift Config.swift
