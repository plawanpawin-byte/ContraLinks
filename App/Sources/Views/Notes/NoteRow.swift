import SwiftUI

struct NoteRow: View {
    let note: Note

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "doc.text")
                .font(.system(size: 13))
                .foregroundStyle(Color.appMutedForeground)

            Text(note.title)
                .font(.subheadline)
                .foregroundStyle(Color.appForeground)
                .lineLimit(1)

            ForEach(note.tags) { tag in
                TagChip(name: tag.name)
            }

            Spacer()

            Text(Self.dateFormatter.string(from: note.updatedAt))
                .font(.caption)
                .foregroundStyle(Color.appMutedForeground)
        }
        .padding(.vertical, 4)
    }
}
