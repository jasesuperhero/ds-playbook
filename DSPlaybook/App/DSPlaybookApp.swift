//
//  DSPlaybookApp.swift
//  DSPlaybook
//
//  Created by Daniel Kalintsev on 07.10.22.
//

import SwiftUI
import PlaybookUI
import Playbook

@main
struct DSPlaybookApp: App {
    let playbook = Playbook()

    init() {
        playbook.add(DSScenario.self)
    }

    var body: some Scene {
        WindowGroup {
            PlaybookView(playbook: playbook)
        }
    }
}
