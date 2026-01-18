import SwiftUI
import AppKit
import Combine

class UserSession: ObservableObject {
    @Published var isLoggedIn = false
    @Published var userName = ""
    @Published var userEmail = ""
    @Published var avatarImage: NSImage?

    private let appleSignInManager = AppleSignInManager.shared
    private let weChatSignInManager = WeChatSignInManager.shared

    static let shared = UserSession()

    private init() {
        observeAppleSignIn()
        observeWeChatSignIn()
    }

    private func observeAppleSignIn() {
        appleSignInManager.$isSignedIn
            .receive(on: RunLoop.main)
            .sink { [weak self] isSignedIn in
                self?.isLoggedIn = isSignedIn
                if isSignedIn {
                    self?.updateUserInfo()
                }
            }
            .store(in: &cancellables)
    }

    private func observeWeChatSignIn() {
        weChatSignInManager.$isSignedIn
            .receive(on: RunLoop.main)
            .sink { [weak self] isSignedIn in
                self?.isLoggedIn = isSignedIn
                if isSignedIn {
                    self?.updateUserInfo()
                }
            }
            .store(in: &cancellables)
    }

    private var cancellables = Set<AnyCancellable>()

    func loginWithApple(presenting viewController: NSViewController) {
        appleSignInManager.signInWithApple(presenting: viewController)
    }

    func loginWithWeChat() {
        weChatSignInManager.signInWithWeChat()
    }

    func logout() {
        appleSignInManager.signOut()
        weChatSignInManager.signOut()
        userName = ""
        userEmail = ""
        avatarImage = nil
    }

    private func updateUserInfo() {
        if appleSignInManager.isSignedIn {
            userName = appleSignInManager.userName
            userEmail = appleSignInManager.userEmail
            avatarImage = appleSignInManager.avatarImage
        } else if weChatSignInManager.isSignedIn {
            userName = weChatSignInManager.userName
            userEmail = weChatSignInManager.userEmail
            avatarImage = weChatSignInManager.avatarImage
        }
    }
}
