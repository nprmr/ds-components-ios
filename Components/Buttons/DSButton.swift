import SwiftUI

// MARK: - Enums

enum DSButtonSize {
    case large, medium, small
}

enum DSButtonMode {
    case primary, secondary, ghost, fixed
}

// MARK: - DSButton

struct DSButton: View {
    let title: String
    let size: DSButtonSize
    let mode: DSButtonMode
    let leadingIcon: Image?
    let trailingIcon: Image?
    let showLabel: Bool
    let isDisabled: Bool
    let action: () -> Void

    init(
        _ title: String,
        size: DSButtonSize = .large,
        mode: DSButtonMode = .primary,
        leadingIcon: Image? = nil,
        trailingIcon: Image? = nil,
        showLabel: Bool = true,
        isDisabled: Bool = false,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.size = size
        self.mode = mode
        self.leadingIcon = leadingIcon
        self.trailingIcon = trailingIcon
        self.showLabel = showLabel
        self.isDisabled = isDisabled
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            content
        }
        .buttonStyle(
            DSButtonStyle(
                size: size,
                mode: mode,
                isDisabled: isDisabled
            )
        )
        .disabled(isDisabled)
    }

    @ViewBuilder
    private var content: some View {
        HStack(spacing: itemSpacing) {
            if let leadingIcon {
                leadingIcon
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 24, height: 24)
            }
            if showLabel {
                Text(title)
                    .font(titleFont)
                    .lineSpacing(lineSpacingValue)
                    .tracking(letterSpacing)
            }
            if let trailingIcon {
                trailingIcon
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 24, height: 24)
            }
        }
    }

    // MARK: - Layout Helpers

    private var itemSpacing: CGFloat {
        switch size {
        case .large: 8
        case .medium, .small: 4
        }
    }

    private var titleFont: Font {
        switch size {
        case .large: .buttonLarge
        case .medium, .small: .buttonMediumSmall
        }
    }

    private var lineSpacingValue: CGFloat {
        switch size {
        case .large: 8        // 24 - 16
        case .medium, .small: 10  // 24 - 14
        }
    }

    private var letterSpacing: CGFloat {
        switch size {
        case .large: -0.16
        case .medium, .small: 0
        }
    }
}

// MARK: - DSButtonStyle

private struct DSButtonStyle: ButtonStyle {
    let size: DSButtonSize
    let mode: DSButtonMode
    let isDisabled: Bool

    func makeBody(configuration: Configuration) -> some View {
        let isPressed = configuration.isPressed

        configuration.label
            .foregroundStyle(foregroundColor(isPressed: isPressed))
            .padding(.horizontal, paddingH)
            .padding(.vertical, paddingV)
            .frame(height: height)
            .frame(maxWidth: isFullWidth ? .infinity : nil)
            .background(backgroundView(isPressed: isPressed))
            .contentShape(Rectangle())
    }

    // MARK: - Height

    private var height: CGFloat {
        switch size {
        case .large: 56
        case .medium: 44
        case .small: 32
        }
    }

    // MARK: - Full Width

    private var isFullWidth: Bool {
        mode != .ghost
    }

    // MARK: - Padding

    private var paddingH: CGFloat {
        switch mode {
        case .ghost:
            return 0
        case .primary, .secondary, .fixed:
            switch size {
            case .large: return 16
            case .medium, .small: return 12
            }
        }
    }

    private var paddingV: CGFloat {
        switch mode {
        case .ghost:
            switch size {
            case .large: return 16
            case .medium, .small: return 0
            }
        case .primary, .secondary, .fixed:
            // Vertical centering handled by .frame(height:)
            return 0
        }
    }

    // MARK: - Background

    @ViewBuilder
    private func backgroundView(isPressed: Bool) -> some View {
        switch mode {
        case .ghost:
            // Ghost small has cornerRadius 4
            if size == .small {
                Color.clear
                    .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
            } else {
                Color.clear
            }
        default:
            if isDisabled {
                Capsule().fill(Color.buttonDisabledBg)
            } else if isPressed {
                backgroundForPressed
            } else {
                backgroundForRest
            }
        }
    }

    @ViewBuilder
    private var backgroundForRest: some View {
        switch mode {
        case .primary:
            Capsule().fill(Color.buttonPrimaryRest)
        case .secondary:
            Capsule().fill(Color.buttonSecondaryRest)
        case .fixed:
            Capsule().fill(Color.buttonFixedRest)
        case .ghost:
            EmptyView()
        }
    }

    @ViewBuilder
    private var backgroundForPressed: some View {
        switch mode {
        case .primary:
            Capsule().fill(Color.buttonPrimaryPressed)
        case .secondary:
            Capsule().fill(Color.buttonSecondaryPressed)
        case .fixed:
            Capsule().fill(Color.buttonFixedRest.opacity(0.9))
        case .ghost:
            EmptyView()
        }
    }

