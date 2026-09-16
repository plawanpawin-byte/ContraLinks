import SwiftUI

/// Ported from `NoteTagEditor.tsx` — removable pills plus an "add tag"
/// affordance. The web version's popover (existing tags + inline create)
/// collapses to a single alert-driven text prompt here, since a hover
/// popover has no direct touch equivalent.
struct TagEditorRow: View {
    @Binding var tags: [NoteTag]
    @State private var isAddingTag = false
    @State private var newTagName = ""

    var body: some View {
        FlowLayout(spacing: 6) {
            ForEach(tags) { tag in
                HStack(spacing: 4) {
                    Text(tag.name)
                    Button {
                        tags.removeAll { $0.id == tag.id }
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 9, weight: .semibold))
                    }
                }
                .font(.caption)
                .foregroundStyle(Color.appMutedForeground)
                .padding(.horizontal, 10)
                .padding(.vertical, 3)
                .background(Color.appSurfaceRaised)
                .clipShape(Capsule())
            }

            Button {
                isAddingTag = true
            } label: {
                HStack(spacing: 4) {
                    Image(systemName: "plus")
                        .font(.system(size: 9, weight: .semibold))
                    Text("Tag")
                }
                .font(.caption)
                .foregroundStyle(Color.appMutedForeground)
                .padding(.horizontal, 10)
                .padding(.vertical, 3)
                .overlay(
                    Capsule().strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [3, 3]))
                        .foregroundStyle(Color.appBorderStrong)
                )
            }
        }
        .alert("New tag", isPresented: $isAddingTag) {
            TextField("Tag name", text: $newTagName)
            Button("Add") {
                let name = newTagName.trimmingCharacters(in: .whitespacesAndNewlines)
                if !name.isEmpty {
                    tags.append(NoteTag(id: UUID().uuidString, name: name))
                }
                newTagName = ""
            }
            Button("Cancel", role: .cancel) {
                newTagName = ""
            }
        }
    }
}

/// Minimal wrapping HStack — SwiftUI has no built-in flow layout pre-iOS 16
/// `Layout` usage kept simple here since tag lists are short.
struct FlowLayout: Layout {
    var spacing: CGFloat = 6

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let maxWidth = proposal.width ?? .infinity
        var rowWidth: CGFloat = 0
        var totalHeight: CGFloat = 0
        var rowHeight: CGFloat = 0

        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            if rowWidth + size.width > maxWidth, rowWidth > 0 {
                totalHeight += rowHeight + spacing
                rowWidth = 0
                rowHeight = 0
            }
            rowWidth += size.width + spacing
            rowHeight = max(rowHeight, size.height)
        }
        totalHeight += rowHeight
        return CGSize(width: maxWidth, height: totalHeight)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var origin = bounds.origin
        var rowHeight: CGFloat = 0

        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            if origin.x + size.width > bounds.maxX, origin.x > bounds.minX {
                origin.x = bounds.minX
                origin.y += rowHeight + spacing
                rowHeight = 0
            }
            subview.place(at: origin, proposal: .unspecified)
            origin.x += size.width + spacing
            rowHeight = max(rowHeight, size.height)
        }
    }
}
