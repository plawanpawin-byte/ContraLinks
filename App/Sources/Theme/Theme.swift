import SwiftUI

/// Color tokens ported from the web app's `globals.css` (light/dark pairs),
/// so the iOS UI shell reads as the same product instead of a generic
/// SwiftUI default look.
extension Color {
    private static func dynamic(light: UIColor, dark: UIColor) -> Color {
        Color(UIColor { trait in
            trait.userInterfaceStyle == .dark ? dark : light
        })
    }

    static let appBackground = dynamic(light: UIColor(hex: "#FFFFFF"), dark: UIColor(hex: "#232323"))
    static let appSurface = dynamic(light: UIColor(hex: "#FFFFFF"), dark: UIColor(hex: "#262626"))
    static let appSurfaceRaised = dynamic(light: UIColor(hex: "#FFFFFF"), dark: UIColor(hex: "#2F2F2F"))
    static let appCanvasBackground = dynamic(light: UIColor(hex: "#FFFFFF"), dark: UIColor(hex: "#1A1A1A"))
    static let appForeground = dynamic(light: UIColor(hex: "#1A1A1E"), dark: UIColor(hex: "#F2F2F2"))
    static let appMutedForeground = dynamic(light: UIColor(hex: "#6B6B76"), dark: UIColor(hex: "#9A9AA0"))
    static let appBorder = dynamic(light: UIColor(hex: "#E8E8E8"), dark: UIColor(hex: "#3A3A3A"))
    static let appBorderStrong = dynamic(light: UIColor(hex: "#D8D8DC"), dark: UIColor(hex: "#4A4A4A"))
    static let appAccentSolid = dynamic(light: UIColor(hex: "#6D6BFF"), dark: UIColor(hex: "#8F8DFF"))
    static let appAccentForeground = dynamic(light: UIColor(hex: "#FFFFFF"), dark: UIColor(hex: "#0D0D11"))
}

private extension UIColor {
    convenience init(hex: String) {
        let cleaned = hex.trimmingCharacters(in: .init(charactersIn: "#"))
        var rgb: UInt64 = 0
        Scanner(string: cleaned).scanHexInt64(&rgb)
        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255
        let g = CGFloat((rgb & 0x00FF00) >> 8) / 255
        let b = CGFloat(rgb & 0x0000FF) / 255
        self.init(red: r, green: g, blue: b, alpha: 1)
    }
}

/// Corner radius tokens (`--radius-sm/md/lg`).
enum AppRadius {
    static let sm: CGFloat = 10
    static let md: CGFloat = 12
    static let lg: CGFloat = 16
}

/// The `.card-surface` utility: surface background, hairline border, soft shadow.
struct CardSurface: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color.appSurface)
            .clipShape(RoundedRectangle(cornerRadius: AppRadius.lg, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: AppRadius.lg, style: .continuous)
                    .stroke(Color.appBorder, lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.08), radius: 16, x: 0, y: 8)
    }
}

extension View {
    func cardSurface() -> some View {
        modifier(CardSurface())
    }
}
