// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ApiariumConnect",
    platforms: [
        .macOS(.v12)
    ],
    products: [
        .executable(name: "ApiariumConnect", targets: ["ApiariumConnect"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/vapor/vapor",
            from: "4.70.0"
        ),
    ],
    targets: [
        .executableTarget(
            name: "ApiariumConnect",
            dependencies: [
                .product(name: "Vapor", package: "vapor")
            ],
            path: "Sources"
        ),
        .testTarget(
            name: "ApiariumConnectTests",
            dependencies: ["ApiariumConnect"],
            path: "Tests"
        ),
    ]
)
