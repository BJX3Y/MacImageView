import SwiftUI
import AppKit

struct ImageViewerView: View {
    @StateObject private var viewModel = ImageViewModel()

    var body: some View {
        VStack(spacing: 0) {
            if viewModel.images.isEmpty {
                emptyStateView
            } else {
                imageView
            }
        }
        .frame(minWidth: 800, minHeight: 600)
        .background(KeyHandlerView(viewModel: viewModel))
        .onAppear {
            viewModel.loadImages()
        }
    }

    private var emptyStateView: some View {
        VStack(spacing: 20) {
            Image(systemName: "photo.on.rectangle")
                .font(.system(size: 60))
                .foregroundColor(.secondary)

            Text("图片查看器")
                .font(.title)
                .fontWeight(.bold)

            Text("选择一个文件夹开始查看图片")
                .font(.body)
                .foregroundColor(.secondary)

            Button(action: {
                viewModel.selectFolder()
            }) {
                HStack {
                    Image(systemName: "folder")
                    Text("选择文件夹")
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            .buttonStyle(.plain)
        }
    }

    private var imageView: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: {
                    viewModel.selectFolder()
                }) {
                    HStack(spacing: 6) {
                        Image(systemName: "folder")
                        Text("更换文件夹")
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.accentColor.opacity(0.1))
                    .cornerRadius(6)
                }
                .buttonStyle(.plain)

                Spacer()

                Text("\(viewModel.currentIndex + 1) / \(viewModel.images.count)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding()

            if !viewModel.currentFolderPath.isEmpty {
                HStack {
                    Image(systemName: "folder")
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                    Text(viewModel.currentFolderPath)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 4)
            }

            if !viewModel.currentImagePath.isEmpty {
                HStack {
                    Image(systemName: "doc.images")
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                    Text(viewModel.currentImagePath)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 8)
            }

            Divider()

            if let currentImage = viewModel.currentImage {
                GeometryReader { geometry in
                    Image(nsImage: currentImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height)
                }
            } else {
                Spacer()
                Text("无法加载图片")
                    .foregroundColor(.secondary)
                Spacer()
            }

            Divider()

            HStack {
                Spacer()

                Button(action: {
                    viewModel.previousImage()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .frame(width: 40, height: 40)
                }
                .buttonStyle(.plain)
                .disabled(viewModel.currentIndex == 0)
                .padding(.horizontal, 20)

                Button(action: {
                    viewModel.nextImage()
                }) {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                        .frame(width: 40, height: 40)
                }
                .buttonStyle(.plain)
                .disabled(viewModel.currentIndex == viewModel.images.count - 1)

                Spacer()
            }
            .padding()
        }
    }
}

struct KeyHandlerView: NSViewRepresentable {
    let viewModel: ImageViewModel

    func makeNSView(context: Context) -> NSView {
        let view = NSView()
        let monitor = NSEvent.addLocalMonitorForEvents(matching: .keyDown) { event in
            if event.keyCode == 126 {
                viewModel.previousImage()
                return nil
            } else if event.keyCode == 125 {
                viewModel.nextImage()
                return nil
            }
            return event
        }
        context.coordinator.monitor = monitor
        return view
    }

    func updateNSView(_ nsView: NSView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator {
        var monitor: Any?
    }
}
