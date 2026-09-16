import SwiftUI

/// Ported from `NotePager.tsx` — dot pagination with prev/next arrows.
/// Hidden entirely when there's only one page, matching the original.
struct NotePagerView: View {
    let pageCount: Int
    @Binding var currentIndex: Int

    var body: some View {
        if pageCount > 1 {
            HStack(spacing: 16) {
                pagerButton(systemImage: "chevron.left", disabled: currentIndex == 0) {
                    currentIndex = max(0, currentIndex - 1)
                }

                HStack(spacing: 6) {
                    ForEach(0..<pageCount, id: \.self) { index in
                        Button {
                            currentIndex = index
                        } label: {
                            Capsule()
                                .fill(index == currentIndex ? Color.appAccentSolid : Color.appBorderStrong)
                                .frame(width: index == currentIndex ? 24 : 6, height: 6)
                        }
                        .animation(.easeOut(duration: 0.15), value: currentIndex)
                    }
                }

                pagerButton(systemImage: "chevron.right", disabled: currentIndex == pageCount - 1) {
                    currentIndex = min(pageCount - 1, currentIndex + 1)
                }

                Text("Page \(currentIndex + 1) of \(pageCount)")
                    .font(.caption)
                    .foregroundStyle(Color.appMutedForeground)
            }
            .padding(.top, 16)
            .overlay(Divider().overlay(Color.appBorder), alignment: .top)
        }
    }

    private func pagerButton(systemImage: String, disabled: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: systemImage)
                .font(.system(size: 13, weight: .medium))
                .foregroundStyle(disabled ? Color.appMutedForeground.opacity(0.4) : Color.appMutedForeground)
                .frame(width: 32, height: 32)
                .overlay(
                    RoundedRectangle(cornerRadius: AppRadius.sm, style: .continuous)
                        .stroke(Color.appBorder, lineWidth: 1)
                )
        }
        .disabled(disabled)
    }
}
