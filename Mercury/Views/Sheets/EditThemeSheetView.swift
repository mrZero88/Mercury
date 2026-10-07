//
//  ThemeSheetView.swift
//  Mercury
//
//  Created by Daniel Correia on 03.06.23.
//

import SwiftUI
import CoreData

struct EditThemeSheetView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: ViewModel
    @ObservedObject var theme: Theme
    
    @State var title: String = ""
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
            SheetHeader(title: "New Theme")
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
                    ), help: String(localized: String.LocalizationValue("Theme title")), textLimit: ThemeValidation.titleMaxChars)
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
                            .disabled(title.isEmpty && title.count <= ThemeValidation.titleMaxChars)
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
            let theme = Theme.createEmptyTheme()
            theme.title = title
            theme.text = text
            theme.iconName = iconName
            
            viewModel.themesController.saveTheme(theme: theme)
            dismiss()
        }
        dismiss()
    }
    
    func cancel() {
        PlaySound(sound: .navigation)
        PlayHaptic()
        dismiss()
    }
    
    func onOpenSheet() {
        self.title = theme.title ?? ""
        self.iconName = theme.iconName ?? DefaultThemeIconName
        self.text = theme.text ?? ""
    }
    
    func onCloseSheet() {
        PersistenceController.discardChanges()
    }
}

struct EditThemeSheetView_Previews: PreviewProvider {
    static var previews: some View {
        EditThemeSheetView(theme: Theme())
    }
}
