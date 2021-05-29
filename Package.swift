// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "UniteKitTableViewHandlers",
  platforms: [
    .macOS(.v10_15),
    .iOS(.v13)
  ],
  products: [
    .library(
      name: "UniteKitTableViewHandlers", targets: ["UniteKitTableViewHandlers"]),
  ],
  dependencies: [
    .package(name: "UniteKit", url: "https://github.com/mihaelamj/UniteKit", .upToNextMajor(from: "0.1.0")),
    .package(url: "https://github.com/mihaelamj/MMJUtils", .exact("0.3.0")),
    .package(url: "https://github.com/mihaelamj/MMJSectionedDataSource", .upToNextMajor(from: "0.1.0"))
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages this package depends on.
    .target(
      name: "UniteKitTableViewHandlers",
      dependencies: [
        "UniteKit",
        "MMJSectionedDataSource",
      ]),
    .testTarget(
      name: "UniteKitTableViewHandlersTests",
      dependencies: [
        "UniteKitTableViewHandlers",
        "UniteKit",
        "MMJSectionedDataSource",
        .product(name: "CollectionUtil", package: "MMJUtils")
      ]),
  ]
)
