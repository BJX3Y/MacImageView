import SwiftUI
import GoogleSignIn

class GoogleSignInManager: NSObject, ObservableObject {
    static let shared = GoogleSignInManager()

    @Published var isSignedIn = false
    @Published var user: GIDGoogleUser?

    private override init() {
        super.init()
        setupGoogleSignIn()
    }

    private func setupGoogleSignIn() {
        guard let clientID = Bundle.main.object(forInfoDictionaryKey: "CLIENT_ID") as? String else {
            print("CLIENT_ID not found in Info.plist")
            return
        }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
    }

    func signInWithGoogle(presenting viewController: NSViewController) {
        GIDSignIn.sharedInstance.signIn(withPresenting: viewController) { user, error in
            if let error = error {
                print("Google Sign-In error: \(error.localizedDescription)")
                return
            }

            guard let user = user else {
                print("Google Sign-In failed: No user returned")
                return
            }

            DispatchQueue.main.async {
                self.isSignedIn = true
                self.user = user
            }
        }
    }

    func signOut() {
        GIDSignIn.sharedInstance.signOut()
        DispatchQueue.main.async {
            self.isSignedIn = false
            self.user = nil
        }
    }

    func getUserInfo() -> (name: String, email: String, avatarURL: URL?) {
        guard let user = user else {
            return ("", "", nil)
        }

        let name = user.profile?.name ?? ""
        let email = user.profile?.email ?? ""
        let avatarURL = user.profile?.imageURL(withDimension: 100)

        return (name, email, avatarURL)
    }
}
