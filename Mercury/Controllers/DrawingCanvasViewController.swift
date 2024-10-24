//
//  DrawingCanvasViewController.swift
//  Moon
//
//  Created by Daniel Correia on 29.05.22.
//

import Foundation
import SwiftUI
import PencilKit
#if os(iOS)
class DrawingCanvasViewController: UIViewController {
    
    lazy var canvas: PKCanvasView = {
        let view = PKCanvasView()
        view.drawingPolicy = PKCanvasViewDrawingPolicy.pencilOnly
        view.isScrollEnabled = true
        view.minimumZoomScale = 1
        view.maximumZoomScale = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var toolPicker: PKToolPicker = {
        let toolPicker = PKToolPicker()
        toolPicker.addObserver(self)
        return toolPicker
    }()
    
    var drawingData = Data()
    
    var drawingChanged: (Data) -> Void = {_ in}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(canvas)
        NSLayoutConstraint.activate([                                        canvas.leadingAnchor.constraint(equalTo: view.leadingAnchor),                                        canvas.trailingAnchor.constraint(equalTo: view.trailingAnchor),                                        canvas.topAnchor.constraint(equalTo: view.topAnchor),                                        canvas.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
        toolPicker.setVisible(true, forFirstResponder: canvas)
        toolPicker.addObserver(canvas)
        canvas.delegate = self
        canvas.becomeFirstResponder()
        canvas.backgroundColor = UIColor(PanelColor)
        if let drawing = try? PKDrawing(data: drawingData){
            canvas.drawing = drawing
        }
    }
}
#endif
