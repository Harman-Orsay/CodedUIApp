//
//  DetailsViewController.swift
//  CodedUIApp
//
//  Created by Rohan Ramsay on 10/02/21.
//

import UIKit

class DetailsViewController: CodedViewController {

    let item: ListItem
    weak var delegate: DetailsViewDelegate?
    
    init(item: ListItem, delegate: DetailsViewDelegate) {
        self.delegate = delegate
        self.item = item
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI(forTrait: traitCollection)
    }
    
    override func loadView() {
        view = DetailsView(item: item, delegate: self)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateUI(forTrait: traitCollection)
    }
    
    func updateUI(forTrait traitCollection: UITraitCollection) {
        (view as? DetailsView)?.updateCloseButton(hidden: traitCollection.horizontalSizeClass == .regular)
    }
}

extension DetailsViewController: CloseButtonDelegate {
    func tapped() {
        delegate?.viewClosed()
    }
}

protocol DetailsViewDelegate: class {
    func viewClosed()
}
