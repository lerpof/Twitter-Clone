//
//  UINavigationControllerExtension.swift
//  Twitter Clone
//
//  Created by CGMCONSULTING on 16/05/22.
//

import UIKit

extension UINavigationController: UIGestureRecognizerDelegate {
	override open func viewDidLoad() {
		super.viewDidLoad()
		interactivePopGestureRecognizer?.delegate = self
	}

	public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
		return viewControllers.count > 1
	}
}
