//
//  NavigationLinkThemeView.swift
//  Mercury
//
//  Created by Daniel Correia on 03.06.23.
//

import SwiftUI

struct NavigationLinkThemeView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var viewModel: ViewModel
    @ObservedObject var theme: Theme
    @State var alertInfo: AlertInfo?
    @State var showEditSheet = false
    
    var colorTheme: Color {
        get {
            return colorScheme == .dark ? Color("White") : Color("Black")
        }
    }
    
    var body: some View {
        NavigationLink(value: "theme//" + (theme.id?.description ?? "")) {
            HStack {
                if(!(theme.iconName?.isEmpty ?? true)) {
                    Image(theme.iconName ?? "").resizable().scaledToFit().foregroundColor(Color.accentColor).frame(width: 40, height: 40, alignment: .center).padding(.vertical)
                }
                VStack(alignment: .leading) {
                    Text(theme.title ?? "").padding(.leading, BorderPadding).foregroundColor(colorTheme)
                    Text(String(theme.activeTopics.count)).padding(.leading, BorderPadding).foregroundColor(.secondary).font(.footnote)
                }
                Spacer()
            }
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button {
                alertInfo = ShowDeleteThemeAlert()
            } label: {
                Label("Delete", systemImage: "minus.circle").labelStyle(.iconOnly)
            }
            .tint(ColorUtils.getColor(colorScheme: colorScheme, colorName: "Red").opacity(0.5))
        }
        .swipeActions(edge: .leading, allowsFullSwipe: true) {
            Button {
                showEditSheet = true
                PlaySound(sound: .openModal)
            } label: {
                Label("Edit", systemImage: "pencil.circle").labelStyle(.iconOnly)
            }
            .tint(ColorUtils.getColor(colorScheme: colorScheme, colorName: "Yellow").opacity(0.5))
        }
        .sheet(isPresented: $showEditSheet) {
            ThemeSheetView(theme: theme, isCreating: false)
                .accentColor(Color.getColor(colorScheme: colorScheme))
        }
        .alert(item: $alertInfo, content: { info in
            showAlert(info: info, viewModel: viewModel, theme: theme)
        })
        .listRowSeparatorTint(Color.accentColor)
        .listRowBackground(
            PanelColor
        )
    }
}

struct NavigationLinkThemeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationLinkThemeView(theme: Theme())
    }
}
