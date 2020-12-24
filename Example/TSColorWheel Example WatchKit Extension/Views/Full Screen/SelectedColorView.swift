import SwiftUI
import TSColorWheel

struct SelectedColorView: View {
    @ObservedObject var colorWheelSettings = TSColorWheelSettings.shared

    var body: some View {
        VStack(spacing: 8) {
            Text("Selected Color:")

            Circle()
                .fill(Color(colorWheelSettings.color))
                .frame(width: 24, height: 24)
                .overlay(
                    Circle()
                        .stroke(
                            Color(colorWheelSettings.borderColor),
                            lineWidth: colorWheelSettings.isLightColor ? 0 : 2
                        )
                )
        }
    }
}
