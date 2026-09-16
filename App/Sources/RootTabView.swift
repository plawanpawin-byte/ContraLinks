import SwiftUI

/// The phone-width nav, ported from the web app's `MobileNav` (the desktop
/// icon rail collapses to this same three-tab bar below the `md` breakpoint,
/// so it's the natural native-iOS analog rather than the rail).
struct RootTabView: View {
    var body: some View {
        TabView {
            PluginsView()
                .tabItem { Label("Plugins", systemImage: "puzzlepiece.extension") }

            NotesListView()
                .tabItem { Label("Links", systemImage: "square.stack") }

            SettingsView()
                .tabItem { Label("Settings", systemImage: "gearshape") }
        }
        .tint(Color.appAccentSolid)
    }
}

#Preview {
    RootTabView()
}
