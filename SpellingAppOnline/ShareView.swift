import SwiftUI

struct ShareView<Content: View>: View {
    let content: Content
    let caption: String
    
    @StateObject var imageManager: ImageManager = ImageManager()
    
    @Environment(\.displayScale) var displayScale
    @State private var imageShareTransferable: ImageManager.ImageShareTransferable?
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
            if let imageShareTransferable = imageShareTransferable {
                ShareLink(
                    item: imageShareTransferable,
                    preview: SharePreview(
                        imageShareTransferable.caption,
                        image: imageShareTransferable.image)) {
                            HStack {
                                Image(systemName: "square.and.arrow.up")
                                Text("Share my Results")

                            }
                        }
                        .padding()
            }
        }
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        }
        .onAppear {
            imageShareTransferable = imageManager.getTransferable(content, scale: displayScale, caption: caption)
        }
    }
}
    
