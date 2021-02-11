//
//  CodedView.swift
//  CodedUIApp
//
//  Created by Rohan Ramsay on 10/02/21.
//

import UIKit

class CodedView: UIView, CodeInitializableView {
    
    public init() {
        super.init(frame: CGRect.zero)
        initSubviews()
        initConstraints()
    }
    
    @available(*, unavailable, message: "Use the custom inititilizer")
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Loading this view from a nib is unsupported in favor of initializer dependency injection.")
    }
    
    //MARK: - Metohds for subclass to override
    
    open func initSubviews() {}
    open func initConstraints() {}
    open func updateConstraints(forNewTraitCollection traitCollection: UITraitCollection) {}
    //instead of overriding traitCollectionDidChange - let superview / ViewController (more reliable) call it when needed
}

public protocol CodeInitializableView {
    func initSubviews()
    func initConstraints()
    func updateConstraints(forNewTraitCollection traitCollection: UITraitCollection)
}
