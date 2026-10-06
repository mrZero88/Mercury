//
//  ZMercuryIphoneView.swift
//  SaturnX
//
//  Created by Daniel Correia on 05.11.23.
//

import SwiftUI
import CoreData
import Utils

struct ZMercuryIphoneView: View {
    @Environment(\.dismiss) var dismiss
    
    @FetchRequest(
        sortDescriptors: [
            SortDescriptor(\.order, order: SortOrder.forward)
        ],
        predicate: NSPredicate(format: "key == %@", "showBorder")
    ) var showBorder: FetchedResults<Setting>
    
    @FetchRequest(
        sortDescriptors: [
            SortDescriptor(\.order, order: SortOrder.forward)
        ],
        predicate: NSPredicate(format: "key == %@", "tertiaryColorOpacity")
    ) var settingsTertiaryOpacity: FetchedResults<Setting>
    
    var body: some View {
        VStack(spacing: BorderPadding) {
            HStack {
                Button {
                    PlaySound(sound: .navigation)
                    PlayHaptic()
                    dismiss()
                } label: {
                    ZStack {
                        Label("Collapse Sidebar", systemImage: "sidebar.left").labelStyle(.iconOnly).frame(maxHeight: .infinity)
                        Label("", systemImage: "star").labelStyle(.iconOnly).opacity(0)
                    }
                }
                .buttonStyle(.bordered)
                Text("zMercury").font(.footnote).fontWeight(.bold).foregroundColor(Color.accentColor).padding(.trailing)
                Spacer()
            }
            .padding(BorderPadding)
            .background(PanelColor)
            .overlay((showBorder.first?.boolValue ?? false) ? RoundedRectangle(cornerRadius: CornerRadius).stroke(Color.accentColor, lineWidth: 1): RoundedRectangle(cornerRadius: CornerRadius).stroke(Color.clear, lineWidth: 0))
            .cornerRadius(CornerRadius)
            .gridCellColumns(1)
            .fixedSize(horizontal: false, vertical: true)
            .padding(.horizontal, BorderPadding6)
            VStack(spacing: 16) {
                Spacer()
                Image(uiImage: UIImage(named: "mercury.png") ?? UIImage()).resizable().frame(width: 200, height: 200)
                    .padding()
                    .padding()
                    .background(
                        Circle()
                            .fill(TertiaryColor
                                .opacity(settingsTertiaryOpacity.first?.doubleValue ?? TertiaryColorOpacity))
                            .stroke(Color.accentColor, lineWidth: 1)
                    )
                Spacer()
                VStack(spacing: BorderPadding) {
                    Text("zMercury").bold().foregroundColor(.accentColor)
                    Text("Flyzerosky")
                    Text("2026")
                    Text("v1.0")
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, BorderPadding)
            .background(PanelColor)
            .overlay((showBorder.first?.boolValue ?? false) ? RoundedRectangle(cornerRadius: CornerRadius).stroke(Color.accentColor, lineWidth: 1): RoundedRectangle(cornerRadius: CornerRadius).stroke(Color.clear, lineWidth: 0))
            .cornerRadius(CornerRadius)
            .padding(.horizontal, BorderPadding6)
            
        }
        .background(SvgBackgroundView())
#if os(iOS)
        .navigationBarHidden(true)
#endif
    }
}

#Preview {
    ZMercuryIphoneView()
}
