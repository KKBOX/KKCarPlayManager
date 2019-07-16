// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "KKCarPlayManager",
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
    ]
)
