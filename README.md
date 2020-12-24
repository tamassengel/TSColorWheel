<img src="https://raw.githubusercontent.com/tamassengel/TSColorWheel/master/readme_images/icon.png" width="100">

# TSColorWheel

[![Version](https://img.shields.io/cocoapods/v/TSColorWheel.svg?style=flat)](https://cocoapods.org/pods/TSColorWheel)
[![License](https://img.shields.io/cocoapods/l/TSColorWheel.svg?style=flat)](https://cocoapods.org/pods/TSColorWheel)
[![Platform](https://img.shields.io/cocoapods/p/TSColorWheel.svg?style=flat)](https://cocoapods.org/pods/TSColorWheel)

A color wheel for watchOS based on [Colorful](https://github.com/hayashi311/Color-Picker-for-iOS) that uses the Digital Crown as a brightness slider.

<img src="https://raw.githubusercontent.com/tamassengel/TSColorWheel/master/readme_images/capture.gif" alt="Screen Capture" width="180">

## Usage

You can use `TSColorWheelController` in your storyboard (recommended), or alternatively, use `TSColorWheel` in a SwiftUI view structure.

### Usage in the Storyboard

To use TSColorWheel in the storyboard, add a new Hosting Controller and change its Custom Class as follows:

**Class:** TSColorWheelController  
**Module:** TSColorWheel

Make sure to **uncheck** Inherit Module From Target.

<img src="https://raw.githubusercontent.com/tamassengel/TSColorWheel/master/readme_images/storyboard_custom_class.png" alt="Screen Capture" width="263">

### Usage in a SwiftUI view structure

Just use  `TSColorWheel` as a normal SwiftUI view.

```swift
var body: some View {
    VStack {
        Text("Select a Color")
        TSColorWheel()
    }
}
```

### Attributes

To get all the different attributes and modify the selected color from SwiftUI, initialize `TSColorWheelSettings.shared` as an `ObservedObject`:

```swift
@ObservedObject var colorWheelSettings = TSColorWheelSettings.shared
```

You can **get/set the currently selected color** with `colorWheelSettings.color`.

To get the **border color** TSColorWheel is currently using for the thumb view, use `colorWheelSettings.borderColor`.

To get whether **a color is light or dark**, use `colorWheelSettings.isLightColor`.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

watchOS 6.0

## Installation

TSColorWheel is available through [CocoaPods](https://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod 'TSColorWheel'
```

## Author

Tamás Sengel  
https://tamassengel.ml

## License

TSColorWheel is available under the MIT license. See the LICENSE file for more info.
