// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "KKCarPlayManager",
    platforms: [ .iOS(.v8) ],
    products: [
        .library(
            name: "KKCarPlayManager",
            targets: ["KKCarPlayManager"]),
		],
    dependencies: [
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "KKCarPlayManager",
            dependencies: []),
        .testTarget(
            name: "KKCarPlayManagerTests",
            dependencies: ["KKCarPlayManager"]),
    ],
    swiftLanguageVersions: [.v4, .v4_2, .v5]
)
