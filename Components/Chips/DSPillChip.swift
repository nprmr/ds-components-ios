import SwiftUI

// MARK: - DSChipState

enum DSChipState {
    case `default`, active, disabled
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
        configuration.label
            .foregroundStyle(textColor)
            .background(Capsule().fill(fillColor))
            .contentShape(Capsule())
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }

    private var fillColor: Color {
        switch state {
        case .default: DSColorToken.surfaceTertiary
        case .active: DSColorToken.surfaceAccent
        case .disabled: DSColorToken.interactActionDisabled
        }
    }

    private var textColor: Color {
        switch state {
        case .default: DSColorToken.icotexPrimary
        case .active: DSColorToken.icotexPrimaryInverted
        case .disabled: DSColorToken.interactIcotexDisable
        }
    }
}

// MARK: - Previews

#Preview("Pill Chip — All States") {
    VStack(spacing: 16) {
        HStack(spacing: 8) {
            DSPillChip("Default", state: .default) {}
            DSPillChip("Active", state: .active) {}
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
