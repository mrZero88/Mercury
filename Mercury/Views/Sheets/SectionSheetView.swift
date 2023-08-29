//
//  SectionSheetView.swift
//  Mercury
//
//  Created by Daniel Correia on 03.06.23.
//

import SwiftUI

struct SectionSheetView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: ViewModel
    @StateObject var section: Section
    var isCreating: Bool
    
    var body: some View {
        Grid(horizontalSpacing: BorderPadding, verticalSpacing: BorderPadding) {
            GridRow {
                HStack {
                    Text(section.createdAt?.formatted(date: .numeric, time: .omitted) ?? "").font(.footnote).foregroundColor(.secondary)
                    Spacer()
                    if(UIDevice.isIPad) {
                        Text(isCreating ? "New Section" : "Edit Section").font(.title)
                    } else {
                        Text(isCreating ? "New Section" : "Edit Section")
                    }
                    Spacer()
                    Text(section.updatedAt?.formatted(date: .numeric, time: .omitted) ?? "").font(.footnote).foregroundColor(.secondary)
                }
            }
            GridRow {
                TextFieldView(inSheet: false, textValue: Binding<String> (
                    get: {
                        return section.title ?? ""
                    },
                    set: {
                        section.title = $0
                    }
                ), help: String(localized: String.LocalizationValue("Section title")), textLimit: SectionValidation.titleMaxChars)
            }
            GridRow {
                TextEditorView(text: Binding<String> (
                    get: {
                        return section.text ?? ""
                    },
                    set: {
                        section.text = $0
                    }
                ))
            }
            GridRow {
                // Image
            }
            GridRow {
                HStack {
                    SheetButtonView(inSheet: false, title: "Cancel", clickFunction: cancel)
                    SheetButtonView(inSheet: false, title: "Save", clickFunction: saveSection)
                        .disabled((section.title?.count ?? 0) <= SectionValidation.titleMaxChars && ((section.title?.isEmpty ?? true) || (section.text?.isEmpty ?? true)))
                }
                .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding()
        .frame(maxHeight: .infinity)
        .background(Color.getColor(colorScheme: colorScheme).gradient.opacity(colorScheme == .dark ? 0.5 : 1.0))
        .onDisappear {
            onCloseSheet()
        }
    }
    
    func saveSection() {
        withAnimation {
            viewModel.sectionsController.saveSection(section: section, isCreating: isCreating)
        }
        dismiss()
    }
    
    func cancel() {
        withAnimation {
            viewModel.sectionsController.cancelSaveSection(section: section)
        }
        dismiss()
    }
    
    func onCloseSheet() {
        if(isCreating) {
            if(section.isInserted) {
                section.delete()
            }
        }
    }
}

struct SectionSheetView_Previews: PreviewProvider {
    static var previews: some View {
        SectionSheetView(section: Section(), isCreating: false)
    }
}
