import SwiftUI

struct ComponentCatalogView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Button") {
                    ButtonCatalogView()
                        .navigationTitle("DSButton")
                }
                NavigationLink("Checkbox") {
                    CheckboxCatalogView()
                        .navigationTitle("DSCheckbox")
                }
                NavigationLink("Pill Chip") {
                    PillChipCatalogView()
                        .navigationTitle("DSPillChip")
                }
                NavigationLink("Outlined Chip") {
                    OutlinedChipCatalogView()
                        .navigationTitle("DSOutlinedChip")
                }
                NavigationLink("Counter") {
                    CounterCatalogView()
                        .navigationTitle("DSCounter")
                }
            }
            .navigationTitle("Design System")
        }
    }
}

#Preview {
    ComponentCatalogView()
}
