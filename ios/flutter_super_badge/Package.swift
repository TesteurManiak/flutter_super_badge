// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "flutter_super_badge",
    platforms: [
        .iOS("12.0")
    ],
    products: [
        .library(name: "flutter-super-badge", targets: ["flutter_super_badge"])
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework")
    ],
    targets: [
        .target(
            name: "flutter_super_badge",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework")
            ]
        )
    ]
)
