import SwiftUI
import AppKit
import Combine

class UserSession: ObservableObject {
    @Published var isLoggedIn = false
    @Published var userName = ""
    @Published var userEmail = ""
    @Published var avatarImage: NSImage?

    private let appleSignInManager = AppleSignInManager.shared

    static let shared = UserSession()

    private init() {
        observeAppleSignIn()
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

    private var cancellables = Set<AnyCancellable>()

    func login(presenting viewController: NSViewController) {
        appleSignInManager.signInWithApple(presenting: viewController)
    }

    func logout() {
        appleSignInManager.signOut()
        userName = ""
        userEmail = ""
        avatarImage = nil
    }

    private func updateUserInfo() {
        userName = appleSignInManager.userName
        userEmail = appleSignInManager.userEmail
        avatarImage = appleSignInManager.avatarImage
    }
}
