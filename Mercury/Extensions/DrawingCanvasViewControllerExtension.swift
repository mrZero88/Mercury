//
//  DrawingCanvasViewControllerExtension.swift
//  Alien
//
//  Created by Daniel Correia on 27.02.23.
//

import Foundation
import PencilKit
#if os(iOS)
extension DrawingCanvasViewController: PKToolPickerObserver, PKCanvasViewDelegate {
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {        drawingChanged(canvasView.drawing.dataRepresentation())
    }
}
#endif
