//
//  WidgetCardView.swift
//  Mercury
//
//  Created by Daniel Correia on 08.02.23.
//

import SwiftUI

struct WidgetCardView: View {
    @Environment(\.colorScheme) var colorScheme
    var id: UUID?
    var title: String
    var subtitle: String
    var themeTitle: String
    var text1: String
    var text2: String
    var date: Date
    var currentWidgetIndex: Int
    var totalWidgetsCount: Int
    var icon: String
    
    var body: some View {
        VStack {
            if(!title.isEmpty && !text1.isEmpty) {
                if(id != nil) {
                    Link(destination: URL(string: "widget://" + id!.description)!) {
                        HStack {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(title).font(.title)
                                    Spacer()
                                }
                                Text(themeTitle).font(.subheadline).foregroundColor(Color.yellow)
                                HStack {
                                    Text(subtitle).font(.subheadline).foregroundColor(.secondary)
                                    Spacer()
                                    Text(String(currentWidgetIndex) + "/" + String(totalWidgetsCount)).font(.footnote).foregroundColor(.secondary)
                                    Text(date.formatted(date: .omitted, time: .shortened)).font(.footnote).foregroundColor(.secondary)
                                }
                                Text(text1)
                                    .padding(.top, 5)
                                if(!text2.isEmpty) {
                                    Text(text2)
                                        .padding(.top, 5)
                                }
                                Spacer()
                            }
                            Spacer()
                        }
                    }
                } else {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(title).font(.title)
                            Text(themeTitle).font(.subheadline).foregroundColor(Color.yellow)
                            HStack {
                                Text(subtitle).font(.subheadline).foregroundColor(.secondary)
                                Spacer()
                                Text(String(currentWidgetIndex) + "/" + String(totalWidgetsCount)).font(.footnote).foregroundColor(.secondary)
                                Text(date.formatted(date: .omitted, time: .shortened)).font(.footnote).foregroundColor(.secondary)
                            }
                            Text(text1)
                                .padding(.top, 5)
                            if(!text2.isEmpty) {
                                Text(text2)
                                    .padding(.top, 5)
                            }
                            Spacer()
                        }
                        Spacer()
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background(PanelColor)
    }
}

struct WidgetCardView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetCardView(title: "Hello", subtitle: "World", themeTitle: "", text1: "This is hello world", text2: "This is how it is", date: Date(), currentWidgetIndex: 1, totalWidgetsCount: 1, icon: "")
    }
}
