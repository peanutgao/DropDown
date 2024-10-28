//
//  DPDKeyboardListener.swift
//  DropDown
//
//  Created by Kevin Hirsch on 30/07/15.
//  Copyright (c) 2015 Kevin Hirsch. All rights reserved.
//

import UIKit

// MARK: - KeyboardListener

final class KeyboardListener {
    static let sharedInstance = KeyboardListener()

    private(set) var isVisible = false
    private(set) var keyboardFrame = CGRect.zero
    private var isListening = false

    deinit {
        stopListeningToKeyboard()
    }
}

// MARK: - Notifications

extension KeyboardListener {
    func startListeningToKeyboard() {
        if isListening {
            return
        }

        isListening = true

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    func stopListeningToKeyboard() {
        NotificationCenter.default.removeObserver(self)
    }

    @objc
    private func keyboardWillShow(_ notification: Notification) {
        isVisible = true
        keyboardFrame = keyboardFrame(fromNotification: notification)
    }

    @objc
    private func keyboardWillHide(_ notification: Notification) {
        isVisible = false
        keyboardFrame = keyboardFrame(fromNotification: notification)
    }

    private func keyboardFrame(fromNotification notification: Notification) -> CGRect {
        ((notification as NSNotification).userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?
            .cgRectValue ?? CGRect.zero
    }
}
