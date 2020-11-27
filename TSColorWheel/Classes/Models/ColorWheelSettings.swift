import SwiftUI

public class ColorWheelSettings: ObservableObject {
    public static let shared = ColorWheelSettings()

    @Published public var hsvColor = HSVColor(hue: 0.66, saturation: 1, brightness: 1)
}
