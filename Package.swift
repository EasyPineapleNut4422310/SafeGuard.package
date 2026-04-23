// swift-tools-version: 6.0
import PackageDescription

let package = Package(
name: "MainApp",
platforms: [
.macOS(.v13)
],
products: [
.executable(
name: "mainapp",
targets: ["MainApp"]
),
],
dependencies: [
.package(
url: "https://github.com/EasyPineapleNut4422310/SafeGuard.package.git",
branch: "main"
)
],
targets: [
.executableTarget(
name: "MainApp",
dependencies: [
.product(
name: "SafeGuard", // must match the library product name in your repo
package: "SafeGuard.package"
)
]
)
],
swiftLanguageVersions: [.v6]
)
