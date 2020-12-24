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
    }

    func getBody(metrics: GeometryProxy) -> some View {
        let rgbComponents = self.rgbComponents

        return HStack(spacing: 0) {
            getComponent(label: "R", componentValue: rgbComponents.red, metrics: metrics)
            getComponent(label: "G", componentValue: rgbComponents.green, metrics: metrics)
            getComponent(label: "B", componentValue: rgbComponents.blue, metrics: metrics)
        }
    }

    func getComponent(label: String, componentValue: CGFloat, metrics: GeometryProxy) -> some View {
        HStack(spacing: 0) {
            Spacer()

            Text("\(label):")
                .font(.system(size: 12))
                .bold()
                .frame(width: 16)

            Text("\(Int(round(componentValue * 255)))")
                .font(.system(size: 12))
                .frame(width: 22, alignment: .trailing)

            Spacer()
        }
        .frame(width: metrics.size.width / 3)
    }
}
