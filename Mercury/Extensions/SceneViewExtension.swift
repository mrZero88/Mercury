//
//  SceneViewExtension.swift
//  Neptune
//
//  Created by Daniel Correia on 16.06.22.
//

import SwiftUI
import SceneKit

extension SceneView {
    init(scene: SCNScene? = nil, options: SceneView.Options = []) {
        scene?.background.contents = UIColor.secondarySystemBackground
        let pointOfView = scene?.rootNode.childNode(withName: "camera", recursively: false)
        self.init(scene: scene, pointOfView: pointOfView, options: options)
    }
}
