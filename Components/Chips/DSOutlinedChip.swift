import SwiftUI

// MARK: - DSOutlinedChip

struct DSOutlinedChip: View {
    let title: String
    let state: DSChipState
    let leadingIcon: Image?
    let trailingIcon: Image?
    let action: () -> Void

    init(
        _ title: String,
        state: DSChipState = .default,
        leadingIcon: Image? = nil,
        trailingIcon: Image? = nil,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.state = state
        self.leadingIcon = leadingIcon
        self.trailingIcon = trailingIcon
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            content
        }
        .buttonStyle(OutlinedChipButtonStyle(
            state: state,
            hasLeading: leadingIcon != nil,
            hasTrailing: trailingIcon != nil
        ))
        .disabled(state == .disabled)
    }

    @ViewBuilder
    private var content: some View {
        HStack(spacing: 8) {
            if let leadingIcon {
                leadingIcon
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 24, height: 24)
            }
            Text(title)
                .font(.system(size: 13, weight: .semibold))
            if let trailingIcon {
                trailingIcon
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 24, height: 24)
            }
        }
    }
}

// MARK: - OutlinedChipButtonStyle

private struct OutlinedChipButtonStyle: ButtonStyle {
    let state: DSChipState
    let hasLeading: Bool
    let hasTrailing: Bool

    func makeBody(configuration: Configuration) -> some View {
        let isPressed = configuration.isPressed

        configuration.label
            .foregroundStyle(textColor(isPressed: isPressed))
            .padding(.leading, hasLeading ? 12 : 16)
            .padding(.trailing, hasTrailing ? 12 : 16)
            .padding(.vertical, 8)
            .frame(height: 40)
            .background(backgroundView(isPressed: isPressed))
            .contentShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }

    @ViewBuilder
    private func backgroundView(isPressed: Bool) -> some View {
        let fill = fillColor(isPressed: isPressed)
        let stroke = strokeColor(isPressed: isPressed)

        RoundedRectangle(cornerRadius: 12, style: .continuous)
            .fill(fill)
            .overlay(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .stroke(stroke, lineWidth: 2)
            )
    }

    private func fillColor(isPressed: Bool) -> Color {
        if isPressed && state != .disabled { return DSColorToken.interactActionPressed }
        switch state {
        case .default: return .clear
        case .active: return DSColorToken.surfaceAccentPale
        case .pressed: return DSColorToken.interactActionPressed
        case .disabled: return .clear
        }
    }

    private func strokeColor(isPressed: Bool) -> Color {
        if isPressed && state != .disabled { return DSColorToken.outlineLightFixed }
        switch state {
        case .default: return DSColorToken.outlineBorder
        case .active: return DSColorToken.outlineAccent
        case .pressed: return DSColorToken.outlineLightFixed
        case .disabled: return DSColorToken.outlineBorder
        }
    }

    // ⚠️ Text colors assumed by analogy with pill chip — needs designer confirmation
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

#Preview("Outlined — All States") {
    VStack(spacing: 12) {
        DSOutlinedChip("Default", state: .default) {}
        DSOutlinedChip("Active", state: .active) {}
        DSOutlinedChip("Pressed", state: .pressed) {}
        DSOutlinedChip("Disabled", state: .disabled) {}
    }
    .padding()
}

#Preview("Outlined — With Icons") {
    VStack(spacing: 12) {
        DSOutlinedChip("Leading", state: .default,
                       leadingIcon: Image(systemName: "tag")) {}
        DSOutlinedChip("Trailing", state: .active,
                       trailingIcon: Image(systemName: "xmark")) {}
        DSOutlinedChip("Both Icons", state: .default,
                       leadingIcon: Image(systemName: "mappin"),
                       trailingIcon: Image(systemName: "chevron.down")) {}
    }
    .padding()
}

#Preview("Outlined — Selection Row") {
    HStack(spacing: 8) {
        DSOutlinedChip("Москва", state: .active,
                       leadingIcon: Image(systemName: "mappin")) {}
        DSOutlinedChip("Питер", state: .default,
                       leadingIcon: Image(systemName: "mappin")) {}
        DSOutlinedChip("Казань", state: .default) {}
    }
    .padding()
}
