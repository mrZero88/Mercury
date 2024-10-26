//
//  UINavigationController.swift
//  Mercury
//
//  Created by Daniel Correia on 26.10.24.
//

import UIKit

extension UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
    }
}
