import Foundation

struct NoteTag: Identifiable, Hashable {
    let id: String
    let name: String
}

struct NotePage: Identifiable, Hashable {
    let pageNumber: Int
    var contentMarkdown: String

    var id: Int { pageNumber }
}

struct Note: Identifiable, Hashable {
    let id: String
    var title: String
    var tags: [NoteTag]
    var pages: [NotePage]
    var updatedAt: Date
}

/// Static placeholder data for this UI-shell pass — no networking or
/// persistence yet, this mirrors the web app's `/api/notes` response shape
/// closely enough that wiring up a real data layer later is a drop-in.
enum MockData {
    static let notes: [Note] = [
        Note(
            id: "1",
            title: "Product roadmap Q3",
            tags: [NoteTag(id: "t1", name: "work")],
            pages: [NotePage(pageNumber: 1, contentMarkdown: "## Goals\n\nShip the canvas view and graph view.")],
            updatedAt: Date().addingTimeInterval(-3_600)
        ),
        Note(
            id: "2",
            title: "Reading list",
            tags: [NoteTag(id: "t2", name: "personal")],
            pages: [NotePage(pageNumber: 1, contentMarkdown: "- Thinking in Systems\n- The Pragmatic Programmer")],
            updatedAt: Date().addingTimeInterval(-86_400)
        ),
        Note(
            id: "3",
            title: "Meeting notes — design sync",
            tags: [NoteTag(id: "t1", name: "work"), NoteTag(id: "t3", name: "design")],
            pages: [
                NotePage(pageNumber: 1, contentMarkdown: "Discussed the new tag editor layout."),
                NotePage(pageNumber: 2, contentMarkdown: "Follow-ups: spacing pass, icon rail widths."),
            ],
            updatedAt: Date().addingTimeInterval(-172_800)
        ),
    ]
}
