//
//  TopicSheetView.swift
//  Mercury
//
//  Created by Daniel Correia on 03.06.23.
//

import SwiftUI

struct TopicSheetView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: ViewModel
    @StateObject var topic: Topic
    var isCreating: Bool
    
    @FetchRequest(
        sortDescriptors: [
            SortDescriptor(\.order, order: SortOrder.forward)
        ],
        predicate: NSPredicate(format: "key == %@", "tertiaryColorOpacity")
    ) var settingsTertiaryOpacity: FetchedResults<Setting>
    
    var body: some View {
        Grid(horizontalSpacing: BorderPadding, verticalSpacing: BorderPadding) {
            GridRow {
                HStack {
                    Text(topic.createdAt?.formatted(date: .numeric, time: .omitted) ?? "").font(.footnote).foregroundColor(.secondary)
                    Spacer()
                    if(UIDevice.isIPad) {
                        Text(isCreating ? "New Topic" : "Edit Topic").font(.title)
                    } else {
                        Text(isCreating ? "New Topic" : "Edit Topic")
                    }
                    Spacer()
                    Text(topic.updatedAt?.formatted(date: .numeric, time: .omitted) ?? "").font(.footnote).foregroundColor(.secondary)
                }
            }
            GridRow {
                TextFieldIconView(textValue: Binding<String> (
                    get: {
                        return topic.title ?? ""
                    },
                    set: {
                        topic.title = $0
                    }
                ), iconValue: Binding<String> (
                    get: {
                        return topic.iconName ?? DefaultThemeIconName
                    },
                    set: {
                        topic.iconName = $0
                    }
                ), help: String(localized: String.LocalizationValue("Topic title")), textLimit: TopicValidation.titleMaxChars)
            }
            GridRow {
                TextFieldView(textValue: Binding<String> (
                    get: {
                        return topic.subtitle ?? ""
                    },
                    set: {
                        topic.subtitle = $0
                    }
                ), help: String(localized: String.LocalizationValue("Topic subtitle")), textLimit: TopicValidation.titleMaxChars)
            }
            GridRow {
                TextEditorView(text: Binding<String> (
                    get: {
                        return topic.text ?? ""
                    },
                    set: {
                        topic.text = $0
                    }
                ))
            }
            GridRow {
                HStack {
                    SheetButtonView(title: "Cancel", clickFunction: cancel)
                    SheetButtonView(title: "Save", clickFunction: saveTopic)
                        .disabled(topic.title?.isEmpty ?? true && (topic.title?.count ?? 0) <= TopicValidation.titleMaxChars)
                }
                .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding()
        .frame(maxHeight: .infinity)
        .background(TertiaryColor.opacity(settingsTertiaryOpacity.first?.doubleValue ?? TertiaryColorOpacity))
        .onDisappear {
            onCloseSheet()
        }
    }
    
    func saveTopic() {
        withAnimation {
            viewModel.topicsController.saveTopic(topic: topic, isCreating: isCreating)
        }
        dismiss()
    }
    
    func cancel() {
        withAnimation {
            viewModel.topicsController.cancelSaveTopic(topic: topic)
        }
        dismiss()
    }
    
    func onCloseSheet() {
        if(isCreating) {
            if(topic.isInserted) {
                topic.delete()
            }
        }
    }
}

struct TopicSheetView_Previews: PreviewProvider {
    static var previews: some View {
        TopicSheetView(topic: Topic(), isCreating: false)
    }
}
