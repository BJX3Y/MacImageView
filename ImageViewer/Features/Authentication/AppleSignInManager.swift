import SwiftUI
import AppKit
import AuthenticationServices
import Combine

class AppleSignInManager: NSObject, ObservableObject {
    static let shared = AppleSignInManager()

    @Published var isSignedIn = false
    @Published var userName = ""
    @Published var userEmail = ""
    @Published var avatarImage: NSImage?

    private var cancellables = Set<AnyCancellable>()

    private override init() {
        super.init()
        checkExistingCredential()
    }

    func signInWithApple(presenting viewController: NSViewController) {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]

        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = viewController
        authorizationController.performRequests()
    }

    func signOut() {
        DispatchQueue.main.async {
            self.isSignedIn = false
            self.userName = ""
            self.userEmail = ""
            self.avatarImage = nil
        }
    }

    private func checkExistingCredential() {
        let provider = ASAuthorizationAppleIDProvider()
        provider.getCredentialState(forUserID: "apple_id_user") { credentialState, error in
            DispatchQueue.main.async {
                switch credentialState {
                case .authorized:
                    self.isSignedIn = true
                case .revoked, .notFound:
                    self.isSignedIn = false
                @unknown default:
                    self.isSignedIn = false
                }
            }
        }
    }
}

extension AppleSignInManager: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email

            DispatchQueue.main.async {
                self.isSignedIn = true
                self.userName = fullName?.formatted() ?? ""
                self.userEmail = email ?? ""
                self.avatarImage = NSImage(systemSymbolName: "applelogo", accessibilityDescription: nil)
            }
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Apple Sign-In error: \(error.localizedDescription)")
    }
}

extension PersonNameComponents {
    func formatted() -> String {
        let name = [givenName, familyName]
            .compactMap { $0 }
            .joined(separator: " ")
        return name.isEmpty ? "Apple User" : name
    }
}

extension NSViewController: ASAuthorizationControllerPresentationContextProviding {
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
