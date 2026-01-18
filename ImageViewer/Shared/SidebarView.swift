import SwiftUI

struct SidebarView: View {
    @Binding var selectedFeature: AppFeature
    @StateObject private var userSession = UserSession.shared
    @State private var showSignIn = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 4) {
                ForEach(AppFeature.allCases, id: \.self) { feature in
                    Button(action: {
                        selectedFeature = feature
                    }) {
                        HStack(spacing: 12) {
                            Image(systemName: feature.icon)
                                .font(.system(size: 16))
                                .frame(width: 20)

                            Text(feature.rawValue)
                                .font(.system(size: 14))

                            Spacer()

                            if selectedFeature == feature {
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 12))
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(selectedFeature == feature ? Color.accentColor.opacity(0.1) : Color.clear)
                        .cornerRadius(8)
                    }
                    .buttonStyle(.plain)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 2)
                }
            }

            Spacer()

            Divider()

            if userSession.isLoggedIn {
                userInfoView
            } else {
                loginButton
            }

            HStack {
                Image(systemName: "info.circle")
                    .font(.system(size: 14))
                Text("版本 1.0")
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
            }
            .padding(16)
        }
        .frame(width: 220)
        .background(Color(NSColor.windowBackgroundColor))
        .sheet(isPresented: $showSignIn) {
            SignInSheetView(isPresented: $showSignIn)
        }
    }

    private var loginButton: some View {
        Button(action: {
            showSignIn = true
        }) {
            HStack(spacing: 8) {
                Image(systemName: "message.fill")
                    .font(.system(size: 20))
                Text("微信登录")
                    .font(.system(size: 13))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity)
            .background(Color(red: 0.07, green: 0.63, blue: 0.48))
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .buttonStyle(.plain)
        .padding(.horizontal, 12)
        .padding(.bottom, 8)
    }

    private var userInfoView: some View {
        VStack(spacing: 8) {
            HStack(spacing: 10) {
                if let avatar = userSession.avatarImage {
                    Image(nsImage: avatar)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                } else {
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.secondary)
                }

                VStack(alignment: .leading, spacing: 2) {
                    Text(userSession.userName)
                        .font(.system(size: 13, weight: .medium))
                    Text(userSession.userEmail)
                        .font(.system(size: 11))
                        .foregroundColor(.secondary)
                }

                Spacer()

                Button(action: {
                    userSession.logout()
                }) {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
        }
        .padding(.bottom, 8)
    }
}

struct SignInSheetView: View {
    @Binding var isPresented: Bool
    @StateObject private var userSession = UserSession.shared
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 24) {
            Text("登录")
                .font(.system(size: 24, weight: .bold))
                .padding(.top, 32)

            Text("选择登录方式")
                .font(.system(size: 14))
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)

            VStack(spacing: 16) {
                WeChatSignInButton {
                    performWeChatSignIn()
                }

                AppleSignInButton {
                    performAppleSignIn()
                }
            }
            .padding(.horizontal, 32)

            Spacer()
        }
        .frame(width: 400, height: 350)
        .background(Color(NSColor.windowBackgroundColor))
    }

    private func performWeChatSignIn() {
        userSession.loginWithWeChat()
        isPresented = false
    }

    private func performAppleSignIn() {
        if let window = NSApplication.shared.keyWindow,
           let viewController = window.contentViewController {
            userSession.loginWithApple(presenting: viewController)
            isPresented = false
        }
    }
}
