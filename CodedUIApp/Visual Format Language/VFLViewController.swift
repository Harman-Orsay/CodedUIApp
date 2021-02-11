//
//  ViewController.swift
//  CodedUIApp
//
//  Created by Rohan Ramsay on 9/02/21.
//

import UIKit

class VFLViewController: CodedViewController {

    override func loadView() {
        view = VFLView(viewModel: UIColor.black)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        (view as? VFLView)?.updateConstraints(forNewTraitCollection: traitCollection)
    }
}
