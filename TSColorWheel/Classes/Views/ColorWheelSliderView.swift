import SwiftUI

struct ColorWheelSliderView: View {
    @ObservedObject var settings = ColorWheelSettings.shared

    func getImage(named name: String) -> UIImage {
       let bundle = Bundle(for: ColorWheelSettings.self)

       if let image = UIImage(named: name, in: bundle, with: nil) {
           return image
       }

       return .init()
   }

    @State var colorWheelSize = CGSize.zero

    var thumbCenterMinX: CGFloat {
        (colorWheelSize.width - colorWheelSize.height) / 2
    }

    var thumbCenterMaxX: CGFloat {
        (colorWheelSize.width - colorWheelSize.height) / 2 + colorWheelSize.height
    }

    let thumbCenterMinY: CGFloat = 12
    var thumbCenterMaxY: CGFloat { colorWheelSize.height + 12 }

    var thumbCenterPosition: CGPoint {
        let positionForColor = position(for: settings.hsvColor.hsColor)

        return CGPoint(
            x: positionForColor.x + thumbCenterMinX,
            y: positionForColor.y + thumbCenterMinY
        )
    }

    var body: some View {
        VStack {
            Spacer(minLength: 16)

            ZStack(alignment: .topLeading) {
                GeometryReader { metrics in
                    HStack {
                        Spacer()
                        colorWheelView(metrics)
                        Spacer()
                    }
                }
                .frame(maxHeight: 130)

                Circle()
                    .fill(Color(settings.hsvColor.uiColor))
                    .frame(maxWidth: 24, maxHeight: 24)
                    .overlay(
                        Circle()
                            .stroke(Color(settings.hsvColor.borderColor), lineWidth: 2)
                )
                    .offset(x: thumbCenterPosition.x - 12, y: thumbCenterPosition.y - 26)
            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        let clampedX = min(max(value.location.x, thumbCenterMinX), thumbCenterMaxX)
                        let clampedY = min(max(value.location.y + 12, thumbCenterMinY), thumbCenterMaxY)

                        let point = CGPoint(x: clampedX - thumbCenterMinX, y: clampedY - thumbCenterMinY)

                        let colorForPoint = color(point: point)
                        settings.hsvColor = colorForPoint.with(brightness: settings.hsvColor.brightness)
                }
            )

            Spacer(minLength: 4)
        }
    }

    func colorWheelView(_ metrics: GeometryProxy) -> some View {
        DispatchQueue.main.async {
            colorWheelSize = metrics.size
        }

        return Image(uiImage: getImage(named: "colorwheel"))
            .resizable()
            .aspectRatio(1, contentMode: .fit)
            .overlay(Color.black.opacity(Double(1 - settings.hsvColor.brightness)))
    }

    func normalize(positionInView: CGPoint) -> CGPoint {
        CGPoint(
            x: positionInView.x / colorWheelSize.height,
            y: positionInView.y / colorWheelSize.height
        )
    }

    func inverseToPositionInView(normalizedPosition: CGPoint) -> CGPoint {
        CGPoint(
            x: colorWheelSize.height * normalizedPosition.x,
            y: colorWheelSize.height * normalizedPosition.y
        )
    }

    func color(point: CGPoint) -> HSColor {
        color(normalizedPosition: normalize(positionInView: point))
    }

    func position(for color: HSColor) -> CGPoint {
        inverseToPositionInView(normalizedPosition: normalizedPosition(for: color))
    }

    func color(normalizedPosition: CGPoint) -> HSColor {
        return HSColor(
            hue: normalize(radian: -angle(normalizedPosition: normalizedPosition)) / (.pi * 2),
            saturation: min(0.5, radius(normalizedPosition: normalizedPosition)) * 2
        )
    }

    func normalizedPosition(for color: HSColor) -> CGPoint {
        let radius = color.saturation / 2
        let angle = color.hue * .pi * -2

        return CGPoint(
            x: (radius * cos(angle)) + 0.5,
            y: (radius * sin(angle)) + 0.5
        )
    }

    func radius(normalizedPosition: CGPoint) -> CGFloat {
        hypot(normalizedPosition.x - 0.5, normalizedPosition.y - 0.5)
    }

    func angle(normalizedPosition: CGPoint) -> CGFloat {
        atan2(normalizedPosition.y - 0.5, normalizedPosition.x - 0.5)
    }

    func normalize(radian: CGFloat) -> CGFloat {
        let reminder = radian.truncatingRemainder(dividingBy: .pi * 2)

        return reminder + (radian < 0 ? (.pi * 2) : 0)
    }
}
