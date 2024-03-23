//
//  UIView+ActivityIndicator.swift
//  AmexAssignemnt
//
//  Created by Shruti Gupta on 06/02/24.
//

import Foundation
import UIKit

private let activityIndicator = UIActivityIndicatorView(style: .medium)

extension UIView {
    
    func showActivityIndicator() {
        activityIndicator.color = .darkGray
        activityIndicator.center = self.center
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        addSubview(activityIndicator)
    }

    func hideActivityIndicator() {
        activityIndicator.removeFromSuperview()
    }
}
