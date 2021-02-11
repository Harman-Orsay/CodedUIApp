//
//  CodedViewController.swift
//  CodedUIApp
//
//  Created by Rohan Ramsay on 10/02/21.
//

import UIKit

class CodedViewController: UIViewController {
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable, message: "Use custom initializer")
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    @available(*, unavailable, message: "Use custom initializer")
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Loading this view controller from a nib is unsupported in favor of initializer dependency injection.")
    }
}
