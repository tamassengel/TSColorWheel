import SwiftUI

public struct TSColorWheel: View {
    public init() { }

    public var body: some View {
        GeometryReader { metrics in
        VStack {
                ColorWheelSliderView()
                Spacer(minLength: 10)
                ColorBrightnessSliderView(containerSize: metrics.size)
            }
        }
        
    }
}
