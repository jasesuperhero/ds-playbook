//
//  CirecleImage.swift
//  DSPlaybook
//
//  Created by Daniel Kalintsev on 07.10.22.
//

import SwiftUI

struct CircleImage: View {
    // sourcery:playbook enabled
    var image: Image
    var title: String

    // sourcery:playbook enabled
    var subtitle: String

    var number: Int

    var body: some View {
        HStack(spacing: 20) {
//            image
//                .frame(width: 40, height: 40)
//                .clipShape(Circle())
//                .shadow(radius: 10)
            VStack(alignment: .leading) {
                Text(title).bold()
                Text(subtitle)
                Text("\(number)")
            }
            .frame(alignment: .leading)
            Spacer()
        }
        .padding(.horizontal, 20)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(
            image: Image("turtlerock"),
            title: "The title",
            subtitle: "The subtitle",
            number: 10
        )
    }
}


//
//
//struct CircleImageSettings: SettingModel {
//    var image: Setting<Image>
//}
//
//class SettingBuilder {
//    func make(setting: SettingModel) -> some View {
//
//    }
//}

//extension CircleImage: PlaybookSupportable {}
