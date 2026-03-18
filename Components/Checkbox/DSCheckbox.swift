import SwiftUI

// MARK: - DSCheckboxState

enum DSCheckboxState {
    case `default`
    case pressed
    case focused
    case disabled
    case error
}

// MARK: - DSCheckbox

struct DSCheckbox: View {
    @Binding var isChecked: Bool
    let label: String?
    let state: DSCheckboxState

    init(
        isChecked: Binding<Bool>,
        label: String? = nil,
        state: DSCheckboxState = .default
    ) {
        self._isChecked = isChecked
        self.label = label
        self.state = state
    }

    var body: some View {
        HStack(spacing: 8) {
            checkboxControl
                .frame(width: 24, height: 24)

            if let label {
                Text(label)
                    .font(.system(size: 12, weight: .regular))
                    .lineSpacing(4) // lineHeight 16 - fontSize 12
                    .foregroundStyle(labelColor)
            }
        }
        .onTapGesture {
            guard state != .disabled else { return }
            withAnimation(.easeInOut(duration: 0.15)) {
                isChecked.toggle()
            }
        }
    }

    // MARK: - Checkbox Control

    @ViewBuilder
    private var checkboxControl: some View {
        ZStack {
            if isChecked {
                checkedView
            } else {
                uncheckedView
            }
        }
        .frame(width: 24, height: 24)
        .overlay(focusRingOverlay)
    }

    // MARK: - Unchecked

    private var uncheckedView: some View {
        RoundedRectangle(cornerRadius: 6, style: .continuous)
            .fill(uncheckedFill)
            .overlay(
                RoundedRectangle(cornerRadius: 6, style: .continuous)
                    .stroke(uncheckedStroke, lineWidth: uncheckedStrokeWeight)
            )
            .frame(width: 20, height: 20)
    }

    // MARK: - Checked

    private var checkedView: some View {
        RoundedRectangle(cornerRadius: 6, style: .continuous)
            .fill(checkedFill)
            .overlay(
                Image(systemName: "checkmark")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundStyle(.white)
            )
            .frame(width: 20, height: 20)
    }

    // MARK: - Focus Ring

    @ViewBuilder
    private var focusRingOverlay: some View {
        if state == .focused {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .stroke(DSColorToken.outlineAccent, lineWidth: 2)
                .padding(-2)
        }
    }

    // MARK: - Unchecked Colors

    private var uncheckedFill: Color {
        switch state {
        case .default, .focused, .error:
            return DSColorToken.surfacePrimary
        case .pressed:
            return DSColorToken.surfaceSecondary
        case .disabled:
            return DSColorToken.interactActionDisabled
        }
    }

    private var uncheckedStroke: Color {
        switch state {
        case .default, .pressed, .focused:
            return DSColorToken.outlineBorder
        case .disabled:
            return DSColorToken.interactActionDisabled
        case .error:
            return DSColorToken.outlineNegative
        }
    }

    private var uncheckedStrokeWeight: CGFloat {
        state == .disabled ? 1 : 2
    }

    // MARK: - Checked Colors

    private var checkedFill: Color {
        switch state {
        case .default, .focused:
            return DSColorToken.surfaceAccent
        case .pressed:
            return DSColorToken.interactAccentAction
        case .disabled:
            return DSColorToken.interactActionDisabled
        case .error:
            return DSColorToken.icotexNegative
        }
    }

    // MARK: - Label Color

    private var labelColor: Color {
        state == .disabled ? DSColorToken.interactIcotexDisable : DSColorToken.icotexPrimary
    }
}

// MARK: - Previews

#Preview("Unchecked — All States") {
    VStack(alignment: .leading, spacing: 16) {
        DSCheckbox(isChecked: .constant(false), label: "Default", state: .default)
        DSCheckbox(isChecked: .constant(false), label: "Pressed", state: .pressed)
        DSCheckbox(isChecked: .constant(false), label: "Focused", state: .focused)
        DSCheckbox(isChecked: .constant(false), label: "Disabled", state: .disabled)
        DSCheckbox(isChecked: .constant(false), label: "Error", state: .error)
    }
    .padding()
}

#Preview("Checked — All States") {
    VStack(alignment: .leading, spacing: 16) {
        DSCheckbox(isChecked: .constant(true), label: "Default", state: .default)
        DSCheckbox(isChecked: .constant(true), label: "Pressed", state: .pressed)
        DSCheckbox(isChecked: .constant(true), label: "Focused", state: .focused)
        DSCheckbox(isChecked: .constant(true), label: "Disabled", state: .disabled)
        DSCheckbox(isChecked: .constant(true), label: "Error", state: .error)
    }
    .padding()
}

#Preview("No Label") {
    HStack(spacing: 16) {
        DSCheckbox(isChecked: .constant(false))
        DSCheckbox(isChecked: .constant(true))
        DSCheckbox(isChecked: .constant(false), state: .disabled)
        DSCheckbox(isChecked: .constant(true), state: .disabled)
    }
    .padding()
}

#Preview("Interactive Toggle") {
    struct ToggleDemo: View {
        @State private var option1 = false
        @State private var option2 = true
        @State private var option3 = false

        var body: some View {
            VStack(alignment: .leading, spacing: 16) {
                DSCheckbox(isChecked: $option1, label: "Accept terms")
                DSCheckbox(isChecked: $option2, label: "Subscribe to newsletter")
                DSCheckbox(isChecked: $option3, label: "Disabled option", state: .disabled)
            }
            .padding()
        }
    }
    return ToggleDemo()
}
