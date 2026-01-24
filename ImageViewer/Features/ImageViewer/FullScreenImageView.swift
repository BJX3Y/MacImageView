import SwiftUI

struct FullScreenImageView: View {
    let viewModel: ImageViewModel
    let isComicMode: Bool
    @Binding var isFullScreen: Bool

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                Button(action: {
                    isFullScreen.toggle()
                }) {
                    Image(systemName: "arrow.down.to.line")
                        .font(.system(size: 16))
                        .padding(10)
                        .background(Color.black.opacity(0.5))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .buttonStyle(.plain)
                .padding()
            }
            .background(Color.black)

            if isComicMode {
                // 漫画模式：垂直滚动显示所有图片
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(0..<viewModel.images.count, id: \.self) {
                            index in
                            if index < viewModel.images.count {
                                VStack(spacing: 8) {
                                    Text(index < viewModel.imagePaths.count ? viewModel.imagePaths[index].components(separatedBy: "/").last ?? "Image \(index + 1)" : "Image \(index + 1)")
                                        .font(.caption)
                                        .foregroundColor(.white)
                                    if let image = viewModel.images[index] ?? viewModel.loadImage(at: index) {
                                        Image(nsImage: image)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(maxWidth: .infinity)
                                    } else {
                                        ProgressView()
                                            .frame(height: 200)
                                    }
                                }
                                .padding(.horizontal, 20)
                                .onAppear {
                                    viewModel.preloadImages(around: index)
                                }
                            }
                        }
                    }
                    .padding(.vertical, 20)
                }
                .background(Color.black)
            } else {
                // 标准模式：单张图片显示
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
                        .foregroundColor(.white)
                    Spacer()
                }

                HStack {
                    Spacer()

                    Button(action: {
                        viewModel.previousImage()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.white)
                            .frame(width: 40, height: 40)
                            .background(Color.black.opacity(0.5))
                            .cornerRadius(20)
                    }
                    .buttonStyle(.plain)
                    .disabled(viewModel.currentIndex == 0)
                    .padding(.horizontal, 20)

                    Button(action: {
                        viewModel.nextImage()
                    }) {
                        Image(systemName: "chevron.right")
                            .font(.title2)
                            .foregroundColor(.white)
                            .frame(width: 40, height: 40)
                            .background(Color.black.opacity(0.5))
                            .cornerRadius(20)
                    }
                    .buttonStyle(.plain)
                    .disabled(viewModel.currentIndex == viewModel.images.count - 1)

                    Spacer()
                }
                .padding()
                .background(Color.black)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .background(Color.black)
    }
}
