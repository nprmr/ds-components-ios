import SwiftUI

struct CheckboxCatalogView: View {
    @State private var check1 = false
    @State private var check2 = true
    @State private var check3 = false
    @State private var check4 = true

    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                sectionView("Interactive") {
                    DSCheckbox(isChecked: $check1, label: "Tap to toggle")
                    DSCheckbox(isChecked: $check2, label: "Already checked")
                    DSCheckbox(isChecked: $check3, label: "Disabled", state: .disabled)
                    DSCheckbox(isChecked: $check4, label: "Error state", state: .error)
                }

                sectionView("Unchecked — All States") {
                    DSCheckbox(isChecked: .constant(false), label: "Default", state: .default)
                    DSCheckbox(isChecked: .constant(false), label: "Disabled", state: .disabled)
                    DSCheckbox(isChecked: .constant(false), label: "Error", state: .error)
                }

                sectionView("Checked — All States") {
                    DSCheckbox(isChecked: .constant(true), label: "Default", state: .default)
                    DSCheckbox(isChecked: .constant(true), label: "Disabled", state: .disabled)
                    DSCheckbox(isChecked: .constant(true), label: "Error", state: .error)
                }

                sectionView("No Label") {
                    HStack(spacing: 16) {
                        DSCheckbox(isChecked: .constant(false))
                        DSCheckbox(isChecked: .constant(true))
                        DSCheckbox(isChecked: .constant(false), state: .disabled)
                        DSCheckbox(isChecked: .constant(true), state: .error)
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
        CheckboxCatalogView()
            .navigationTitle("DSCheckbox")
    }
}
