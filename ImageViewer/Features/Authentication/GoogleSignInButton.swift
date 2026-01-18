import SwiftUI
import AppKit

struct GoogleSignInButton: NSViewRepresentable {
    let action: () -> Void

    func makeNSView(context: Context) -> NSButton {
        let button = NSButton()
        button.title = "使用 Google 登录"
        button.bezelStyle = .rounded
        button.action = action
        return button
    }

    func updateNSView(_ nsView: NSButton, context: Context) {}
}
