//
//  PlaybookView.swift
//  DSPlaybook
//
//  Created by Daniel Kalintsev on 07.10.22.
//

import SwiftUI
import PlaybookUI
import Playbook

struct PlaybookView: View {
    enum Tab {
        case catalog
        case gallery
    }

    @State
    var tab = Tab.gallery

    var playbook: Playbook

    var body: some View {
        TabView(selection: $tab) {
            PlaybookGallery(playbook: playbook)
                .tag(Tab.gallery)
                .tabItem {
                    Image(systemName: "rectangle.grid.3x2")
                    Text("Gallery")
                }

            PlaybookCatalog(playbook: playbook)
                .tag(Tab.catalog)
                .tabItem {
                    Image(systemName: "doc.text.magnifyingglass")
                    Text("Catalog")
                }
        }
    }
}
