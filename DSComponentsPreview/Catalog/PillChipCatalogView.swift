import SwiftUI

struct PillChipCatalogView: View {
    @State private var selectedIndex = 0

    private let amounts = ["100 $", "500 $", "1 000 $", "5 000 $"]

    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                sectionView("All States") {
                    HStack(spacing: 8) {
                        DSPillChip("Default", state: .default) {}
                        DSPillChip("Active", state: .active) {}
                        DSPillChip("Disabled", state: .disabled) {}
                    }
                }

                sectionView("Interactive Selection") {
                    HStack(spacing: 8) {
                        ForEach(amounts.indices, id: \.self) { index in
                            DSPillChip(
                                amounts[index],
                                state: selectedIndex == index ? .active : .default
                            ) {
                                selectedIndex = index
                            }
                        }
                    }
                }

                sectionView("Press Effect") {
                    Text("Tap chips to see scale animation")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            .padding()
        }
    }

    private func sectionView<Content: View>(
        _ title: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)
                .foregroundStyle(.secondary)
            content()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    NavigationStack {
        PillChipCatalogView()
            .navigationTitle("DSPillChip")
    }
}
