import SwiftUI
import AppKit

class ImageViewModel: ObservableObject {
    @Published var images: [NSImage?] = []
    @Published var currentIndex: Int = 0
    @Published var currentImage: NSImage?
    @Published var currentFolderPath: String = ""
    @Published var currentImagePath: String = ""
    
    private let supportedExtensions = ["jpg", "jpeg", "png", "gif", "bmp", "tiff", "webp"]
    var imagePaths: [String] = []
    private var config = AppConfig.shared

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
        var imageFileURLs: [URL] = []

        if let enumerator = FileManager.default.enumerator(at: folderURL, includingPropertiesForKeys: [.isDirectoryKey], options: [.skipsHiddenFiles]) {
            for case let fileURL as URL in enumerator {
                do {
                    let resourceValues = try fileURL.resourceValues(forKeys: [.isDirectoryKey])
                    if resourceValues.isDirectory == true {
                        continue
                    }

                    let pathExtension = fileURL.pathExtension.lowercased()
                    if supportedExtensions.contains(pathExtension) {
                        imageFileURLs.append(fileURL)
                    }
                } catch {
                    continue
                }
            }
        }

        // 按照文件夹名称 + 文件名称排序
        imageFileURLs.sort { (url1, url2) -> Bool in
            let folderName1 = url1.deletingLastPathComponent().lastPathComponent
            let folderName2 = url2.deletingLastPathComponent().lastPathComponent
            let fileName1 = url1.lastPathComponent
            let fileName2 = url2.lastPathComponent

            if folderName1 == folderName2 {
                return fileName1 < fileName2
            }
            return folderName1 < folderName2
        }

        var loadedImagePaths: [String] = []

        for fileURL in imageFileURLs {
            loadedImagePaths.append(fileURL.path)
        }

        DispatchQueue.main.async {
            self.images = Array(repeating: nil, count: loadedImagePaths.count)
            self.imagePaths = loadedImagePaths
            self.currentIndex = 0
            self.currentFolderPath = folderURL.path
            self.preloadImages(around: 0)
            self.updateCurrentImage()
        }
    }

    func loadImage(at index: Int) -> NSImage? {
        guard index >= 0, index < imagePaths.count else { return nil }
        
        if let existingImage = images[index] {
            return existingImage
        }
        
        let imagePath = imagePaths[index]
        if let image = NSImage(contentsOfFile: imagePath) {
            DispatchQueue.main.async {
                self.images[index] = image
            }
            return image
        }
        
        return nil
    }

    func preloadImages(around index: Int) {
        let preloadCount = 10
        let startIndex = max(0, index - preloadCount / 2)
        let endIndex = min(imagePaths.count - 1, index + preloadCount / 2)
        
        for i in startIndex...endIndex {
            if images[i] == nil {
                loadImage(at: i)
            }
        }
    }

    func nextImage() {
        guard currentIndex < images.count - 1 else { return }
        currentIndex += 1
        preloadImages(around: currentIndex)
        updateCurrentImage()
    }

    func previousImage() {
        guard currentIndex > 0 else { return }
        currentIndex -= 1
        preloadImages(around: currentIndex)
        updateCurrentImage()
    }

    private func updateCurrentImage() {
        guard currentIndex < images.count else {
            currentImage = nil
            currentImagePath = ""
            return
        }
        currentImage = images[currentIndex] ?? loadImage(at: currentIndex)
        currentImagePath = currentIndex < imagePaths.count ? imagePaths[currentIndex] : ""
    }
}
