import SwiftUI

struct ColorsCatalogView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                colorSection("Surface", tokens: [
                    ("surfaceBackground", "EEEFF3", DSColorToken.surfaceBackground),
                    ("surfacePrimary", "FFFFFF", DSColorToken.surfacePrimary),
                    ("surfaceSecondary", "EEEFF3", DSColorToken.surfaceSecondary),
                    ("surfaceTertiary", "DFDFE8", DSColorToken.surfaceTertiary),
                    ("surfaceOpacity", "FFFFFF 70%", DSColorToken.surfaceOpacity),
                    ("surfaceOpacityFixed12", "FFFFFF 12%", DSColorToken.surfaceOpacityFixed12),
                    ("surfaceLightFixed", "FFFFFF", DSColorToken.surfaceLightFixed),
                    ("surfaceInverted", "1E2128", DSColorToken.surfaceInverted),
                    ("surfaceAccent", "3363F7", DSColorToken.surfaceAccent),
                    ("surfaceAccentPale", "CCD4F4", DSColorToken.surfaceAccentPale),
                    ("surfaceSuccess", "009D3E", DSColorToken.surfaceSuccess),
                    ("surfaceWarning", "F57A29", DSColorToken.surfaceWarning),
                    ("surfaceNegative", "DC0011", DSColorToken.surfaceNegative),
                    ("surfaceOverlay", "1E2128 50%", DSColorToken.surfaceOverlay),
                ])

                colorSection("Icotex", tokens: [
                    ("icotexPrimary", "1E2128", DSColorToken.icotexPrimary),
                    ("icotexPrimaryInverted", "FAFAFF", DSColorToken.icotexPrimaryInverted),
                    ("icotexSecondary", "434C5B", DSColorToken.icotexSecondary),
                    ("icotexTertiary", "929BAE", DSColorToken.icotexTertiary),
                    ("icotexAccent", "1F48DA", DSColorToken.icotexAccent),
                    ("icotexSuccess", "00872A", DSColorToken.icotexSuccess),
                    ("icotexWarning", "E9640B", DSColorToken.icotexWarning),
                    ("icotexNegative", "BE0000", DSColorToken.icotexNegative),
                    ("icotexLightFixed", "FAFAFF", DSColorToken.icotexLightFixed),
                    ("icotexLightFixed70", "FFFFFF 70%", DSColorToken.icotexLightFixed70),
                    ("icotexDarkFixed", "1E2128", DSColorToken.icotexDarkFixed),
                ])

                colorSection("Outline", tokens: [
                    ("outlineDivider", "EEEFF3", DSColorToken.outlineDivider),
                    ("outlineBorder", "C1C7D4", DSColorToken.outlineBorder),
                    ("outlineAccent", "3363F7", DSColorToken.outlineAccent),
                    ("outlineNegative", "DC0011", DSColorToken.outlineNegative),
                    ("outlineLightFixed", "FFFFFF", DSColorToken.outlineLightFixed),
                    ("outlineLightFixed12", "FFFFFF 12%", DSColorToken.outlineLightFixed12),
                ])

                colorSection("Interact", tokens: [
                    ("interactIcotexDisable", "A9B1C1", DSColorToken.interactIcotexDisable),
                    ("interactAccentAction", "0F2CBB", DSColorToken.interactAccentAction),
                    ("interactAccentPaleAction", "A8B7F0", DSColorToken.interactAccentPaleAction),
                    ("interactSuccessAction", "007218", DSColorToken.interactSuccessAction),
                    ("interactWarningAction", "C0540C", DSColorToken.interactWarningAction),
                    ("interactNegativeAction", "9F0000", DSColorToken.interactNegativeAction),
                    ("interactLightFixedAction", "FFFFFF 90%", DSColorToken.interactLightFixedAction),
                    ("interactActionDisabled", "D9DDE5", DSColorToken.interactActionDisabled),
                    ("interactActionPressed", "D9DDE5", DSColorToken.interactActionPressed),
                    ("interactMainInverted70", "434C5B 70%", DSColorToken.interactMainInverted70),
                ])
            }
            .padding()
        }
    }

    private func colorSection(_ title: String, tokens: [(String, String, Color)]) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)
                .foregroundStyle(.secondary)

            LazyVGrid(columns: [
                GridItem(.flexible(), spacing: 12),
                GridItem(.flexible(), spacing: 12),
            ], spacing: 12) {
                ForEach(tokens, id: \.0) { name, hex, color in
                    colorCell(name: name, hex: hex, color: color)
                }
            }
        }
    }

    private func colorCell(name: String, hex: String, color: Color) -> some View {
        VStack(spacing: 6) {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(color)
                .frame(height: 56)
                .overlay(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                )
                .overlay(
                    Text("#\(hex)")
                        .font(.system(size: 12, weight: .semibold, design: .monospaced))
                        .foregroundStyle(.white)
                        .shadow(color: .black.opacity(0.5), radius: 2, x: 0, y: 1)
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
