import SwiftUI
import TSColorWheel
import WatchKit

class HostingController: WKHostingController<TSColorWheel> {
    override var body: TSColorWheel {
        return TSColorWheel()
    }
}
