import DataLayer
import Foundation
import Observation

@MainActor @Observable public final class MenuViewModel {
    private let nsAppClient: NSAppClient
    private let windowSceneMessengerClient: WindowSceneMessengerClient
    private let updateService: UpdateService

    @ObservationIgnored private var task: Task<Void, Never>?

    public var canChecksForUpdates = false

    public init(
        _ nsAppClient: NSAppClient,
        _ windowSceneMessengerClient: WindowSceneMessengerClient,
        _ updateService: UpdateService
    ) {
        self.nsAppClient = nsAppClient
        self.windowSceneMessengerClient = windowSceneMessengerClient
        self.updateService = updateService
        task = Task { [weak self, updateService] in
            for await value in await updateService.canChecksForUpdatesStream() {
                self?.canChecksForUpdates = value
            }
        }
    }

    public func scanText() {
        nsAppClient.activate(true)
        windowSceneMessengerClient.request(.open, .screenshot, [:])
    }

    public func activateApp() {
        nsAppClient.activate(true)
    }

    public func checkForUpdates() async {
        await updateService.checkForUpdates()
    }

    public func openAbout() {
        nsAppClient.activate(true)
        nsAppClient.orderFrontStandardAboutPanel(nil)
    }

    public func terminateApp() {
        nsAppClient.terminate(nil)
    }
}
