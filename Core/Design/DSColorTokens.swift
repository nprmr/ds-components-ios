import SwiftUI

// MARK: - Design System Color Tokens
// Single source of truth — 41 tokens, 4 semantic groups
// Light theme values. Dark theme TBD (Figma Variable modes).

enum DSColorToken {

    // MARK: - Surface (14)
    // Backgrounds: screens, cards, containers

    static let surfaceBackground = Color(hex: "EEEFF3")
    static let surfacePrimary = Color(hex: "FFFFFF")
    static let surfaceSecondary = Color(hex: "EEEFF3")
    static let surfaceTertiary = Color(hex: "DFDFE8")
    static let surfaceOpacity = Color(hex: "FFFFFF").opacity(0.7)
    static let surfaceOpacityFixed12 = Color(hex: "FFFFFF").opacity(0.12)
    static let surfaceLightFixed = Color(hex: "FFFFFF")
    static let surfaceInverted = Color(hex: "1E2128")
    static let surfaceAccent = Color(hex: "3363F7")
    static let surfaceAccentPale = Color(hex: "CCD4F4")
    static let surfaceSuccess = Color(hex: "009D3E")
    static let surfaceWarning = Color(hex: "F57A29")
    static let surfaceNegative = Color(hex: "DC0011")
    static let surfaceOverlay = Color(hex: "1E2128").opacity(0.5)

    // MARK: - Icotex (11)
    // Text and icon colors

    static let icotexPrimary = Color(hex: "1E2128")
    static let icotexPrimaryInverted = Color(hex: "FAFAFF")
    static let icotexSecondary = Color(hex: "434C5B")
    static let icotexTertiary = Color(hex: "929BAE")
    static let icotexAccent = Color(hex: "1F48DA")
    static let icotexSuccess = Color(hex: "00872A")
    static let icotexWarning = Color(hex: "E9640B")
    static let icotexNegative = Color(hex: "BE0000")
    static let icotexLightFixed = Color(hex: "FAFAFF")
    static let icotexLightFixed70 = Color(hex: "FFFFFF").opacity(0.7)
    static let icotexDarkFixed = Color(hex: "1E2128")

    // MARK: - Outline (6)
    // Borders, dividers, strokes

    static let outlineDivider = Color(hex: "EEEFF3")
    static let outlineBorder = Color(hex: "C1C7D4")
    static let outlineAccent = Color(hex: "3363F7")
    static let outlineNegative = Color(hex: "DC0011")
    static let outlineLightFixed = Color(hex: "FFFFFF")
    static let outlineLightFixed12 = Color(hex: "FFFFFF").opacity(0.12)

    // MARK: - Interact (10)
    // Pressed, disabled, hover states

    static let interactIcotexDisable = Color(hex: "A9B1C1")
    static let interactAccentAction = Color(hex: "0F2CBB")
    static let interactAccentPaleAction = Color(hex: "A8B7F0")
    static let interactSuccessAction = Color(hex: "007218")
    static let interactWarningAction = Color(hex: "C0540C")
    static let interactNegativeAction = Color(hex: "9F0000")
    static let interactLightFixedAction = Color(hex: "FFFFFF").opacity(0.9)
    static let interactActionDisabled = Color(hex: "D9DDE5")
    static let interactActionPressed = Color(hex: "D9DDE5")
    static let interactMainInverted70 = Color(hex: "434C5B").opacity(0.7)
}
