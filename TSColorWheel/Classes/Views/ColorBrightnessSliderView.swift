import SwiftUI

struct ColorBrightnessSliderView: View {
    @ObservedObject var settings = ColorWheelSettings.shared

    let containerSize: CGSize

    var gradientWidth: CGFloat { thumbCenterMaxX - thumbCenterMinX }
    let gradientPadding: CGFloat = 14

    var brightness: CGFloat { settings.hsvColor.brightness }

    var thumbCenterX: CGFloat {
        thumbCenterMaxX - brightness * gradientWidth - thumbSize / 2
    }

    var thumbCenterMinX: CGFloat { gradientPadding }
    var thumbCenterMaxX: CGFloat { containerSize.width - gradientPadding }
    let thumbSize: CGFloat = 24

    var body: some View {
        ZStack(alignment: .leading) {
            LinearGradient(
                gradient: Gradient(
                    colors: [
                        Color(settings.hsvColor.hsColor.with(brightness: 1).uiColor),
                        .black
                    ]
                ),
                startPoint: UnitPoint(x: 0, y: 0),
                endPoint: UnitPoint(x: 1, y: 0)
            )
            .frame(maxHeight: 12)
            .cornerRadius(6)
            .padding([.leading, .trailing], gradientPadding)

            Circle()
                .fill(Color(settings.hsvColor.uiColor))
                .frame(maxWidth: thumbSize, maxHeight: thumbSize)
                .overlay(
                    Circle()
                        .stroke(Color(settings.hsvColor.borderColor), lineWidth: 2)
                )
                .offset(x: thumbCenterX)
        }
        .frame(minHeight: 30)
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { value in
                    let positionX = min(max(value.location.x, thumbCenterMinX), thumbCenterMaxX) - thumbCenterMinX
                    let brightness = 1 - positionX / gradientWidth
                    settings.hsvColor.brightness = brightness
                }
        )
    }
}
