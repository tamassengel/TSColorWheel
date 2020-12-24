import SwiftUI

struct HSColor: Equatable {
    let hue, saturation: CGFloat

    func with(brightness: CGFloat) -> HSVColor {
        HSVColor(hue: hue, saturation: saturation, brightness: brightness)
    }
}
