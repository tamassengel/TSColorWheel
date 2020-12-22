# TSColorWheel

[![Version](https://img.shields.io/cocoapods/v/TSColorWheel.svg?style=flat)](https://cocoapods.org/pods/TSColorWheel)
[![License](https://img.shields.io/cocoapods/l/TSColorWheel.svg?style=flat)](https://cocoapods.org/pods/TSColorWheel)
[![Platform](https://img.shields.io/cocoapods/p/TSColorWheel.svg?style=flat)](https://cocoapods.org/pods/TSColorWheel)

A color wheel for watchOS based on [Colorful](https://github.com/hayashi311/Color-Picker-for-iOS)

<img src="capture.gif" alt="Screen Capture" width="180">

## Usage

TSColorWheel is a SwiftUI view which you should preferrably embed in a hosting controller:

```swift
import SwiftUI
import TSColorWheel
import WatchKit

class HostingController: WKHostingController<TSColorWheel> {
    override var body: TSColorWheel {
        TSColorWheel()
    }
}
```

You can access the selected color with `TSColorWheelSettings.shared.hsvColor`.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

watchOS 6.0

## Installation

TSColorWheel is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'TSColorWheel'
```

## Author

Tamás Sengel

## License

TSColorWheel is available under the MIT license. See the LICENSE file for more info.
