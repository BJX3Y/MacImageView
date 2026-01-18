import SwiftUI

struct ImageDownloaderView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "arrow.down.circle")
                .font(.system(size: 60))
                .foregroundColor(.secondary)

            Text("图片下载器")
                .font(.title)
                .fontWeight(.bold)

            Text("此功能正在开发中")
                .font(.body)
                .foregroundColor(.secondary)

            Text("敬请期待...")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
