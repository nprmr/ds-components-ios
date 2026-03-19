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
        configuration.label
            .foregroundStyle(textColor)
            .padding(.leading, hasLeading ? 12 : 16)
            .padding(.trailing, hasTrailing ? 12 : 16)
            .padding(.vertical, 8)
            .frame(height: 40)
            .background(backgroundView)
            .contentShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }

    @ViewBuilder
    private var backgroundView: some View {
        RoundedRectangle(cornerRadius: 12, style: .continuous)
            .fill(fillColor)
            .overlay(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .stroke(strokeColor, lineWidth: 2)
            )
    }

    private var fillColor: Color {
        switch state {
        case .default: .clear
        case .active: DSColorToken.surfaceAccentPale
        case .disabled: .clear
        }
    }

    private var strokeColor: Color {
        switch state {
        case .default: DSColorToken.outlineBorder
        case .active: DSColorToken.outlineAccent
        case .disabled: DSColorToken.outlineBorder
        }
    }

    private var textColor: Color {
        switch state {
        case .default: DSColorToken.icotexPrimary
        case .active: DSColorToken.icotexAccent
        case .disabled: DSColorToken.interactIcotexDisable
        }
    }
}

// MARK: - Previews

#Preview("Outlined — All States") {
    VStack(spacing: 12) {
        DSOutlinedChip("Default", state: .default) {}
        DSOutlinedChip("Active", state: .active) {}
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
