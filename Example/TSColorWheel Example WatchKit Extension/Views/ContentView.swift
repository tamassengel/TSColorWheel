import SwiftUI
import TSColorWheel

struct ContentView: View {
    @ObservedObject var colorWheelSettings = TSColorWheelSettings.shared

    var body: some View {
        VStack(spacing: 6) {
            Spacer()

            Image(Asset.appIconRounded.name)

            Text("TSColorWheel")
                .bold()

            Spacer(minLength: 0)

            NavigationLink("Full Screen", destination: FullScreenColorWheelSelectedColorView())
                .buttonStyle(CustomButtonStyle())

            NavigationLink("Embedded", destination: EmbeddedColorWheelView())
                .buttonStyle(CustomButtonStyle())

            Spacer()
        }
    }
}
