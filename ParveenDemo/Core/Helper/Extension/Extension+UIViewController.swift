//
//  Extension+UIViewController.swift
//  ParveenDemo
//
//  Created by ParveenKhan on 05/12/24.
//

import UIKit

extension UIViewController {
    func setStatusBarBackgroundColor(_ color: UIColor) {
        if let statusBarFrame = view.window?.windowScene?.statusBarManager?.statusBarFrame {
            let statusBarView = UIView(frame: statusBarFrame)
            statusBarView.backgroundColor = color
            view.addSubview(statusBarView)
        }
    }
}
