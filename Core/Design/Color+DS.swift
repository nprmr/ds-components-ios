import SwiftUI

// MARK: - Color Hex Initializer

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b, a: UInt64
        switch hex.count {
        case 6:
            (r, g, b, a) = ((int >> 16) & 0xFF, (int >> 8) & 0xFF, int & 0xFF, 255)
        case 8:
            (r, g, b, a) = ((int >> 24) & 0xFF, (int >> 16) & 0xFF, (int >> 8) & 0xFF, int & 0xFF)
        default:
            (r, g, b, a) = (0, 0, 0, 255)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// MARK: - Design System Button Colors

extension Color {
    // MARK: Primary
    static let buttonPrimaryRest = Color(hex: "3363F7")
    static let buttonPrimaryPressed = Color(hex: "0F2CBB")

    // MARK: Secondary
    static let buttonSecondaryRest = Color(hex: "CCD4F4")
    static let buttonSecondaryPressed = Color(hex: "A8B7F0")

    // MARK: Fixed
    static let buttonFixedRest = Color(hex: "FFFFFF")

    // MARK: Disabled
    static let buttonDisabledBg = Color(hex: "D9DDE5")

    // MARK: Text / Icon — on Primary
    static let buttonTextOnPrimary = Color(hex: "FAFAFF")

    // MARK: Text / Icon — on Secondary
    static let buttonTextOnSecondary = Color(hex: "1F48DA")
    static let buttonTextOnSecondaryPressed = Color(hex: "0F2CBB")

    // MARK: Text / Icon — on Fixed
    static let buttonTextOnFixed = Color(hex: "1E2128")

    // MARK: Text / Icon — Ghost
    static let buttonTextGhost = Color(hex: "1F48DA")
    static let buttonTextGhostPressed = Color(hex: "0F2CBB")

    // MARK: Text / Icon — Disabled
    static let buttonTextDisabled = Color(hex: "A9B1C1")

    // MARK: - Counter

    static let counterBg = Color(hex: "DC0011")
    static let counterText = Color(hex: "FAFAFF")

    // MARK: - Pill Chip

    static let chipDefaultBg = Color(hex: "DFDFE8")
    static let chipActiveBg = Color(hex: "3363F7")
    static let chipPressedBg = Color(hex: "D9DDE5")
    static let chipDisabledBg = Color(hex: "D9DDE5")

    static let chipDefaultText = Color(hex: "1E2128")
    static let chipActiveText = Color(hex: "FAFAFF")
    static let chipPressedText = Color(hex: "434C5B")
    static let chipDisabledText = Color(hex: "A9B1C1")

    // MARK: - Outlined Chip

    static let chipOutlinedDefaultStroke = Color(hex: "C1C7D4")
    static let chipOutlinedActiveStroke = Color(hex: "3363F7")
    static let chipOutlinedActiveFill = Color(hex: "CCD4F4")
    static let chipOutlinedPressedFill = Color(hex: "D9DDE5")
    static let chipOutlinedPressedStroke = Color(hex: "FFFFFF")

    // MARK: - Checkbox — Unchecked

    static let checkboxDefaultFill = Color(hex: "FFFFFF")
    static let checkboxDefaultStroke = Color(hex: "C1C7D4")
    static let checkboxPressedFill = Color(hex: "EEEFF3")
    static let checkboxErrorStroke = Color(hex: "DC0011")
    static let checkboxDisabledFill = Color(hex: "D9DDE5")
    static let checkboxDisabledStroke = Color(hex: "D9DDE5")

    // MARK: - Checkbox — Checked

    static let checkboxCheckedDefault = Color(hex: "3363F7")
    static let checkboxCheckedPressed = Color(hex: "0F2CBB")
    static let checkboxCheckedError = Color(hex: "BE0000")
    static let checkboxCheckedDisabled = Color(hex: "D9DDE5")

    // MARK: - Checkbox — Focus Ring

    static let checkboxFocusRing = Color(hex: "3363F7")

    // MARK: - Checkbox — Text

    static let checkboxTextDefault = Color(hex: "1E2128")
    static let checkboxTextDisabled = Color(hex: "A9B1C1")
}
