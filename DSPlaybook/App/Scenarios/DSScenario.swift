//
//  DSScenario.swift
//  DSPlaybook
//
//  Created by Daniel Kalintsev on 07.10.22.
//

import Foundation
import Playbook
import SwiftUI
import BottomSheet

struct DSScenario: ScenarioProvider {
    static func addScenarios(into playbook: Playbook) {
        playbook.addScenarios(of: "SupportingViews") {
            let viewModel = SettingViewModel(title: "The title", subtitle: "The subtitle")

            Scenario("CircleImage", layout: .fill) {
                SettingScreen(viewModel: viewModel) {
                    CircleImage(
                        image: Image("turtlerock"),
                        title: viewModel.title,
                        subtitle: viewModel.subtitle,
                        number: 10
                    )
                }
            }
        }
    }
}

class SettingViewModel: ObservableObject {
    @Published var title: String
    @Published var subtitle: String

    init(title: String, subtitle: String) {
        self.title = title
        self.subtitle = subtitle
    }
}

func main() {
    let settings: [Setting] = [
        Setting(name: "title", value: Binding(.constant("123"))),
        Setting(name: "number", value: Binding(.constant(123)))
    ]

    settings.map { $0.makeView() }
}

protocol SettingDisplayable {
    func makeView<T>() -> AnyView
}

struct Setting<T: Equatable> {
    var name: String
    var value: Binding<T>
}

extension Setting: View where T == String {
    var body: some View {
        HStack {
            Text("Title")
                .fixedSize()
            Spacer()
            TextField(
                "New title",
                text: value
            )
            .disableAutocorrection(true)
            .fixedSize()
        }
    }
}

struct SettingScreen<Content: View>: View {
    @State private var isPresented = false
    @ObservedObject var viewModel: SettingViewModel
    @ViewBuilder var content: () -> Content

    init(
        viewModel: SettingViewModel,
        _ content: @escaping () -> Content
    ) {
        self.viewModel = viewModel
        self.content = content
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Button("Show settings") {
                    isPresented.toggle()
                }

                Spacer(minLength: 20)
                content()
            }
        }
        .sheet(isPresented: $isPresented) {
            VStack(spacing: 10) {
                Spacer(minLength: 20)
                Button("Close") {
                    isPresented.toggle()
                }
                Form {
                    HStack {
                        Text("Title")
                            .fixedSize()
                        Spacer()
                        TextField(
                            "New title",
                            text: $viewModel.title
                        )
                        .disableAutocorrection(true)
                        .fixedSize()
                    }

                    HStack {
                        Text("Subtitle")
                            .fixedSize()
                        Spacer()
                        TextField(
                            "New subtitle",
                            text: $viewModel.subtitle
                        )
                        .disableAutocorrection(true)
                        .fixedSize()
                    }
                }
            }
            .presentationDetents([.medium, .large, .height(70)])
            .presentationDragIndicator(.visible)
            .interactiveDismissDisabled(true)
        }
    }
}
