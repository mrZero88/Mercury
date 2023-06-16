//
//  MercuryWidgetBundle.swift
//  MercuryWidget
//
//  Created by Daniel Correia on 16.06.23.
//

import WidgetKit
import SwiftUI

@main
struct MercuryWidgetBundle: WidgetBundle {
    var body: some Widget {
        MercuryWidget()
        MercuryWidgetLiveActivity()
    }
}
