// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "KKCarPlayManager",
    platforms: [ .iOS(.v8) ],
    products: [
        .library(
            name: "KKCarPlayManager",
            targets: ["KKCarPlayManager"]),
		.library(
			name: "KKCarPlayManagerExtension",
			targets: ["KKCarPlayManagerExtensions"]),
		],
    dependencies: [
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "KKCarPlayManager",
            dependencies: []),
        .target(
            name: "KKCarPlayManagerExtensions",
            dependencies: ["KKCarPlayManager"]),
        .testTarget(
            name: "KKCarPlayManagerTests",
            dependencies: ["KKCarPlayManager"]),
    ],
    swiftLanguageVersions: [.v4, .v4_2, .v5]
)
