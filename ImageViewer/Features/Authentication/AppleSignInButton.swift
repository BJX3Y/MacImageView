import SwiftUI
import AuthenticationServices

struct AppleSignInButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: "applelogo")
                    .font(.system(size: 20))
                Text("Sign in with Apple")
                    .font(.system(size: 17, weight: .medium))
            }
            .frame(minWidth: 200, minHeight: 44)
            .foregroundColor(.black)
            .background(Color.white)
            .cornerRadius(8)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    AppleSignInButton {
        print("Sign in with Apple tapped")
    }
    .frame(width: 250, height: 100)
}
