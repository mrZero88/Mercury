//
//  InfoItemView.swift
//  Mercury
//
//  Created by Daniel Correia on 20.06.22.
//

import SwiftUI

struct InfoItemView: View {
    var title: String = ""
    var description: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            if(!title.isEmpty) {
                Text(title)
                    .font(.title)
                    .bold()
            }
            HStack {
                Text(description)
                    .padding(10.0)
                Spacer()
            }
            .panel()
        }
        .padding(.horizontal, 10.0)
        .padding(.bottom, 10.0)
    }
}

struct InfoItemView_Previews: PreviewProvider {
    static var previews: some View {
        InfoItemView(title: "", description: "")
    }
}
