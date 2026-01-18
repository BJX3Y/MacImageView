import SwiftUI

enum AppFeature: String, CaseIterable {
    case imageViewer = "图片查看器"
    case imageDownloader = "图片下载"

    var icon: String {
        switch self {
        case .imageViewer:
            return "photo.on.rectangle"
        case .imageDownloader:
            return "arrow.down.circle"
        }
    }
}
