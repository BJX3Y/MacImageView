import SwiftUI
import AppKit
import GoogleSignIn
import Combine

class UserSession: ObservableObject {
    @Published var isLoggedIn = false
    @Published var userName = ""
    @Published var userEmail = ""
    @Published var avatarImage: NSImage?

    private let googleSignInManager = GoogleSignInManager.shared

    static let shared = UserSession()

    private init() {
        observeGoogleSignIn()
    }

    private func observeGoogleSignIn() {
        googleSignInManager.$isSignedIn
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
        googleSignInManager.signInWithGoogle(presenting: viewController)
    }

    func logout() {
        googleSignInManager.signOut()
        userName = ""
        userEmail = ""
        avatarImage = nil
    }

    private func updateUserInfo() {
        let userInfo = googleSignInManager.getUserInfo()
        userName = userInfo.name
        userEmail = userInfo.email

        if let avatarURL = userInfo.avatarURL {
            loadAvatar(from: avatarURL)
        }
    }

    private func loadAvatar(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    self.avatarImage = NSImage(systemSymbolName: "person.circle.fill", accessibilityDescription: nil)
                }
                return
            }

            DispatchQueue.main.async {
                if let image = NSImage(data: data) {
                    self.avatarImage = image
                }
            }
        }.resume()
    }
}
