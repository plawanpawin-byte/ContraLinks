import SwiftUI

enum NoteSortKey {
    case updated
    case name
}

/// Ported from the web app's `AllFilesView` — the landing list of every
/// note, sortable, with an inline "New" action. Backed by `MockData` for
/// this UI-shell pass; a real data layer swaps in behind `notes` later.
struct NotesListView: View {
    @State private var notes: [Note] = MockData.notes
    @State private var sortKey: NoteSortKey = .updated
    @State private var tagFilter: String?
    @State private var path: [Note] = []

    private var sorted: [Note] {
        let filtered = tagFilter.map { tag in
            notes.filter { note in note.tags.contains { $0.name == tag } }
        } ?? notes

        switch sortKey {
        case .name:
            return filtered.sorted { $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedAscending }
        case .updated:
            return filtered.sorted { $0.updatedAt > $1.updatedAt }
        }
    }

    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 0) {
                header
                Divider().overlay(Color.appBorder)
                content
            }
            .background(Color.appBackground)
            .navigationTitle("Links")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: Note.self) { note in
                NoteDetailView(note: note)
            }
        }
    }

    private var header: some View {
        HStack {
            HStack(spacing: 8) {
                Text("\(sorted.count) \(sorted.count == 1 ? "note" : "notes")")
                    .font(.subheadline)
                    .foregroundStyle(Color.appMutedForeground)

                if let tagFilter {
                    Button {
                        self.tagFilter = nil
                    } label: {
                        HStack(spacing: 4) {
                            Text(tagFilter)
                            Image(systemName: "xmark")
                                .font(.system(size: 9, weight: .semibold))
                        }
                        .font(.caption.weight(.medium))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 3)
                        .background(Color.appAccentSolid)
                        .foregroundStyle(Color.appAccentForeground)
                        .clipShape(Capsule())
                    }
                }
            }

            Spacer()

            HStack(spacing: 6) {
                Button {
                    sortKey = sortKey == .updated ? .name : .updated
                } label: {
                    HStack(spacing: 6) {
                        Image(systemName: "arrow.up.arrow.down")
                            .font(.system(size: 12))
                        Text(sortKey == .updated ? "Last updated" : "Name")
                            .font(.caption.weight(.medium))
                    }
                    .foregroundStyle(Color.appMutedForeground)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(Color.appSurfaceRaised)
                    .clipShape(RoundedRectangle(cornerRadius: AppRadius.sm, style: .continuous))
                }

                Button {
                    createNote()
                } label: {
                    HStack(spacing: 6) {
                        Image(systemName: "plus")
                            .font(.system(size: 12, weight: .semibold))
                        Text("New")
                            .font(.caption.weight(.medium))
                    }
                    .foregroundStyle(Color.appAccentForeground)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(Color.appAccentSolid)
                    .clipShape(RoundedRectangle(cornerRadius: AppRadius.sm, style: .continuous))
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
    }

    @ViewBuilder
    private var content: some View {
        if sorted.isEmpty {
            VStack(spacing: 12) {
                Image(systemName: "doc.text")
                    .font(.system(size: 28))
                    .foregroundStyle(Color.appMutedForeground)
                Text(tagFilter.map { "No notes tagged \"\($0)\"." } ?? "No notes yet — create one to get started.")
                    .font(.subheadline)
                    .foregroundStyle(Color.appMutedForeground)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(32)
        } else {
            List {
                ForEach(sorted) { note in
                    NavigationLink(value: note) {
                        NoteRow(note: note)
                    }
                    .listRowBackground(Color.appBackground)
                    .listRowSeparatorTint(Color.appBorder)
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
        }
    }

    private func createNote() {
        let note = Note(
            id: UUID().uuidString,
            title: "Untitled",
            tags: [],
            pages: [NotePage(pageNumber: 1, contentMarkdown: "")],
            updatedAt: Date()
        )
        notes.insert(note, at: 0)
        path.append(note)
    }
}

#Preview {
    NotesListView()
}