    // MARK: - Foreground

    private func foregroundColor(isPressed: Bool) -> Color {
        if isDisabled {
            return .buttonTextDisabled
        }

        switch mode {
        case .primary:
            return .buttonTextOnPrimary
        case .secondary:
            return isPressed ? .buttonTextOnSecondaryPressed : .buttonTextOnSecondary
        case .ghost:
            return isPressed ? .buttonTextGhostPressed : .buttonTextGhost
        case .fixed:
            return .buttonTextOnFixed
        }
    }
}

// MARK: - Previews

#Preview("Primary — All Sizes") {
    VStack(spacing: 16) {
        DSButton("Large Primary", size: .large, mode: .primary) {}
        DSButton("Medium Primary", size: .medium, mode: .primary) {}
        DSButton("Small Primary", size: .small, mode: .primary) {}
    }
    .padding()
}

#Preview("Primary — Disabled") {
    VStack(spacing: 16) {
        DSButton("Large Disabled", size: .large, mode: .primary, isDisabled: true) {}
        DSButton("Medium Disabled", size: .medium, mode: .primary, isDisabled: true) {}
        DSButton("Small Disabled", size: .small, mode: .primary, isDisabled: true) {}
    }
    .padding()
}

#Preview("Secondary — All Sizes") {
    VStack(spacing: 16) {
        DSButton("Large Secondary", size: .large, mode: .secondary) {}
        DSButton("Medium Secondary", size: .medium, mode: .secondary) {}
        DSButton("Small Secondary", size: .small, mode: .secondary) {}
    }
    .padding()
}

#Preview("Ghost — All Sizes") {
    VStack(spacing: 16) {
        DSButton("Large Ghost", size: .large, mode: .ghost) {}
        DSButton("Medium Ghost", size: .medium, mode: .ghost) {}
        DSButton("Small Ghost", size: .small, mode: .ghost) {}
    }
    .padding()
}

#Preview("Fixed — on dark background") {
    ZStack {
        Color(hex: "1E2128").ignoresSafeArea()
        VStack(spacing: 16) {
            DSButton("Large Fixed", size: .large, mode: .fixed) {}
            DSButton("Medium Fixed", size: .medium, mode: .fixed) {}
            DSButton("Small Fixed", size: .small, mode: .fixed) {}
        }
        .padding()
    }
}

#Preview("With Icons") {
    VStack(spacing: 16) {
        DSButton(
            "With Both Icons",
            size: .large,
            mode: .primary,
            leadingIcon: Image(systemName: "arrow.left"),
            trailingIcon: Image(systemName: "arrow.right")
        ) {}

        DSButton(
            "Leading Only",
            size: .medium,
            mode: .secondary,
            leadingIcon: Image(systemName: "plus")
        ) {}

        DSButton(
            "Trailing Only",
            size: .small,
            mode: .primary,
            trailingIcon: Image(systemName: "chevron.right")
        ) {}
    }
    .padding()
}

#Preview("Icon Only — No Label") {
    HStack(spacing: 16) {
        DSButton(
            "",
            size: .large,
            mode: .primary,
            leadingIcon: Image(systemName: "plus"),
            showLabel: false
        ) {}

        DSButton(
            "",
            size: .medium,
            mode: .secondary,
            leadingIcon: Image(systemName: "heart.fill"),
            showLabel: false
        ) {}

        DSButton(
            "",
            size: .small,
            mode: .ghost,
            leadingIcon: Image(systemName: "xmark"),
            showLabel: false
        ) {}
    }
    .padding()
}

#Preview("All Modes — Disabled") {
    VStack(spacing: 12) {
        DSButton("Primary Disabled", size: .large, mode: .primary, isDisabled: true) {}
        DSButton("Secondary Disabled", size: .large, mode: .secondary, isDisabled: true) {}
        DSButton("Ghost Disabled", size: .large, mode: .ghost, isDisabled: true) {}
        ZStack {
            Color(hex: "1E2128")
                .clipShape(RoundedRectangle(cornerRadius: 16))
            DSButton("Fixed Disabled", size: .large, mode: .fixed, isDisabled: true) {}
                .padding(.horizontal, 16)
        }
        .frame(height: 80)
    }
    .padding()
}

#Preview("All Modes — Large") {
    VStack(spacing: 12) {
        DSButton("Primary", size: .large, mode: .primary) {}
        DSButton("Secondary", size: .large, mode: .secondary) {}
        DSButton("Ghost", size: .large, mode: .ghost) {}
        ZStack {
            Color(hex: "1E2128")
                .clipShape(RoundedRectangle(cornerRadius: 16))
            DSButton("Fixed", size: .large, mode: .fixed) {}
                .padding(.horizontal, 16)
        }
        .frame(height: 80)
    }
    .padding()
}
