import SwiftUI

struct SignInSheetView: NSViewRepresentable {
    @Binding var isPresented: Bool

    func makeNSView(context: Context) -> NSHostingController<SignInContentView> {
        let contentView = SignInContentView(isPresented: $isPresented)
        return NSHostingController(rootView: contentView)
    }

    func updateNSView(_ nsView: NSHostingController<SignInContentView>, context: Context) {}
}

struct SignInContentView: View {
    @Binding var isPresented: Bool
    @State private var isSigningIn = false

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "google")
                .font(.system(size: 60))
                .foregroundColor(.blue)

            Text("使用 Google 登录")
                .font(.title2)
                .fontWeight(.bold)

            if isSigningIn {
                ProgressView()
                    .scaleEffect(1.5)
                Text("正在登录...")
                    .font(.body)
                    .foregroundColor(.secondary)
            } else {
                Button(action: {
                    isSigningIn = true
                    performGoogleSignIn()
                }) {
                    Text("登录")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
            }
        }
        .frame(width: 400, height: 300)
        .padding()
    }

    private func performGoogleSignIn() {
        guard let window = NSApp.windows.first,
              let viewController = window.contentViewController else {
            isSigningIn = false
            return
        }

        UserSession.shared.login(presenting: viewController)

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isSigningIn = false
            isPresented = false
        }
    }
}
