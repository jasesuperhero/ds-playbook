//
//  View+BottomSheet.swift
//  DSPlaybook
//
//  Created by Daniel Kalintsev on 07.10.22.
//

import SwiftUI

extension View {
    @ViewBuilder
    func bottomSheet<Content: View>(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> some View
    ) -> some View {
        self

    }
}
