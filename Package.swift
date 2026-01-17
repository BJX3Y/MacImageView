// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "ImageViewer",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .executable(
            name: "ImageViewer",
            targets: ["ImageViewer"]
        )
    ],
    targets: [
        .executableTarget(
            name: "ImageViewer",
            path: "Sources"
        )
    ]
)
