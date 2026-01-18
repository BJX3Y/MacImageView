import SwiftUI

struct ContentView: View {
    @State private var selectedFeature: AppFeature = .imageViewer

    var body: some View {
        NavigationSplitView {
            SidebarView(selectedFeature: $selectedFeature)
        } detail: {
            contentForFeature(selectedFeature)
        }
        .navigationSplitViewStyle(.balanced)
        .frame(minWidth: 1000, minHeight: 700)
    }

    @ViewBuilder
    private func contentForFeature(_ feature: AppFeature) -> some View {
        switch feature {
        case .imageViewer:
            ImageViewerView()
        case .imageDownloader:
            ImageDownloaderView()
        }
    }
}
