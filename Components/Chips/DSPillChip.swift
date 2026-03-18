import SwiftUI

// MARK: - DSChipState

enum DSChipState {
    case `default`, active, pressed, disabled
}

// MARK: - DSPillChip

struct DSPillChip: View {
    let title: String
    let state: DSChipState
    let action: () -> Void

    init(
        _ title: String,
        state: DSChipState = .default,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.state = state
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 13, weight: .semibold))
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .frame(height: 34)
        }
        .buttonStyle(PillChipButtonStyle(state: state))
        .disabled(state == .disabled)
    }
}

// MARK: - PillChipButtonStyle

private struct PillChipButtonStyle: ButtonStyle {
    let state: DSChipState

    func makeBody(configuration: Configuration) -> some View {
        let isPressed = configuration.isPressed

        configuration.label
            .foregroundStyle(textColor(isPressed: isPressed))
            .background(backgroundColor(isPressed: isPressed))
            .contentShape(Capsule())
    }

    private func backgroundColor(isPressed: Bool) -> some View {
        Capsule().fill(fillColor(isPressed: isPressed))
    }

    private func fillColor(isPressed: Bool) -> Color {
        if state == .disabled { return DSColorToken.interactActionDisabled }
        if isPressed { return DSColorToken.interactActionPressed }
        switch state {
        case .default: return DSColorToken.surfaceTertiary
        case .active: return DSColorToken.surfaceAccent
        case .pressed: return DSColorToken.interactActionPressed
        case .disabled: return DSColorToken.interactActionDisabled
        }
    }

    private func textColor(isPressed: Bool) -> Color {
        if state == .disabled { return DSColorToken.interactIcotexDisable }
        if isPressed { return DSColorToken.icotexSecondary }
        switch state {
        case .default: return DSColorToken.icotexPrimary
        case .active: return DSColorToken.icotexPrimaryInverted
        case .pressed: return DSColorToken.icotexSecondary
        case .disabled: return DSColorToken.interactIcotexDisable
        }
    }
}

// MARK: - Previews

#Preview("Pill Chip — All States") {
    VStack(spacing: 16) {
        HStack(spacing: 8) {
            DSPillChip("Default", state: .default) {}
            DSPillChip("Active", state: .active) {}
            DSPillChip("Pressed", state: .pressed) {}
            DSPillChip("Disabled", state: .disabled) {}
        }
    }
    .padding()
}

#Preview("Pill Chip — Selection Group") {
    HStack(spacing: 8) {
        DSPillChip("100 $", state: .active) {}
        DSPillChip("500 $", state: .default) {}
        DSPillChip("1 000 $", state: .default) {}
        DSPillChip("5 000 $", state: .default) {}
    }
    .padding()
}
