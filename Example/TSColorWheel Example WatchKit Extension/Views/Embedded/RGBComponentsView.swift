import SwiftUI
import TSColorWheel

struct RGBComponentsView: View {
    @ObservedObject var colorWheelSettings = TSColorWheelSettings.shared

    var rgbComponents: (red: CGFloat, green: CGFloat, blue: CGFloat) {
        guard let cgColorSpace = CGColorSpace(name: CGColorSpace.displayP3) else {
            return (red: 0, green: 0, blue: 0)
        }

        let converted = colorWheelSettings.color.cgColor.converted(to: cgColorSpace, intent: .defaultIntent, options: nil)
        let components = converted?.components ?? []

        if components.count >= 3 {
            return (red: components[0], green: components[1], blue: components[2])
        } else {
            return (red: components[0], green: components[0], blue: components[0])
        }
    }

    var body: some View {
        GeometryReader { metrics in
            getBody(metrics: metrics)
        }
        .frame(height: 20)
    }

    func getBody(metrics: GeometryProxy) -> some View {
        let rgbComponents = self.rgbComponents

        return HStack(spacing: 0) {
            getText("R: \(Int(round(rgbComponents.red * 255)))", metrics: metrics)
            getText("G: \(Int(round(rgbComponents.green * 255)))", metrics: metrics)
            getText("B: \(Int(round(rgbComponents.blue * 255)))", metrics: metrics)
        }
    }

    func getText(_ text: String, metrics: GeometryProxy) -> some View {
        Text(text)
            .font(.footnote)
            .frame(width: metrics.size.width / 3, alignment: .leading)
    }
}
