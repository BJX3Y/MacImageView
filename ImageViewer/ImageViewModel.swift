import SwiftUI
import AppKit

class ImageViewModel: ObservableObject {
    @Published var images: [NSImage] = []
    @Published var currentIndex: Int = 0
    @Published var currentImage: NSImage?

    private let supportedExtensions = ["jpg", "jpeg", "png", "gif", "bmp", "tiff", "webp"]

    var currentImageName: String {
        guard currentIndex < images.count else { return "" }
        return "Image \(currentIndex + 1)"
    }

    func loadImages() {
        if let lastPath = UserDefaults.standard.string(forKey: "lastFolderPath"),
           let folderURL = URL(string: lastPath) {
            loadImagesFromFolder(folderURL)
        }
    }

    func selectFolder() {
        let panel = NSOpenPanel()
        panel.canChooseDirectories = true
        panel.canChooseFiles = false
        panel.allowsMultipleSelection = false
        panel.canCreateDirectories = false
        panel.title = "选择包含图片的文件夹"
        panel.prompt = "选择"

        if panel.runModal() == .OK, let folderURL = panel.url {
            UserDefaults.standard.set(folderURL.absoluteString, forKey: "lastFolderPath")
            loadImagesFromFolder(folderURL)
        }
    }

    private func loadImagesFromFolder(_ folderURL: URL) {
        var loadedImages: [NSImage] = []

        if let enumerator = FileManager.default.enumerator(at: folderURL, includingPropertiesForKeys: [.isDirectoryKey], options: [.skipsHiddenFiles]) {
            for case let fileURL as URL in enumerator {
                do {
                    let resourceValues = try fileURL.resourceValues(forKeys: [.isDirectoryKey])
                    if resourceValues.isDirectory == true {
                        continue
                    }

                    let pathExtension = fileURL.pathExtension.lowercased()
                    if supportedExtensions.contains(pathExtension) {
                        if let image = NSImage(contentsOf: fileURL) {
                            loadedImages.append(image)
                        }
                    }
                } catch {
                    continue
                }
            }
        }

        DispatchQueue.main.async {
            self.images = loadedImages
            self.currentIndex = 0
            self.updateCurrentImage()
        }
    }

    func nextImage() {
        guard currentIndex < images.count - 1 else { return }
        currentIndex += 1
        updateCurrentImage()
    }

    func previousImage() {
        guard currentIndex > 0 else { return }
        currentIndex -= 1
        updateCurrentImage()
    }

    private func updateCurrentImage() {
        guard currentIndex < images.count else {
            currentImage = nil
            return
        }
        currentImage = images[currentIndex]
    }
}
