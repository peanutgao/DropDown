//
//  DropDownCell.swift
//  DropDown
//
//  Created by Kevin Hirsch on 28/07/15.
//  Copyright (c) 2015 Kevin Hirsch. All rights reserved.
//

import UIKit

// MARK: - DropDownCell

open class DropDownCell: UITableViewCell {
    let optionLabel: UILabel = .init()

    var selectedBackgroundColor: UIColor?
    var highlightTextColor: UIColor?
    var normalTextColor: UIColor?

    let customSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()

    private var customSeparatorInset: UIEdgeInsets = .init(top: 0, left: 15, bottom: 0, right: 15)
    override open var separatorInset: UIEdgeInsets {
        set {
            super.separatorInset = newValue
            customSeparatorInset = newValue
            updateSeparatorConstraints()
        }
        get {
            customSeparatorInset
        }
    }

    private var separatorConstraints: [NSLayoutConstraint] = []

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .clear
        setupSubviews()
        setupSeparator()
    }

    private func setupSubviews() {
        optionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(optionLabel)
        NSLayoutConstraint.activate([
            optionLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            optionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            optionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
    }

    private func setupSeparator() {
        contentView.addSubview(customSeparator)
        customSeparator.translatesAutoresizingMaskIntoConstraints = false
        updateSeparatorConstraints()
    }

    private func updateSeparatorConstraints() {
        NSLayoutConstraint.deactivate(separatorConstraints)
        separatorConstraints = [
            customSeparator.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: customSeparatorInset.left
            ),
            customSeparator.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -customSeparatorInset.right
            ),
            customSeparator.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -customSeparatorInset.bottom
            ),
            customSeparator.heightAnchor.constraint(equalToConstant: 1)
        ]
        NSLayoutConstraint.activate(separatorConstraints)
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI

extension DropDownCell {
    override open var isSelected: Bool {
        willSet {
            setSelected(newValue, animated: false)
        }
    }

    override open var isHighlighted: Bool {
        willSet {
            setSelected(newValue, animated: false)
        }
    }

    override open func setHighlighted(_ highlighted: Bool, animated: Bool) {
        setSelected(highlighted, animated: animated)
    }

    override open func setSelected(_ selected: Bool, animated: Bool) {
        let executeSelection: () -> Void = { [weak self] in
            guard let self else {
                return
            }

            if let selectedBackgroundColor {
                if selected {
                    backgroundColor = selectedBackgroundColor
                    optionLabel.textColor = highlightTextColor
                } else {
                    backgroundColor = .clear
                    optionLabel.textColor = normalTextColor
                }
            }
        }

        if animated {
            UIView.animate(withDuration: 0.3, animations: {
                executeSelection()
            })
        } else {
            executeSelection()
        }

        accessibilityTraits = selected ? .selected : .none
    }
}
