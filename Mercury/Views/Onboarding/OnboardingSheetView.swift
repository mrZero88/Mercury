//
//  OnboardingSheetView.swift
//  Venus
//
//  Created by Daniel Correia on 03.01.23.
//

import SwiftUI

struct OnboardingSheetView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State private var tabSelection = 1
    
    var body: some View {
        TabView(selection: $tabSelection) {
            OnboardingPage1View(tabSelection: $tabSelection).tag(1)
            OnboardingPage2View(tabSelection: $tabSelection).tag(2)
            OnboardingPage3View(tabSelection: $tabSelection).tag(3)
            OnboardingPage4View(tabSelection: $tabSelection).tag(4)
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .background(Color.accentColor.opacity(0.5).ignoresSafeArea())
    }
}

struct OnboardingSheetView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingSheetView()
    }
}
