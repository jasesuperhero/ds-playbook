//
//  DSScenario.swift
//  DSPlaybook
//
//  Created by Daniel Kalintsev on 07.10.22.
//

import Foundation
import Playbook
import Combine
import SwiftUI

struct DSScenario: ScenarioProvider {
    static func addScenarios(into playbook: Playbook) {
        playbook.addScenarios(of: "SupportingViews") {
            let title = StringSetting(name: "Title", value: "Bla bla")
            let subtitle = StringSetting(name: "Subtitle", value: "Bla bla")
            var settings: [any Setting] = [
                title,
                subtitle
            ]
            
            var viewModel = SettingViewModel(
                title: "Circle Image",
                settings: settings
            )

            Scenario("CircleImage", layout: .fill) {
                SettingScreen(
                    viewModel: viewModel
                ) {
                    CircleImage(
                        image: Image("turtlerock"),
                        title: title.value,
                        subtitle: subtitle.value,
                        number: 10
                    )
                }
            }
        }
    }
}

class SettingViewModel {
    var title: String
    var settings: [any Setting]
    
    var publisher: AnyPublisher<any Setting, Never> {
        Publishers.MergeMany(
            settings.map(\.published)
        )
    }
    
    init(
        title: String,
        settings: [any Setting]
    ) {
        self.title = title
        self.settings = settings
    }
}

protocol Setting: ObservableObject {
    associatedtype Value
    var name: String { get }
    var value: Published<Value> { get set }
    
    func makeView() -> AnyView
}

final class StringSetting: Setting {
    let name: String
    var value: Published<String>
    
    init(name: String, value: String) {
        self.name = name
        self.value = Published(wrappedValue: value)
    }
    
    func makeView() -> AnyView {
        return AnyView(HStack {
            Text("Title")
                .fixedSize()
            Spacer()
            TextField(
                "New title",
                text: Binding(get: {
                    return self.$value
                }, set: { newValue, _ in
                    self.value = newValue
                    self.objectWillChange.send()
                }
            )
            )
            .disableAutocorrection(true)
            .fixedSize()
        })
    }
}

struct SettingScreen<Content: View>: View {
    @State private var isPresented = false
    @ObservedObject
    var viewModel: SettingViewModel
    @ViewBuilder var content: () -> Content

//    init(
//        settings: Binding<[any Setting]>,
//        _ content: @escaping () -> Content
//    ) {
//        self.settings = settings.wrappedValue
//        self.content = content
//    }

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
                    ForEach(viewModel.settings, id: \.name) { setting in
                        setting.makeView()
                    }
                }
            }
            .presentationDetents([.medium, .large, .height(70)])
            .presentationDragIndicator(.visible)
            .interactiveDismissDisabled(true)
        }
        .onReceive(viewModel.settings.publisher) { _ in
            print("published")
        }
    }
}
