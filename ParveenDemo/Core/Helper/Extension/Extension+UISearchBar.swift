//
//  Extension+UIViewController.swift
//  ParveenDemo
//
//  Created by ParveenKhan on 05/12/24.
//

import UIKit

extension UISearchBar {
    func setIconColor(_ color: UIColor) {
        for subView in self.subviews {
            for subSubView in subView.subviews {
                let view = subSubView as? UITextInputTraits
                if view != nil {
                    let textField = view as? UITextField
                    let glassIconView = textField?.leftView as? UIImageView
                    glassIconView?.image = glassIconView?.image?.withRenderingMode(.alwaysTemplate)
                    glassIconView?.tintColor = color
                    break
                }
            }
        }
    }
}

extension UISearchBar {
    func setPlaceholderColor(_ color: UIColor) {
        let textField = self.value(forKey: "searchField") as? UITextField
        let placeholder = textField!.value(forKey: "placeholderLabel") as? UILabel
        placeholder?.textColor = color
    }
}
