import Combine
import SwiftUI

public struct TSColorWheel: View {
    @ObservedObject var settings = TSColorWheelSettings.shared

    var dragGesture: some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { value in
                let clampedX = min(max(value.location.x, thumbCenterMinX), thumbCenterMaxX)
                let clampedY = min(max(value.location.y, thumbCenterMinY), thumbCenterMaxY)

                let point = CGPoint(x: clampedX - thumbCenterMinX, y: clampedY - thumbCenterMinY)

                let colorForPoint = color(point: point)
                settings.hsvColor = colorForPoint.with(brightness: settings.hsvColor.brightness)
            }
    }

    @State var didAppear = false

    @State var digitalCrownValue = 0.0

    @State var containerSize = CGSize.zero

    var thumbCenterMinX: CGFloat { (containerSize.width - colorWheelSize) / 2 }
    var thumbCenterMaxX: CGFloat { thumbCenterMinX + colorWheelSize }
    var thumbCenterMinY: CGFloat { 0 }
    var thumbCenterMaxY: CGFloat { thumbCenterMinY + colorWheelSize }

    let thumbSize: CGFloat = 24

    var thumbCenterPosition: CGPoint {
        let positionForColor = position(for: settings.hsvColor.hsColor)

        return .init(x: positionForColor.x, y: positionForColor.y)
    }

    var colorWheelSize: CGFloat {
        max(0, min(containerSize.width, containerSize.height) - thumbSize - 1)
    }

    public var body: some View {
        GeometryReader { metrics in
            VStack {
                Spacer()

                ZStack(alignment: .topLeading) {
                    HStack {
                        Spacer()
                        colorWheelView(metrics)
                            .frame(width: colorWheelSize)
                        Spacer()
                    }

                    Circle()
                        .fill(Color(settings.color))
                        .frame(width: thumbSize, height: thumbSize)
                        .overlay(
                            Circle()
                                .stroke(Color(settings.borderColor), lineWidth: 2)
                        )
                        .offset(
                            x: thumbCenterPosition.x + (metrics.size.width - colorWheelSize - thumbSize) / 2,
                            y: thumbCenterPosition.y - thumbSize / 2
                        )
                }
                .gesture(dragGesture)

                Spacer()
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .focusable(true)
        .digitalCrownRotation(
            $digitalCrownValue,
            from: 0,
            through: 255,
            by: 1,
            sensitivity: .medium,
            isHapticFeedbackEnabled: false
        )
        .onAppear() {
            didAppear = true
            digitalCrownValue = 255 - Double(round(settings.hsvColor.brightness * 255))
        }
        .onReceive(Just(digitalCrownValue)) { amount in
            if didAppear {
                DispatchQueue.main.async {
                    settings.hsvColor.brightness = CGFloat((255 - digitalCrownValue) / 255)
                }
            }
        }
    }

    public init() { }

    func colorWheelView(_ metrics: GeometryProxy) -> some View {
        DispatchQueue.main.async {
            containerSize = metrics.size
        }

        return Image(uiImage: getImage(named: "colorwheel"))
            .resizable()
            .aspectRatio(1, contentMode: .fit)
            .overlay(Color.black.opacity(Double(1 - settings.hsvColor.brightness)))
    }

    func normalize(positionInView: CGPoint) -> CGPoint {
        CGPoint(
            x: positionInView.x / colorWheelSize,
            y: positionInView.y / colorWheelSize
        )
    }

    func inverseToPositionInView(normalizedPosition: CGPoint) -> CGPoint {
        CGPoint(
            x: colorWheelSize * normalizedPosition.x,
            y: colorWheelSize * normalizedPosition.y
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
        radian.truncatingRemainder(dividingBy: .pi * 2) + (radian < 0 ? (.pi * 2) : 0)
    }

    func getImage(named name: String) -> UIImage {
        let bundle = Bundle(for: TSColorWheelSettings.self)

        if let image = UIImage(named: name, in: bundle, with: nil) {
            return image
        }

        return .init()
    }
}
