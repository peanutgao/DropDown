//
//  DPDUIView+Extension.swift
//  DropDown
//
//  Created by Kevin Hirsch on 28/07/15.
//  Copyright (c) 2015 Kevin Hirsch. All rights reserved.
//

import UIKit

// MARK: - Constraints

extension UIView {
    func addConstraints(
        format: String,
        options: NSLayoutConstraint.FormatOptions = [],
        metrics: [String: AnyObject]? = nil,
        views: [String: UIView]
    ) {
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: format,
            options: options,
            metrics: metrics,
            views: views
        ))
    }

    func addUniversalConstraints(
        format: String,
        options: NSLayoutConstraint.FormatOptions = [],
        metrics: [String: AnyObject]? = nil,
        views: [String: UIView]
    ) {
        addConstraints(format: "H:\(format)", options: options, metrics: metrics, views: views)
        addConstraints(format: "V:\(format)", options: options, metrics: metrics, views: views)
    }
}

// MARK: - Bounds

extension UIView {
    var windowFrame: CGRect? {
        superview?.convert(frame, to: nil)
    }
}

extension UIWindow {
    static func visibleWindow() -> UIWindow? {
        var currentWindow = UIApplication.shared.keyWindow

        if currentWindow == nil {
            let frontToBackWindows = Array(UIApplication.shared.windows.reversed())

            for window in frontToBackWindows {
                if window.windowLevel == UIWindow.Level.normal {
                    currentWindow = window
                    break
                }
            }
        }

        return currentWindow
    }
}
