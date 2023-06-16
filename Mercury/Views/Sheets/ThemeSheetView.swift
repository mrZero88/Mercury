//
//  ThemeSheetView.swift
//  Mercury
//
//  Created by Daniel Correia on 03.06.23.
//

import SwiftUI

struct ThemeSheetView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: ViewModel
    @StateObject var theme: Theme
    var isCreating: Bool
    
    var body: some View {
        Grid(horizontalSpacing: BorderPadding, verticalSpacing: BorderPadding) {
            GridRow {
                Text(isCreating ? "New Theme" : "Edit Theme").font(.title)
            }
            GridRow {
                TextFieldIconView(inSheet: false, textValue: Binding<String> (
                    get: {
                        return theme.title ?? ""
                    },
                    set: {
                        theme.title = $0
                    }
                ), iconValue: Binding<String> (
                    get: {
                        return theme.iconName ?? DefaultThemeIconName
                    },
                    set: {
                        theme.iconName = $0
                    }
                ), help: String(localized: String.LocalizationValue("Theme title")), textLimit: ThemeValidation.titleMaxChars)
            }
            GridRow {
                TextEditorView(text: Binding<String> (
                    get: {
                        return theme.text ?? ""
                    },
                    set: {
                        theme.text = $0
                    }
                ))
            }
            GridRow {
                HStack {
                    SheetButtonView(inSheet: false, title: "Cancel", clickFunction: cancel)
                    SheetButtonView(inSheet: false, title: "Save", clickFunction: saveTheme)
                        .disabled(theme.title?.isEmpty ?? true && (theme.title?.count ?? 0) <= ThemeValidation.titleMaxChars)
                }
                .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding()
        .frame(maxHeight: .infinity)
        .background(Color.accentColor.opacity(0.5).ignoresSafeArea())
        .onDisappear {
            onCloseSheet()
        }
    }
    
    func saveTheme() {
        withAnimation {
            viewModel.themesController.saveTheme(theme: theme, isCreating: isCreating)
        }
        dismiss()
    }
    
    func cancel() {
        withAnimation {
            viewModel.themesController.cancelSaveTheme(theme: theme)
        }
        dismiss()
    }
    
    func onCloseSheet() {
        if(isCreating) {
            if(theme.isInserted) {
                theme.delete()
            }
        }
    }
}

struct ThemeSheetView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeSheetView(theme: Theme(), isCreating: false)
    }
}