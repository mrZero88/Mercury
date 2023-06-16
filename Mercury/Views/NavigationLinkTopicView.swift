//
//  NavigationLinkTopicView.swift
//  Mercury
//
//  Created by Daniel Correia on 03.06.23.
//

import SwiftUI

struct NavigationLinkTopicView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var viewModel: ViewModel
    @ObservedObject var topic: Topic
    @State var alertInfo: AlertInfo?
    @State var showEditSheet = false
    
    var colorTheme: Color {
        get {
            return colorScheme == .dark ? Color("White") : Color("Black")
        }
    }
    
    var body: some View {
        NavigationLink(value: "topic//" + (topic.id?.description ?? "")) {
            HStack {
                if(!(topic.iconName?.isEmpty ?? true)) {
                    Image(topic.iconName ?? "").resizable().scaledToFit().foregroundColor(Color.accentColor).frame(width: 40, height: 40, alignment: .center).padding(.vertical)
                }
                VStack(alignment: .leading) {
                    Text(topic.title ?? "").padding(.leading, BorderPadding).foregroundColor(colorTheme)
                    if(!(topic.subtitle?.isEmpty ?? true)) {
                        Text(topic.subtitle ?? "").padding(.leading, BorderPadding).foregroundColor(.secondary).font(.footnote)
                    }
                }
                Spacer()
            }
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button {
                alertInfo = ShowDeleteTopicAlert()
            } label: {
                Label("Delete", systemImage: "minus.circle").labelStyle(.iconOnly)
            }
            .tint(Color("Red").opacity(0.5))
        }
        .swipeActions(edge: .leading, allowsFullSwipe: true) {
            Button {
                showEditSheet = true
                PlaySound(sound: .openModal)
            } label: {
                Label("Edit", systemImage: "pencil.circle").labelStyle(.iconOnly)
            }
            .tint(Color.accentColor.opacity(0.5))
        }
        .sheet(isPresented: $showEditSheet) {
            TopicSheetView(topic: topic, isCreating: false)
                .accentColor(Color.Color)
        }
        .alert(item: $alertInfo, content: { info in
            showAlert(info: info, viewModel: viewModel, topic: topic)
        })
        .listRowSeparatorTint(Color.accentColor)
        .listRowBackground(
            PanelColor
        )
    }
}

struct NavigationLinkTopicView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationLinkTopicView(topic: Topic())
    }
}
