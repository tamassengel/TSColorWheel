import SwiftUI
import TSColorWheel

struct EmbeddedColorWheelView: View {
    @ObservedObject var colorWheelSettings = TSColorWheelSettings.shared

    var body: some View {
        VStack(spacing: 0) {
            Spacer(minLength: 2)
            TSColorWheel()
            Spacer(minLength: 4)
            RGBComponentsView()
            Spacer(minLength: 2)
        }
        .navigationBarTitle("Embedded")
    }
}
