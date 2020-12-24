import WatchKit

internal enum Asset {
    static let appIconRounded = ImageAsset(name: "app_icon_rounded")
}

internal struct ImageAsset {
    let name: String
    var image: UIImage { .init(imageLiteralResourceName: name) }
}
