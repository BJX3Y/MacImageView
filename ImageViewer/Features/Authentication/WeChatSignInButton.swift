import SwiftUI

struct WeChatSignInButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: "message.fill")
                    .font(.system(size: 20))
                Text("微信登录")
                    .font(.system(size: 17, weight: .medium))
            }
            .frame(minWidth: 200, minHeight: 44)
            .foregroundColor(.white)
            .background(Color(red: 0.07, green: 0.63, blue: 0.48))
            .cornerRadius(8)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    WeChatSignInButton {
        print("WeChat Sign In tapped")
    }
    .frame(width: 250, height: 100)
}
