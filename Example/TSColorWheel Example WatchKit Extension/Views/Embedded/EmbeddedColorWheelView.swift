import SwiftUI
import TSColorWheel

struct EmbeddedColorWheelView: View {
    @ObservedObject var colorWheelSettings = TSColorWheelSettings.shared

    var body: some View {
        GeometryReader { metrics in
            VStack(spacing: 0) {
                Spacer(minLength: 2)

                TSColorWheel()
                    .frame(height: metrics.size.height - 40)

                Spacer()

                RGBComponentsView()
                
                Spacer(minLength: 2)
            }
        }
        .navigationBarTitle("Embedded")
        .edgesIgnoringSafeArea(.bottom)
    }
}
