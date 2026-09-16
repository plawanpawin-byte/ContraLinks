import SwiftUI

/// Ported from `plugins/page.tsx` + `TagPluginCard.tsx`. The web card's
/// keyboard-shortcut recorder has no touch equivalent, so this keeps the
/// install/uninstall toggle and drops the shortcut affordance.
struct PluginsView: View {
    @State private var tagPluginInstalled = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Plugins")
                            .font(.title2.weight(.semibold))
                        Text("Extra tools you can turn on for ContraLinks.")
                            .font(.subheadline)
                            .foregroundStyle(Color.appMutedForeground)
                    }

                    tagPluginCard
                }
                .padding(20)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .background(Color.appBackground)
            .navigationTitle("Plugins")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private var tagPluginCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 12) {
                RoundedRectangle(cornerRadius: AppRadius.md, style: .continuous)
                    .fill(Color.appAccentSolid)
                    .frame(width: 40, height: 40)
                    .overlay(
                        Image(systemName: "tag")
                            .foregroundStyle(Color.appAccentForeground)
                    )

                VStack(alignment: .leading, spacing: 2) {
                    Text("Tag")
                        .font(.subheadline.weight(.semibold))
                    Text("Organize notes with custom tags")
                        .font(.caption)
                        .foregroundStyle(Color.appMutedForeground)
                }
            }

            Text("Create your own tag names, attach them to notes, and see them right on the card.")
                .font(.caption)
                .foregroundStyle(Color.appMutedForeground)

            if tagPluginInstalled {
                HStack {
                    Label("Installed", systemImage: "checkmark")
                        .font(.caption)
                        .foregroundStyle(Color.appMutedForeground)

                    Spacer()

                    Button("Uninstall") {
                        tagPluginInstalled = false
                    }
                    .font(.caption.weight(.medium))
                    .foregroundStyle(Color.appMutedForeground)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .overlay(
                        RoundedRectangle(cornerRadius: AppRadius.sm, style: .continuous)
                            .stroke(Color.appBorder, lineWidth: 1)
                    )
                }
            } else {
                Button("Install") {
                    tagPluginInstalled = true
                }
                .font(.caption.weight(.medium))
                .foregroundStyle(Color.appAccentForeground)
                .padding(.horizontal, 12)
                .padding(.vertical, 7)
                .background(Color.appAccentSolid)
                .clipShape(RoundedRectangle(cornerRadius: AppRadius.sm, style: .continuous))
            }
        }
        .padding(20)
        .cardSurface()
    }
}

#Preview {
    PluginsView()
}
