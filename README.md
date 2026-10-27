# DiffViewerFeedbackSDK

Binary SwiftUI feedback SDK for development apps on iOS 17+. Shake the iPhone or tap **Feedback** to write a bug or note. The SDK captures the available interface context automatically and queues reports locally before uploading to private CloudKit storage. DiffViewer turns selected reports into agent-request Markdown.

This package contains compiled static XCFrameworks and public API interfaces. It does not contain implementation sources. Add `https://github.com/santiagocento/DiffViewerFeedbackSDK.git` in Xcode, select version `0.1.1` or later, and link the `DiffViewerFeedback` product; both required binary modules are included.

Version `0.1.1` fixes shake detection by listening on the app's window while preserving keyboard focus. The app-root integration below remains the same.

Integrate once at the app root:

```swift
import SwiftUI
#if DEBUG
import DiffViewerFeedback
#endif

@main
struct ExampleApp: App {
    var body: some Scene {
        WindowGroup {
            #if DEBUG
            DiffViewerFeedbackHost(configuration: FeedbackConfiguration(
                projectID: "github.com/your-account/your-repository",
                containerIdentifier: "iCloud.your.shared.container"
            ), isEnabled: true) {
                AppRootView()
            }
            #else
            AppRootView()
            #endif
        }
    }
}
```

Keep the import and SDK host inside the consuming app's `#if DEBUG` branch. Capture is disabled by default; `isEnabled: true` explicitly opts in. The optimized binary contains capture implementation because a precompiled framework cannot read its consumer's compilation flags. The static distribution is verified with a consumer whose Release executable has no capture symbols when the SDK is referenced only in Debug.

No per-screen registration is needed. Reports contain available controller/root types, navigation titles, existing accessibility identifiers, visible labels and build/device metadata. Text-entry contents are excluded. Runtime context provides code-search clues and does not establish an exact Swift source filename or line.

The tested app and DiffViewer need the same Apple Developer team, entitled CloudKit container, iCloud account and CloudKit environment. Assign the container to both app identifiers and enable CloudKit in the app being tested; the framework cannot grant entitlements. Create the `DVRuntimeFeedback` schema with `payload` (Bytes), `projectID` (String), `createdAt` (Date/Time) and `schemaVersion` (Int64), with `recordName` queryable. Start with matching Development environments; deploy schema/indexes before using Production. DiffViewer's cloud refresh follows its existing Pro access rule.

The `DiffViewerFeedbackCore` product is also available to macOS 14+ consumers. It contains report models and transport/export operations without the iOS capture interface. Public API signatures remain visible in the distributed `.swiftinterface` files.
