import SwiftUI

struct ColorsCatalogView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                colorSection("Surface", tokens: [
                    ("surfaceBackground", DSColorToken.surfaceBackground),
                    ("surfacePrimary", DSColorToken.surfacePrimary),
                    ("surfaceSecondary", DSColorToken.surfaceSecondary),
                    ("surfaceTertiary", DSColorToken.surfaceTertiary),
                    ("surfaceOpacity", DSColorToken.surfaceOpacity),
                    ("surfaceOpacityFixed12", DSColorToken.surfaceOpacityFixed12),
                    ("surfaceLightFixed", DSColorToken.surfaceLightFixed),
                    ("surfaceInverted", DSColorToken.surfaceInverted),
                    ("surfaceAccent", DSColorToken.surfaceAccent),
                    ("surfaceAccentPale", DSColorToken.surfaceAccentPale),
                    ("surfaceSuccess", DSColorToken.surfaceSuccess),
                    ("surfaceWarning", DSColorToken.surfaceWarning),
                    ("surfaceNegative", DSColorToken.surfaceNegative),
                    ("surfaceOverlay", DSColorToken.surfaceOverlay),
                ])

                colorSection("Icotex", tokens: [
                    ("icotexPrimary", DSColorToken.icotexPrimary),
                    ("icotexPrimaryInverted", DSColorToken.icotexPrimaryInverted),
                    ("icotexSecondary", DSColorToken.icotexSecondary),
                    ("icotexTertiary", DSColorToken.icotexTertiary),
                    ("icotexAccent", DSColorToken.icotexAccent),
                    ("icotexSuccess", DSColorToken.icotexSuccess),
                    ("icotexWarning", DSColorToken.icotexWarning),
                    ("icotexNegative", DSColorToken.icotexNegative),
                    ("icotexLightFixed", DSColorToken.icotexLightFixed),
                    ("icotexLightFixed70", DSColorToken.icotexLightFixed70),
                    ("icotexDarkFixed", DSColorToken.icotexDarkFixed),
                ])

                colorSection("Outline", tokens: [
                    ("outlineDivider", DSColorToken.outlineDivider),
                    ("outlineBorder", DSColorToken.outlineBorder),
                    ("outlineAccent", DSColorToken.outlineAccent),
                    ("outlineNegative", DSColorToken.outlineNegative),
                    ("outlineLightFixed", DSColorToken.outlineLightFixed),
                    ("outlineLightFixed12", DSColorToken.outlineLightFixed12),
                ])

                colorSection("Interact", tokens: [
                    ("interactIcotexDisable", DSColorToken.interactIcotexDisable),
                    ("interactAccentAction", DSColorToken.interactAccentAction),
                    ("interactAccentPaleAction", DSColorToken.interactAccentPaleAction),
                    ("interactSuccessAction", DSColorToken.interactSuccessAction),
                    ("interactWarningAction", DSColorToken.interactWarningAction),
                    ("interactNegativeAction", DSColorToken.interactNegativeAction),
                    ("interactLightFixedAction", DSColorToken.interactLightFixedAction),
                    ("interactActionDisabled", DSColorToken.interactActionDisabled),
                    ("interactActionPressed", DSColorToken.interactActionPressed),
                    ("interactMainInverted70", DSColorToken.interactMainInverted70),
                ])
            }
            .padding()
        }
    }

    private func colorSection(_ title: String, tokens: [(String, Color)]) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)
                .foregroundStyle(.secondary)

            LazyVGrid(columns: [
                GridItem(.flexible(), spacing: 12),
                GridItem(.flexible(), spacing: 12),
            ], spacing: 12) {
                ForEach(tokens, id: \.0) { name, color in
                    colorCell(name: name, color: color)
                }
            }
        }
    }

    private func colorCell(name: String, color: Color) -> some View {
        VStack(spacing: 6) {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(color)
                .frame(height: 56)
                .overlay(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                )

            Text(name)
                .font(.system(size: 11, weight: .medium, design: .monospaced))
                .foregroundStyle(.primary)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
        }
    }
}

#Preview {
    NavigationStack {
        ColorsCatalogView()
            .navigationTitle("Colors")
    }
}
