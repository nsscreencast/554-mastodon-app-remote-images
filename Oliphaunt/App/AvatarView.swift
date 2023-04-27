//
//  AvatarView.swift
//  Oliphaunt
//
//  Created by Guilherme Rambo on 31/03/23.
//

import SwiftUI
import Nuke

extension ImagePipeline {
    static let oliphaunt = ImagePipeline()
}

struct RemoteImageView<Content: View, Placeholder: View>: View {
    var url: URL
    @ViewBuilder var content: (Image) -> Content
    @ViewBuilder var placeholder: () -> Placeholder

    @State private var image: NSImage?

    var body: some View {
        ZStack {
            if let image {
                content(Image(nsImage: image))
            } else {
                placeholder()
            }
        }
            .task {
                do {
                    let image = try await ImagePipeline.oliphaunt.image(for: url)

                    self.image = image
                } catch {
                    /// Not actually needed
                }
            }
    }
}

struct AvatarView: View {
    var url: URL

    var body: some View {
        RemoteImageView(url: url) { image in
            image
                .resizable()
        } placeholder: {
            Rectangle()
                .foregroundStyle(.quaternary)
        }
            .aspectRatio(contentMode: .fit)
            .frame(width: 40)
            .clipShape(Circle())
    }
}

#if DEBUG
struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        PostView_Previews.previews
    }
}
#endif
