//
//  EditSectionSheetView.swift
//  Mercury
//
//  Created by Daniel Correia on 03.06.23.
//

import SwiftUI
import CoreData

struct EditSectionSheetView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: ViewModel
    @ObservedObject var section: Section
    
    @State var title: String = ""
    @State var text: String = ""
    
    @FetchRequest(
        sortDescriptors: [
            SortDescriptor(\.order, order: SortOrder.forward)
        ],
        predicate: NSPredicate(format: "key == %@", "accentColor")
    ) var settings: FetchedResults<Setting>
    
    @FetchRequest(
        sortDescriptors: [
            SortDescriptor(\.order, order: SortOrder.forward)
        ],
        predicate: NSPredicate(format: "key == %@", "tertiaryColorOpacity")
    ) var settingsTertiaryOpacity: FetchedResults<Setting>
    
    var body: some View {
        VStack(spacing: BorderPadding) {
            SheetHeader(title: "New Topic")
            Grid(horizontalSpacing: BorderPadding, verticalSpacing: BorderPadding) {
                GridRow {
                    TextFieldView(textValue: Binding<String> (
                        get: {
                            return title
                        },
                        set: {
                            title = $0
                        }
                    ), help: String(localized: String.LocalizationValue("Section title")), textLimit: SectionValidation.titleMaxChars)
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
                    // Image
                }
                GridRow {
                    HStack {
                        SheetButtonView(title: "Cancel", clickFunction: cancel)
                        SheetButtonView(title: "Save", clickFunction: save)
                            .disabled(title.isEmpty || title.count > SectionValidation.titleMaxChars || text.isEmpty)
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
            section.title = title
            section.text = text
            
            viewModel.sectionsController.saveSection(section: section)
            dismiss()
        }
    }
    
    func cancel() {
        PlaySound(sound: .navigation)
        PlayHaptic()
        dismiss()
    }
    
    func onOpenSheet() {
        self.title = section.title ?? ""
        self.text = section.text ?? ""
    }
    
    func onCloseSheet() {
        PersistenceController.discardChanges()
    }
}

struct EditSectionSheetView_Previews: PreviewProvider {
    static var previews: some View {
        EditSectionSheetView(section: Section())
    }
}
