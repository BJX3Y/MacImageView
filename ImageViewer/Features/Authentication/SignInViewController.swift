import SwiftUI
import AppKit

struct SignInViewController: NSViewControllerRepresentable {
    let onSignIn: () -> Void

    func makeNSViewController(context: Context) -> NSViewController {
        let viewController = NSViewController()
        return viewController
    }

    func updateNSViewController(_ nsViewController: NSViewController, context: Context) {
        DispatchQueue.main.async {
            onSignIn()
        }
    }
}
