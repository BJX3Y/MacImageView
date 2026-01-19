import SwiftUI

struct QRCodeLoginView: View {
    @StateObject private var userSession = UserSession.shared
    @State private var showQRCode = true
    @State private var isScanning = false
    @State private var scanProgress: Double = 0
    
    var body: some View {
        VStack(spacing: 40) {
            Spacer()
            
            VStack(spacing: 24) {
                Image(systemName: "qrcode")
                    .font(.system(size: 120))
                    .foregroundColor(.primary)
                
                Text("扫码登录")
                    .font(.system(size: 28, weight: .bold))
                
                Text("请使用微信扫描二维码登录")
                    .font(.system(size: 16))
                    .foregroundColor(.secondary)
                
                if isScanning {
                    ProgressView(value: scanProgress)
                        .progressViewStyle(LinearProgressViewStyle())
                        .frame(width: 200)
                    
                    Text("正在登录中...")
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                }
                
                Button(action: refreshQRCode) {
                    Text("刷新二维码")
                        .font(.system(size: 14))
                        .foregroundColor(.blue)
                }
                .buttonStyle(.plain)
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(NSColor.windowBackgroundColor))
    }
    
    private func refreshQRCode() {
        showQRCode = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            showQRCode = true
        }
    }
}
