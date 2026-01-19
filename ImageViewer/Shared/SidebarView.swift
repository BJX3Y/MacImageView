import SwiftUI

struct SidebarView: View {
    @Binding var selectedFeature: AppFeature
    @StateObject private var userSession = UserSession.shared
    @State private var showUserProfile = false

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

            userInfoView

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
        .sheet(isPresented: $showUserProfile) {
            UserProfileView()
        }
    }

    private var userInfoView: some View {
        VStack(spacing: 8) {
            Button(action: {
                showUserProfile = true
            }) {
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

                    Image(systemName: "chevron.right")
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
            }
            .buttonStyle(.plain)
        }
        .padding(.bottom, 8)
    }
}
