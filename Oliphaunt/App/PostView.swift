import SwiftUI

struct PostView: View {
    var post: Post
    var booster: Account?

    init(post: Post) {
        self.post = post.displayPost
        if post.reblog != nil {
            booster = post.account
        }
    }

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            AvatarView(url: post.account.avatarStatic)

            content
        }
    }

    @ViewBuilder
    private var content: some View {
        VStack(alignment: .leading, spacing: 8) {
            ViewThatFits {
                HStack {
                    identity
                }

                VStack(alignment: .leading) {
                    identity
                }
            }

            if let content = post.content {
                Text(content.attributedString)
            } else {
                Text("(This post doesn't have content)")
                    .foregroundColor(.red)
            }
        }
    }

    @ViewBuilder
    private var identity: some View {
        Text(post.account.displayName)
            .font(.headline)

        ViewThatFits {
            HStack(alignment: .firstTextBaseline, spacing: 0) {
                username
            }
            VStack(alignment: .leading, spacing: 0) {
                username
            }
        }
    }

    @ViewBuilder
    private var username: some View {
        let c = post.account.formattedUsernameComponents
        Text(c.handle)
            .foregroundStyle(.secondary)
        if let server = c.server {
            Text(server)
                .foregroundStyle(.tertiary)
        }
    }
}

#if DEBUG
struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(post: .reblog)
            .frame(width: 300)
            .padding()
    }
}
#endif
