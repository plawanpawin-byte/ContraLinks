import SwiftUI

/// Ported from `NoteDetailView.tsx` — editable title, tag pills, a
/// card-surface content area that swaps between rendered markdown and a
/// plain text editor, and page-dot pagination.
struct NoteDetailView: View {
    @State private var title: String
    @State private var tags: [NoteTag]
    @State private var pages: [NotePage]
    @State private var currentIndex = 0
    @State private var isEditing: Bool

    init(note: Note, startEditing: Bool = false) {
        _title = State(initialValue: note.title)
        _tags = State(initialValue: note.tags)
        _pages = State(initialValue: note.pages)
        _isEditing = State(initialValue: startEditing)
    }

    private var currentPage: NotePage {
        pages[currentIndex]
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                HStack(alignment: .top, spacing: 12) {
                    TextField("Title", text: $title)
                        .font(.title2.weight(.semibold))
                        .foregroundStyle(Color.appForeground)

                    Button {
                        isEditing.toggle()
                    } label: {
                        HStack(spacing: 6) {
                            Image(systemName: isEditing ? "eye" : "pencil")
                            Text(isEditing ? "View" : "Edit")
                        }
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(Color.appMutedForeground)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .overlay(
                            RoundedRectangle(cornerRadius: AppRadius.sm, style: .continuous)
                                .stroke(Color.appBorder, lineWidth: 1)
                        )
                    }
                    .fixedSize()
                }

                TagEditorRow(tags: $tags)

                Group {
                    if isEditing {
                        TextEditor(text: pageBinding)
                            .frame(minHeight: 220)
                            .scrollContentBackground(.hidden)
                    } else {
                        Text(renderedMarkdown)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding(20)
                .cardSurface()

                NotePagerView(pageCount: pages.count, currentIndex: $currentIndex)
            }
            .padding(20)
        }
        .background(Color.appBackground)
        .navigationBarTitleDisplayMode(.inline)
    }

    private var pageBinding: Binding<String> {
        Binding(
            get: { pages[currentIndex].contentMarkdown },
            set: { pages[currentIndex].contentMarkdown = $0 }
        )
    }

    private var renderedMarkdown: AttributedString {
        (try? AttributedString(markdown: currentPage.contentMarkdown))
            ?? AttributedString(currentPage.contentMarkdown)
    }
}

#Preview {
    NavigationStack {
        NoteDetailView(note: MockData.notes[0])
    }
}
