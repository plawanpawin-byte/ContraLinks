import SwiftUI

struct TagChip: View {
    let name: String

    var body: some View {
        Text(name)
            .font(.system(size: 10))
            .foregroundStyle(Color.appMutedForeground)
            .padding(.horizontal, 8)
            .padding(.vertical, 2)
            .background(Color.appSurfaceRaised)
            .clipShape(Capsule())
    }
}
