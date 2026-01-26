import SwiftUI

struct FullScreenImageView: View {
    let viewModel: ImageViewModel
    let isComicMode: Bool
    @Binding var isFullScreen: Bool

    var body: some View {
        VStack(spacing: 0) {
            if isComicMode {
                // 漫画模式：垂直滚动显示所有图片
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(0..<viewModel.images.count, id: \.self) {
                            index in
                            if index < viewModel.images.count {
                                if let image = viewModel.images[index] ?? viewModel.loadImage(at: index) {
                                    Image(nsImage: image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(maxWidth: .infinity)
                                        .onTapGesture {
                                            isFullScreen.toggle()
                                        }
                                        .onAppear {
                                            viewModel.preloadImages(around: index)
                                        }
                                } else {
                                    ProgressView()
                                        .frame(height: 200)
                                        .onAppear {
                                            viewModel.preloadImages(around: index)
                                        }
                                }
                            }
                        }
                    }
                }
                .background(Color.black)
                .edgesIgnoringSafeArea(.all)
            } else {
                // 标准模式：单张图片满屏显示
                if let currentImage = viewModel.currentImage {
                    Image(nsImage: currentImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .clipped()
                        .onTapGesture {
                            isFullScreen.toggle()
                        }
                } else {
                    ZStack {
                        Color.black
                        Text("无法加载图片")
                            .foregroundColor(.white)
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .background(Color.black)
        .contentShape(Rectangle())
        .onTapGesture {
            isFullScreen.toggle()
        }
    }
}
