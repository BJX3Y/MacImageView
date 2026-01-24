import SwiftUI

class AppConfig: ObservableObject {
    static let shared = AppConfig()
    
    enum ViewMode: String, CaseIterable, Identifiable {
        case standard = "标准模式"
        case comic = "漫画模式"
        
        var id: String {
            self.rawValue
        }
    }
    
    @Published var imageViewMode: ViewMode {
        didSet {
            UserDefaults.standard.set(imageViewMode.rawValue, forKey: "imageViewMode")
        }
    }
    
    private init() {
        if let savedMode = UserDefaults.standard.string(forKey: "imageViewMode"),
           let mode = ViewMode(rawValue: savedMode) {
            imageViewMode = mode
        } else {
            imageViewMode = .standard
        }
    }
}
