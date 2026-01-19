import SwiftUI

struct UserProfileView: View {
    @StateObject private var userSession = UserSession.shared
    @Environment(\.dismiss) private var dismiss
    @State private var showLogoutAlert = false
    
    var body: some View {
        VStack(spacing: 0) {
            headerView
            
            Divider()
            
            ScrollView {
                VStack(spacing: 20) {
                    userInfoSection
                    accountSection
                    settingsSection
                }
                .padding()
            }
        }
        .frame(width: 500, height: 600)
        .alert("退出登录", isPresented: $showLogoutAlert) {
            Button("取消", role: .cancel) { }
            Button("退出", role: .destructive) {
                userSession.logout()
                dismiss()
            }
        } message: {
            Text("确定要退出登录吗？")
        }
    }
    
    private var headerView: some View {
        HStack {
            Text("我的信息")
                .font(.system(size: 18, weight: .semibold))
            
            Spacer()
            
            Button(action: { dismiss() }) {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 20))
                    .foregroundColor(.secondary)
            }
            .buttonStyle(.plain)
        }
        .padding()
    }
    
    private var userInfoSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("用户信息")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.secondary)
            
            VStack(spacing: 12) {
                infoRow(title: "用户名", value: userSession.userName)
                infoRow(title: "邮箱", value: userSession.userEmail)
                infoRow(title: "登录方式", value: userSession.isLoggedIn ? "已登录" : "未登录")
            }
            .padding()
            .background(Color(NSColor.controlBackgroundColor))
            .cornerRadius(8)
        }
    }
    
    private func infoRow(title: String, value: String) -> some View {
        HStack {
            Text(title)
                .font(.system(size: 14))
                .foregroundColor(.secondary)
                .frame(width: 80, alignment: .leading)
            
            Text(value.isEmpty ? "未设置" : value)
                .font(.system(size: 14))
            
            Spacer()
        }
    }
    
    private var accountSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("账户设置")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.secondary)
            
            VStack(spacing: 0) {
                settingRow(title: "个人资料", icon: "person.circle")
                Divider()
                settingRow(title: "账户安全", icon: "lock.shield")
                Divider()
                settingRow(title: "隐私设置", icon: "hand.raised")
            }
            .background(Color(NSColor.controlBackgroundColor))
            .cornerRadius(8)
        }
    }
    
    private func settingRow(title: String, icon: String) -> some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 16))
                .foregroundColor(.secondary)
                .frame(width: 24)
            
            Text(title)
                .font(.system(size: 14))
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 12))
                .foregroundColor(.secondary)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
    
    private var settingsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("其他")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.secondary)
            
            Button(action: {
                showLogoutAlert = true
            }) {
                HStack {
                    Image(systemName: "arrow.right.square")
                        .font(.system(size: 16))
                    
                    Text("退出登录")
                        .font(.system(size: 14))
                        .foregroundColor(.red)
                    
                    Spacer()
                }
                .padding()
                .background(Color(NSColor.controlBackgroundColor))
                .cornerRadius(8)
            }
            .buttonStyle(.plain)
        }
    }
}
