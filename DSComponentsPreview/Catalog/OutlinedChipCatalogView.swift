import SwiftUI

struct OutlinedChipCatalogView: View {
    @State private var selectedCity = "Москва"

    private let cities = ["Москва", "Питер", "Казань", "Сочи"]

    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                sectionView("All States") {
                    VStack(spacing: 12) {
                        DSOutlinedChip("Default", state: .default) {}
                        DSOutlinedChip("Active", state: .active) {}
                        DSOutlinedChip("Pressed", state: .pressed) {}
                        DSOutlinedChip("Disabled", state: .disabled) {}
                    }
                }

                sectionView("With Icons") {
                    VStack(spacing: 12) {
                        DSOutlinedChip(
                            "Leading Icon",
                            state: .default,
                            leadingIcon: Image(systemName: "tag")
                        ) {}
                        DSOutlinedChip(
                            "Trailing Icon",
                            state: .active,
                            trailingIcon: Image(systemName: "xmark")
                        ) {}
                        DSOutlinedChip(
                            "Both Icons",
                            state: .default,
                            leadingIcon: Image(systemName: "mappin"),
                            trailingIcon: Image(systemName: "chevron.down")
                        ) {}
                    }
                }

                sectionView("Interactive Selection") {
                    HStack(spacing: 8) {
                        ForEach(cities, id: \.self) { city in
                            DSOutlinedChip(
                                city,
                                state: selectedCity == city ? .active : .default,
                                leadingIcon: Image(systemName: "mappin")
                            ) {
                                selectedCity = city
                            }
                        }
                    }
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
        OutlinedChipCatalogView()
            .navigationTitle("DSOutlinedChip")
    }
}
