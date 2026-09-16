# ContraLinks (iOS)

A native SwiftUI **UI shell** ported from the [FlowLinks](https://github.com/plawanpawin-byte) note-taking web app. This first pass recreates the look and layout of the core screens — it does not yet talk to a server; note data is static/mock (`App/Sources/Models/Note.swift`).

## What's here

- `Links` tab — note list (`NotesListView`, ported from `AllFilesView.tsx`) → note detail (`NoteDetailView`, with tag pills, markdown preview/edit toggle, and page-dot pagination)
- `Plugins` tab — ported from `plugins/page.tsx` (Tag plugin card, install/uninstall)
- `Settings` tab — placeholder, matching the web version (which also has no fields yet)
- Colors, radii, and the card-surface style are ported 1:1 from the web app's `globals.css` tokens (`App/Sources/Theme/Theme.swift`), with light/dark variants

Not included in this pass (bigger, separate effort if you want them next): the canvas/graph view, freehand handwriting capture, voice notes, and the Claude chat panel — those depend on heavier native equivalents (a canvas/graph engine, PencilKit, etc.) that are worth scoping on their own.

## Building via GitHub Actions (no Mac needed)

Every push to `main` runs `.github/workflows/build-ipa.yml` on a GitHub-hosted macOS runner: it installs XcodeGen, generates the project, builds the app **unsigned** (`CODE_SIGNING_ALLOWED=NO`), and packages it as `ContraLinks.ipa`.

To get the file: open the repo's **Actions** tab → latest run → download the `ContraLinks-unsigned-ipa` artifact (a zip containing the `.ipa`).

This `.ipa` is unsigned, which is exactly what tools like **AltStore** / **SideStore** expect — they re-sign it with your own Apple ID at install time. Add it in AltStore via **My Apps → + → pick the file**.

You can also trigger a build manually without pushing: Actions tab → "Build unsigned IPA" → **Run workflow**.

## Building this on a Mac (e.g. MacinCloud)

This project uses [XcodeGen](https://github.com/yonaskolb/XcodeGen) to generate the `.xcodeproj` from `project.yml` — that file is not committed, so you regenerate it fresh:

```bash
brew install xcodegen
cd ContraLinks
xcodegen generate
open ContraLinks.xcodeproj
```

Then in Xcode:

1. Select the `ContraLinks` target → **Signing & Capabilities** → choose your Apple ID / team (Automatic signing is already set).
2. Pick a simulator or your device and hit **Run** to try it first.
3. To produce an `.ipa`: **Product → Archive**, then in the Organizer window **Distribute App** → choose *Development* or *Ad Hoc* (no paid Apple Developer account needed for a device you own, just a free Apple ID for local testing — TestFlight/App Store distribution needs the paid program) → export, which gives you the `.ipa` file.

## Requirements

- Xcode 15+ (iOS 17 deployment target)
- XcodeGen (`brew install xcodegen`)
