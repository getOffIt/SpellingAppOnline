import SwiftUI

class ImageManager: NSObject, ObservableObject {
    struct ImageShareTransferable: Transferable {
        static var transferRepresentation: some TransferRepresentation {
            ProxyRepresentation(exporting: \.image)
        }
        public var image: Image
        public var caption: String
    }
        
    @MainActor func getTransferable(_ view: some View, scale: CGFloat, caption: String) -> ImageShareTransferable? {
        if let uiImage = getUIImage(view, scale: scale) {
            return ImageShareTransferable(image: Image(uiImage: uiImage), caption: caption)
        }
        return nil
    }
    
    
    @MainActor private func getUIImage(_ view: some View, scale: CGFloat) -> UIImage? {
        let renderer = ImageRenderer(content: view)
        // make sure and use the correct display scale for this device
        renderer.scale = scale
        if let uiImage = renderer.uiImage {
                return uiImage
        }
        return nil
    }

}
