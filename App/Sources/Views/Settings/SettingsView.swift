import SwiftUI

/// Ported from `settings/page.tsx` — a placeholder header, same as the web
/// version (no settings fields exist there yet either).
struct SettingsView: View {
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("Settings")
                    .font(.title2.weight(.semibold))
                Spacer()
            }
            .padding(20)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.appBackground)
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SettingsView()
}
