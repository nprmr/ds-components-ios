import SwiftUI

// MARK: - DSCounterSize

enum DSCounterSize {
    case medium // Numeric badge
    case small  // Dot indicator
}

// MARK: - DSCounter

struct DSCounter: View {
    let count: Int
    let size: DSCounterSize

    init(count: Int = 0, size: DSCounterSize = .medium) {
        self.count = count
        self.size = size
    }

    var body: some View {
        switch size {
        case .medium:
            mediumBadge
        case .small:
            smallDot
        }
    }

    // MARK: - Medium Badge

    private var mediumBadge: some View {
        Text(displayText)
            .font(.system(size: 11, weight: .semibold))
            .lineSpacing(2) // 13 - 11
            .tracking(0.06)
            .foregroundStyle(DSColorToken.icotexLightFixed)
            .padding(4)
            .frame(width: 20, height: 20)
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(DSColorToken.surfaceNegative)
            )
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }

    // MARK: - Small Dot

    private var smallDot: some View {
        Circle()
            .fill(DSColorToken.surfaceNegative)
            .frame(width: 8, height: 8)
            .frame(width: 20, height: 20)
    }

    private var displayText: String {
        count > 9 ? "9+" : "\(count)"
    }
}

// MARK: - Previews

#Preview("Medium — Various Counts") {
    HStack(spacing: 12) {
        DSCounter(count: 1)
        DSCounter(count: 5)
        DSCounter(count: 9)
        DSCounter(count: 15)
        DSCounter(count: 99)
    }
    .padding()
}

#Preview("Small — Dot") {
    HStack(spacing: 12) {
        DSCounter(size: .small)
        DSCounter(count: 3, size: .small)
    }
    .padding()
}

#Preview("Both Sizes — Side by Side") {
    VStack(spacing: 16) {
        HStack(spacing: 8) {
            Text("Medium:")
                .font(.caption)
            DSCounter(count: 3)
            DSCounter(count: 9)
            DSCounter(count: 12)
        }
        HStack(spacing: 8) {
            Text("Small:")
                .font(.caption)
            DSCounter(size: .small)
        }
    }
    .padding()
}
