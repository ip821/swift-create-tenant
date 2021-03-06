// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
        name: "CreateTenant",
        platforms: [
            .macOS(.v10_15)
        ],
        dependencies: [
            .package(url: "https://github.com/Swinject/Swinject.git", from: "2.8.0"),
            .package(url: "https://github.com/uhooi/swift-http-client", .upToNextMajor(from: "0.6.0")),
            .package(url: "https://github.com/onevcat/Rainbow", .upToNextMajor(from: "4.0.0"))
        ],
        targets: [
            // Targets are the basic building blocks of a package. A target can define a module or a test suite.
            // Targets can depend on other targets in this package, and on products in packages this package depends on.
            .target(
                    name: "CrsServerConnection",
                    dependencies: [
                        .product(name: "HTTPClient", package: "swift-http-client"),
                    ]),
            .target(
                    name: "CrsSecurity",
                    dependencies: [
                        .target(name: "CrsServerConnection")
                    ]),
            .target(
                    name: "CrsAppBuilder",
                    dependencies: [
                        .target(name: "CrsServerConnection")
                    ]),
            .target(
                    name: "CrsGateway",
                    dependencies: [
                        .target(name: "CrsServerConnection")
                    ]),
            .executableTarget(
                    name: "CreateTenant",
                    dependencies: [
                        .target(name: "CrsSecurity"),
                        .target(name: "CrsGateway"),
                        .target(name: "CrsAppBuilder"),
                        "Rainbow",
                        "Swinject"
                    ]),
//            .testTarget(
//                    name: "CreateTenantTests",
//                    dependencies: ["CreateTenant"]),
        ]
)
