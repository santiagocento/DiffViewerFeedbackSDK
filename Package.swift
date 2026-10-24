// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "DiffViewerFeedback",
    platforms: [.iOS(.v17), .macOS(.v14)],
    products: [
        .library(name: "DiffViewerFeedback", targets: ["DiffViewerFeedback", "DiffViewerFeedbackCore"]),
        .library(name: "DiffViewerFeedbackCore", targets: ["DiffViewerFeedbackCore"])
    ],
    targets: [
        .binaryTarget(name: "DiffViewerFeedbackCore", path: "Artifacts/DiffViewerFeedbackCore.xcframework"),
        .binaryTarget(name: "DiffViewerFeedback", path: "Artifacts/DiffViewerFeedback.xcframework")
    ]
)
