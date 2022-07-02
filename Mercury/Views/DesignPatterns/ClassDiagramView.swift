//
//  ClassDiagramView.swift
//  Mercury
//
//  Created by Daniel Correia on 22.06.22.
//

import SwiftUI

struct ClassDiagramView: View {
    var imageName: String
    
    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .padding()
    }
}

struct ClassDiagramView_Previews: PreviewProvider {
    static var previews: some View {
        ClassDiagramView(imageName: "")
    }
}
