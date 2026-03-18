import SwiftUI

struct CounterCatalogView: View {
    @State private var count = 1

    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                sectionView("Size M — Various Counts") {
                    HStack(spacing: 16) {
                        labeledCounter(1, size: .medium)
                        labeledCounter(5, size: .medium)
                        labeledCounter(9, size: .medium)
                        labeledCounter(15, size: .medium)
                        labeledCounter(99, size: .medium)
                    }
                }

                sectionView("Size S — Dot") {
                    HStack(spacing: 16) {
                        DSCounter(size: .small)
                        Text("← Notification dot")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }

                sectionView("Interactive") {
                    VStack(spacing: 16) {
                        HStack(spacing: 24) {
                            Button {
                                if count > 0 { count -= 1 }
                            } label: {
                                Image(systemName: "minus.circle.fill")
                                    .font(.title2)
                            }

                            DSCounter(count: count)

                            Button {
                                count += 1
                            } label: {
                                Image(systemName: "plus.circle.fill")
                                    .font(.title2)
                            }
                        }
                        Text("Count: \(count) → displays \"\(count > 9 ? "9+" : "\(count)")\"")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }

                sectionView("Usage Example — Tab Badge") {
                    HStack(spacing: 32) {
                        tabItem(icon: "house", label: "Home", count: 0)
                        tabItem(icon: "message", label: "Chat", count: 3)
                        tabItem(icon: "bell", label: "Alerts", count: 12)
                        tabItem(icon: "person", label: "Profile", count: 0, showDot: true)
                    }
                }
            }
            .padding()
        }
    }

    private func labeledCounter(_ value: Int, size: DSCounterSize) -> some View {
        VStack(spacing: 4) {
            DSCounter(count: value, size: size)
            Text("\(value)")
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
    }

    private func tabItem(icon: String, label: String, count: Int, showDot: Bool = false) -> some View {
        VStack(spacing: 4) {
            ZStack(alignment: .topTrailing) {
                Image(systemName: icon)
                    .font(.title2)
                    .frame(width: 32, height: 32)
                if count > 0 {
                    DSCounter(count: count)
                        .offset(x: 8, y: -4)
                } else if showDot {
                    DSCounter(size: .small)
                        .offset(x: 6, y: -2)
                }
            }
            Text(label)
                .font(.caption2)
        }
        .foregroundStyle(.primary)
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
        CounterCatalogView()
            .navigationTitle("DSCounter")
    }
}
