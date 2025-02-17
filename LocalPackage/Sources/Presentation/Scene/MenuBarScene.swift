import SwiftUI

public struct MenuBarScene: Scene {
    @Environment(\.appDependencies) private var appDependencies
    @Environment(\.appServices) private var appServices

    public init() {}

    public var body: some Scene {
        MenuBarExtra {
            MenuView(
                nsAppClient: appDependencies.nsAppClient,
                windowSceneMessengerClient: appDependencies.windowSceneMessengerClient,
                updateService: appServices.updateService
            )
            .environment(\.displayScale, 2.0)
        } label: {
            Image(systemName: "text.viewfinder")
                .environment(\.displayScale, 2.0)
        }
    }
}
