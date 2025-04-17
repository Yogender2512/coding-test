// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "CountriesChallenge",
    platforms: [.iOS(.v14)],
    products: [.library(name: "CountriesChallenge", targets: ["CountriesChallenge"])],
    targets: [
        .target(name: "CountriesChallenge", path: "Sources"),
        .testTarget(name: "CountriesChallengeTests", dependencies: ["CountriesChallenge"], path: "Tests")
    ]
)
