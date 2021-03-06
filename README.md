# Pikko - iOS color picker made with ❤️

[![CI Status](https://img.shields.io/travis/melloskitten/pikko.svg?style=flat)](https://travis-ci.org/melloskitten/pikko)
[![Version](https://img.shields.io/cocoapods/v/Pikko.svg?style=flat)](https://cocoapods.org/pods/Pikko)
[![License](https://img.shields.io/github/license/melloskitten/pikko.svg?style=flat)](https://cocoapods.org/pods/Pikko)
[![Platform](https://img.shields.io/cocoapods/p/Pikko.svg?style=flat)](https://cocoapods.org/pods/Pikko)

![Demo of pikko color picker](https://raw.githubusercontent.com/melloskitten/pikko/develop/doc/demo.gif)

Pikko is a simple and beautiful color picker for iOS. It's inspired by conventional color pickers from popular graphics tools such as _Photoshop_, _Paint Tool Sai_, _Procreate_ and many others. Pikko allows the selection of hue, saturation and brightness in a more pleasant way than boring sliders.

Feel free to use, modify and improve. ✌️

## Quickstart

To run the example project, clone the repo, and run `pod install` from the Example directory first.


### Initializing Pikko programmatically, without autoconstraints

You can intialize a new color picker in the following way:

```swift
// Initialize a new Pikko instance with width and height set to 300, and initialized to blue.
let pikko = Pikko(dimension: 300, setToColor: .blue)
```

Make sure to set the Pikko delegate to get updates on color changes:

```swift
// Set the PikkoDelegate to get notified on new color changes.
pikko.delegate = self
```
Positioning Pikko:

```swift
// Set Pikko center and add it to the main view.
pikko.center = self.view.center
self.view.addSubview(pikko)
```

Manually getting a color from Pikko and setting a color:
```swift
// Getting Pikko color.
let color = pikko.getColor()

// Setting Pikko to a specific color.
pikko.setColor(.blue)
```

### Initializing Pikko programmatically, with autoconstraints

```swift

// Initialize a new Pikko instance.
let pikko = Pikko(dimension: 300, setToColor: .purple)

// Set the PikkoDelegate to get notified on new color changes.
pikko.delegate = self

// Set Pikko center and add it to the main view.
self.view.addSubview(pikko)

// Get the current color.
_ = pikko.getColor()

// Set autoconstraints.
pikko.translatesAutoresizingMaskIntoConstraints = false
pikko.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
pikko.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -200).isActive = true

```

### Initializing Pikko via Storyboard

Add a `UIView` to your Storyboard, then simply select `Pikko` as the class. You can add autoconstraints in the interface builder normally as you would with any other view.

__NOTE:__ If you're using Pikko in the storyboard, you have to set the delegate and color in the `viewDidAppear` or `viewWillAppear` methods.

```swift
@IBOutlet weak var PikkoView: Pikko!

/// If you add Pikko via interface builder and you want to set
/// a color on your picker or set the delegate, make sure to 
/// call it from this method, NOT the viewDidLoad.
override func viewDidAppear(_ animated: Bool) {
    PikkoView.delegate = self
    PikkoView.setColor(.purple)
}
```

###  Note

Regardless how you are initializing Pikko, you will have to implement the `PikkoDelegate` protocol accordingly, which will look like something along these lines:

```swift

class ViewController: UIViewController, PikkoDelegate {
...

// Delegate method that lets you get updates on the currently
// selected color.
func writeBackColor(color: UIColor) {
    // TODO: Handle received color. 
}

```

## Installation

### CocoaPods

Pikko is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Pikko'
```

### Swift Package Manager

You can also install Pikko via the [Swift Package Manager](https://swift.org/package-manager/). For this, follow the Apple tutorial on [how to add custom packages](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app), with this repository link as the package Git URL:

```
https://github.com/melloskitten/pikko
```

## Authors

Sandra, melloskitten@googlemail.com

Johannes, mail@johannesrohwer.com

## License

__Pikko__ is available under the MIT license. See the LICENSE file for more info.
