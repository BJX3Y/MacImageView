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
            AppleSignInSheetView(isPresented: $showSignIn)
        }
    }

    private var loginButton: some View {
        Button(action: {
            showSignIn = true
        }) {
            HStack(spacing: 8) {
                Image(systemName: "applelogo")
                    .font(.system(size: 20))
                Text("使用 Apple 登录")
                    .font(.system(size: 13))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity)
            .background(Color.black)
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

struct AppleSignInSheetView: View {
    @Binding var isPresented: Bool
    @StateObject private var userSession = UserSession.shared
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 24) {
            Text("登录")
                .font(.system(size: 24, weight: .bold))
                .padding(.top, 32)

            Text("使用您的 Apple ID 登录以访问所有功能")
                .font(.system(size: 14))
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)

            AppleSignInButton {
                performSignIn()
            }
            .padding(.horizontal, 32)

            Spacer()
        }
        .frame(width: 400, height: 300)
        .background(Color(NSColor.windowBackgroundColor))
    }

    private func performSignIn() {
        if let window = NSApplication.shared.keyWindow,
           let viewController = window.contentViewController {
            userSession.login(presenting: viewController)
            isPresented = false
        }
    }
}
