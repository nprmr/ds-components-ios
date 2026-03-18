import SwiftUI

struct ButtonCatalogView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                sectionView("Primary") {
                    DSButton("Large", size: .large, mode: .primary) {}
                    DSButton("Medium", size: .medium, mode: .primary) {}
                    DSButton("Small", size: .small, mode: .primary) {}
                    DSButton("Disabled", size: .large, mode: .primary, isDisabled: true) {}
                }

                sectionView("Secondary") {
                    DSButton("Large", size: .large, mode: .secondary) {}
                    DSButton("Medium", size: .medium, mode: .secondary) {}
                    DSButton("Small", size: .small, mode: .secondary) {}
                    DSButton("Disabled", size: .large, mode: .secondary, isDisabled: true) {}
                }

                sectionView("Ghost") {
                    DSButton("Large", size: .large, mode: .ghost) {}
                    DSButton("Medium", size: .medium, mode: .ghost) {}
                    DSButton("Small", size: .small, mode: .ghost) {}
                    DSButton("Disabled", size: .large, mode: .ghost, isDisabled: true) {}
                }

                sectionView("Fixed (on dark)") {
                    ZStack {
                        Color(hex: "1E2128")
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                        VStack(spacing: 12) {
                            DSButton("Large", size: .large, mode: .fixed) {}
                            DSButton("Medium", size: .medium, mode: .fixed) {}
                            DSButton("Disabled", size: .large, mode: .fixed, isDisabled: true) {}
                        }
                        .padding(16)
                    }
                }

                sectionView("With Icons") {
                    DSButton(
                        "Both Icons",
                        size: .large,
                        mode: .primary,
                        leadingIcon: Image(systemName: "arrow.left"),
                        trailingIcon: Image(systemName: "arrow.right")
                    ) {}
                    DSButton(
                        "Leading",
                        size: .medium,
                        mode: .secondary,
                        leadingIcon: Image(systemName: "plus")
                    ) {}
                    DSButton(
                        "",
                        size: .small,
                        mode: .primary,
                        leadingIcon: Image(systemName: "heart.fill"),
                        showLabel: false
                    ) {}
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
        ButtonCatalogView()
            .navigationTitle("DSButton")
    }
}
