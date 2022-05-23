// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
        name: "CreateTenant",
        platforms: [
            .macOS(.v10_15)
        ],
        dependencies: [
            .package(url: "https://github.com/swift-server/async-http-client.git", from: "1.9.0"),
            .package(url: "https://github.com/onevcat/Rainbow", .upToNextMajor(from: "4.0.0"))
        ],
        targets: [
            // Targets are the basic building blocks of a package. A target can define a module or a test suite.
            // Targets can depend on other targets in this package, and on products in packages this package depends on.
            .target(
                    name: "CrsServerConnection",
                    dependencies: [
                        .product(name: "AsyncHTTPClient", package: "async-http-client")
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
                        "Rainbow"
                    ]),
            .testTarget(
                    name: "CreateTenantTests",
                    dependencies: ["CreateTenant"]),
        ]
)
