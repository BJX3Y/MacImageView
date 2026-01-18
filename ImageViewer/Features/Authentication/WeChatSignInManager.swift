import SwiftUI
import AppKit
import Combine

class WeChatSignInManager: NSObject, ObservableObject {
    static let shared = WeChatSignInManager()

    @Published var isSignedIn = false
    @Published var userName = ""
    @Published var userEmail = ""
    @Published var avatarImage: NSImage?

    private var cancellables = Set<AnyCancellable>()

    private override init() {
        super.init()
    }

    func signInWithWeChat() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.isSignedIn = true
            self.userName = "微信用户"
            self.userEmail = "wechat@example.com"
            self.avatarImage = NSImage(systemSymbolName: "message.fill", accessibilityDescription: nil)
        }
    }

    func signOut() {
        DispatchQueue.main.async {
            self.isSignedIn = false
            self.userName = ""
            self.userEmail = ""
            self.avatarImage = nil
        }
    }
}
