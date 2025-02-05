import DataLayer
import Domain
import SwiftUI

struct MenuView: View {
    @State private var viewModel: MenuViewModel

    init(
        nsAppClient: NSAppClient,
        windowSceneMessengerClient: WindowSceneMessengerClient,
        updateService: UpdateService
    ) {
        viewModel = .init(nsAppClient, windowSceneMessengerClient, updateService)
    }

    var body: some View {
        VStack {
            Button {
                viewModel.scanText()
            } label: {
                Text("scanText", bundle: .module)
            }
            Divider()
            Button {
                Task {
                    await viewModel.checkForUpdates()
                }
            } label: {
                Text("checkForUpdates", bundle: .module)
            }
            .disabled(!viewModel.canChecksForUpdates)
            Button {
                viewModel.openAbout()
            } label: {
                Text("aboutApp", bundle: .module)
            }
            Button {
                viewModel.terminateApp()
            } label: {
                Text("terminateApp", bundle: .module)
            }
        }
    }
}

#Preview {
    MenuView(
        nsAppClient: .testValue,
        windowSceneMessengerClient: .testValue,
        updateService: .init(.testValue)
    )
}
