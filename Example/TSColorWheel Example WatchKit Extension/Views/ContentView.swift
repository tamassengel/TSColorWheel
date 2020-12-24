import SwiftUI
import TSColorWheel

struct ContentView: View {
    @ObservedObject var colorWheelSettings = TSColorWheelSettings.shared

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            Image(Asset.appIconRounded.name)

            Spacer(minLength: 4)

            Text("TSColorWheel")
                .bold()

            Spacer(minLength: 8)

            NavigationLink("Full Screen", destination: FullScreenColorWheelSelectedColorView())
                .buttonStyle(CustomButtonStyle())

            Spacer(minLength: 4)

            NavigationLink("Embedded", destination: EmbeddedColorWheelView())
                .buttonStyle(CustomButtonStyle())

            Spacer()
        }
    }
}
