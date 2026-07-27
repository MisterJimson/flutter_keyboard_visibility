// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "flutter_keyboard_visibility",
    platforms: [
        .iOS("13.0")
    ],
    products: [
        .library(
            name: "flutter-keyboard-visibility",
            targets: ["flutter_keyboard_visibility"]
        )
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework")
    ],
    targets: [
        .target(
            name: "flutter_keyboard_visibility",
            dependencies: [
                .product(
                    name: "FlutterFramework",
                    package: "FlutterFramework"
                )
            ],
            cSettings: [
                .headerSearchPath("include/flutter_keyboard_visibility")
            ]
        )
    ]
)
