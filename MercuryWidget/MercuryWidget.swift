//
//  MercuryWidget.swift
//  MercuryWidget
//
//  Created by Daniel Correia on 16.06.23.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    let vm: WidgetViewModel = WidgetViewModel()
    
    func placeholder(in context: Context) -> SimpleEntry {
        return SimpleEntry(id: nil, title: DefaultWidgetCardTitle, subtitle: DefaultWidgetCardSubtitle, themeTitle: DefaultWidgetCardThemeTitle, text1: DefaultWidgetCardText1, text2: DefaultWidgetCardText2, date: Date(), currentWidgetIndex: 1, totalWidgetsCount: 1, icon: "", configuration: ConfigurationIntent())
    }
    
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let topic = vm.randomTopics.randomElement()
        let title = topic?.title ?? DefaultWidgetCardTitle
        let type = topic?.subtitle ?? DefaultWidgetCardSubtitle
        let themeTitle = topic?.theme?.title ?? DefaultWidgetCardThemeTitle
        let text1 = topic?.activeSections.first(where: {$0.order == 1})?.text ?? DefaultWidgetCardText1
        let text2 = topic?.activeSections.first(where: {$0.order == 2})?.text ?? DefaultWidgetCardText2
        let icon = topic?.theme?.iconName ?? ""
        
        let entry = SimpleEntry(id: nil, title: title, subtitle: type, themeTitle: themeTitle, text1: text1!, text2: text2!, date: Date(), currentWidgetIndex: 1, totalWidgetsCount: 1, icon: icon, configuration: configuration)
        
        completion(entry)
    }
    
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        
        let topics = vm.randomTopics
        let topicsCount = topics.count
        
        if(topicsCount == 0) {
            let entry = SimpleEntry(id: nil, title: DefaultNoTopicTitle, subtitle: DefaultNoTopicSubtitle, themeTitle: DefaultWidgetCardThemeTitle, text1: DefaultNoTopicText1, text2: DefaultNoTopicText2, date: Date(), currentWidgetIndex: 1, totalWidgetsCount: 1, icon: "", configuration: configuration)
            entries.append(entry)
        }
        
        for hourOffset in 0 ..< topicsCount {
            let topic = topics[hourOffset]
            let entryDate = Calendar.current.date(byAdding: .minute, value: hourOffset * 10, to: currentDate)!
            
            let title = topic.title ?? ""
            let type = topic.subtitle ?? ""
            let themeTitle = topic.theme?.title ?? ""
            let text1 = topic.activeSections.first(where: {$0.order == 1})?.text ?? ""
            let text2 = topic.activeSections.first(where: {$0.order == 2})?.text ?? ""
            let icon = topic.theme?.iconName ?? ""
            
            let entry = SimpleEntry(id: topic.id, title: title, subtitle: type, themeTitle: themeTitle, text1: text1, text2: text2, date: entryDate, currentWidgetIndex: hourOffset + 1, totalWidgetsCount: topicsCount, icon: icon, configuration: configuration)
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let id: UUID?
    let title: String
    let subtitle: String
    let themeTitle: String
    let text1: String
    let text2: String
    let date: Date
    let currentWidgetIndex: Int
    let totalWidgetsCount: Int
    let icon: String
    let configuration: ConfigurationIntent
}

struct MercuryWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        WidgetCardView(id: entry.id, title: entry.title, subtitle: entry.subtitle, themeTitle: entry.themeTitle, text1: entry.text1, text2: entry.text2, date: entry.date, currentWidgetIndex: entry.currentWidgetIndex, totalWidgetsCount: entry.totalWidgetsCount, icon: entry.icon)
    }
}

struct MercuryWidget: Widget {
    let kind: String = "DesignPatternsWidget"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            MercuryWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemLarge])
    }
}

struct DesignPatternsWidget_Previews: PreviewProvider {
    static var previews: some View {
        let vm = WidgetViewModel()
        
        let topic = vm.randomTopics.randomElement()
        let title = topic?.title ?? DefaultWidgetCardTitle
        let type = topic?.subtitle ?? DefaultWidgetCardSubtitle
        let themeTitle = topic?.theme?.title ?? DefaultWidgetCardThemeTitle
        let text1 = topic?.activeSections.first(where: {$0.order == 1})?.text ?? DefaultWidgetCardText1
        let text2 = topic?.activeSections.first(where: {$0.order == 2})?.text ?? DefaultWidgetCardText2
        let icon = topic?.theme?.iconName ?? ""
        
        MercuryWidgetEntryView(entry: SimpleEntry(id: nil, title: title, subtitle: type, themeTitle: themeTitle, text1: text1, text2: text2, date: Date(), currentWidgetIndex: 1, totalWidgetsCount: 1, icon: icon, configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemExtraLarge))
    }
}
