//
//  DrawingCanvasView.swift
//  Alien
//
//  Created by Daniel Correia on 29.05.22.
//

import Foundation
import SwiftUI
import CoreData

#if os(iOS)
struct DrawingCanvasView: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = DrawingCanvasViewController
    var data: Data
    //var task: Task
    var noSave = false
    
    func makeUIViewController(context: Context) -> DrawingCanvasViewController {
        let viewController = DrawingCanvasViewController()
        
        viewController.drawingData = data
        
        viewController.drawingChanged = { data in
            //task.drawing = data
            if(!noSave) {
                PersistenceController.save()
            }
        }
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: DrawingCanvasViewController, context: Context) {
        uiViewController.drawingData = data
    }
}
#endif
