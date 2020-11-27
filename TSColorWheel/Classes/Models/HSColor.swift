import SwiftUI

public struct HSColor: Equatable {
    public let hue, saturation: CGFloat

    public func with(brightness: CGFloat) -> HSVColor {
        return HSVColor(hue: hue, saturation: saturation, brightness: brightness)
    }
}
