//
//  CodedTableViewCell.swift
//  CodedUIApp
//
//  Created by Rohan Ramsay on 10/02/21.
//

import UIKit

class CodedTableViewCell: UITableViewCell, CodeInitializableView {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initSubviews()
        initConstraints()
    }
    
    open func initSubviews() {}
    open func initConstraints() {}
    open func updateConstraints(forNewTraitCollection traitCollection: UITraitCollection) {}

    @available(*, unavailable, message: "Use the custom initializer")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
