import SwiftUI

struct SettingsView: View {
    @ObservedObject private var config = AppConfig.shared
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            headerView
            
            Divider()
            
            ScrollView {
                VStack(spacing: 20) {
                    imageViewerSection
                }
                .padding()
            }
        }
        .frame(width: 500, height: 400)
    }
    
    private var headerView: some View {
        HStack {
            Text("设置")
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
    
    private var imageViewerSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("图片查看器")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.secondary)
            
            VStack(spacing: 0) {
                ForEach(AppConfig.ViewMode.allCases, id: \.self) {
                    mode in
                    Button(action: {
                        config.imageViewMode = mode
                    }) {
                        HStack {
                            Text(mode.rawValue)
                                .font(.system(size: 14))
                            
                            Spacer()
                            
                            if config.imageViewMode == mode {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.accentColor)
                            }
                        }
                        .padding()
                    }
                    .buttonStyle(.plain)
                    
                    if mode != AppConfig.ViewMode.allCases.last {
                        Divider()
                    }
                }
            }
            .background(Color(NSColor.controlBackgroundColor))
            .cornerRadius(8)
            
            Text("标准模式：使用左右箭头按钮切换图片\n漫画模式：所有图片文件从上到下漫画移动的方式切换图片")
                .font(.system(size: 12))
                .foregroundColor(.secondary)
                .lineLimit(nil)
        }
    }
}
