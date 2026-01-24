import Foundation

extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension String {
    var lastPathComponent: String {
        return (self as NSString).lastPathComponent
    }
}
