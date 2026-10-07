//
//  EditTopicSheetView.swift
//  Mercury
//
//  Created by Daniel Correia on 03.06.23.
//

import SwiftUI
import CoreData

struct EditTopicSheetView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: ViewModel
    @ObservedObject var topic: Topic
    
    @State var title: String = ""
    @State var subtitle: String = ""
    @State var iconName: String = DefaultThemeIconName
    @State var text: String = ""
    
    @FetchRequest(
        sortDescriptors: [
            SortDescriptor(\.order, order: SortOrder.forward)
        ],
        predicate: NSPredicate(format: "key == %@", "tertiaryColorOpacity")
    ) var settingsTertiaryOpacity: FetchedResults<Setting>
    
    var body: some View {
        VStack(spacing: BorderPadding) {
            SheetHeader(title: "Edit Topic")
            Grid(horizontalSpacing: BorderPadding, verticalSpacing: BorderPadding) {
                GridRow {
                    TextFieldIconView(textValue: Binding<String> (
                        get: {
                            return title
                        },
                        set: {
                            title = $0
                        }
                    ), iconValue: Binding<String> (
                        get: {
                            return iconName
                        },
                        set: {
                            iconName = $0
                        }
                    ), help: String(localized: String.LocalizationValue("Topic title")), textLimit: TopicValidation.titleMaxChars)
                }
                GridRow {
                    TextFieldView(textValue: Binding<String> (
                        get: {
                            return subtitle
                        },
                        set: {
                            subtitle = $0
                        }
                    ), help: String(localized: String.LocalizationValue("Topic subtitle")), textLimit: TopicValidation.titleMaxChars)
                }
                GridRow {
                    TextEditorView(text: Binding<String> (
                        get: {
                            return text
                        },
                        set: {
                            text = $0
                        }
                    ))
                }
                GridRow {
                    HStack {
                        SheetButtonView(title: "Cancel", clickFunction: cancel)
                        SheetButtonView(title: "Save", clickFunction: save)
                            .disabled(title.isEmpty || title.count > TopicValidation.titleMaxChars)
                    }
                    .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
        .padding()
        .frame(maxHeight: .infinity)
        .background(TertiaryColor.opacity(settingsTertiaryOpacity.first?.doubleValue ?? TertiaryColorOpacity))
        .onDisappear {
            onCloseSheet()
        }
        .onAppear {
            onOpenSheet()
        }
    }
    
    func save() {
        withAnimation(ShowAnimation ? .easeInOut(duration: AnimationDuration) : nil) {
            topic.title = title
            topic.subtitle = title
            topic.text = text
            topic.iconName = iconName
            
            viewModel.topicsController.saveTopic(topic: topic)
            dismiss()
        }
    }
    
    func cancel() {
        PlaySound(sound: .navigation)
        PlayHaptic()
        dismiss()
    }
    
    func onOpenSheet() {
        self.title = topic.title ?? ""
        self.subtitle = topic.subtitle ?? ""
        self.iconName = topic.iconName ?? DefaultThemeIconName
        self.text = topic.text ?? ""
    }
    
    func onCloseSheet() {
        PersistenceController.discardChanges()
    }
}

struct EditTopicSheetView_Previews: PreviewProvider {
    static var previews: some View {
        EditTopicSheetView(topic: Topic())
    }
}
