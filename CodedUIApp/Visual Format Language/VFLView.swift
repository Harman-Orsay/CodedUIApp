//
//  MasterListView.swift
//  CodedUIApp
//
//  Created by Rohan Ramsay on 9/02/21.
//

import UIKit

class VFLView: CodedView {

    let viewModel: Any
    
    init(viewModel: Any) {
        self.viewModel = viewModel
        super.init()
        self.backgroundColor = .white
    }
        
    override func initSubviews() {
        addSubview(view1)
        addSubview(view2)
        addSubview(view3)
        addSubview(view4)

        view1.addSubview(label1)
        view2.addSubview(label2)
        view3.addSubview(label3)
        view4.addSubview(label4)
        
        view1.translatesAutoresizingMaskIntoConstraints = false
        view2.translatesAutoresizingMaskIntoConstraints = false
        view3.translatesAutoresizingMaskIntoConstraints = false
        view4.translatesAutoresizingMaskIntoConstraints = false
        
        label1.translatesAutoresizingMaskIntoConstraints = false
        label2.translatesAutoresizingMaskIntoConstraints = false
        label3.translatesAutoresizingMaskIntoConstraints = false
        label4.translatesAutoresizingMaskIntoConstraints = false
    }
    
    //MARK: - Constraints
    
    override func initConstraints() {
        let label1row = "|-[label1]-|"
        let label1Column = "V:|-[label1]-|"
        let label2row = "|-[label2]-|"
        let label2Column = "V:|-[label2]-|"
        let label3row = "|-[label3]-|"
        let label3Column = "V:|-[label3]-|"
        let label4row = "|-[label4]-|"
        let label4Column = "V:|-[label4]-|"
        let labels = ["label1" : label1, "label2" : label2, "label3" : label3, "label4" : label4]
        let c1 = NSLayoutConstraint.constraints(withVisualFormat: label1row, options: [], metrics: nil, views: labels)
        let c2 = NSLayoutConstraint.constraints(withVisualFormat: label2row, options: [], metrics: nil, views: labels)
        let c3 = NSLayoutConstraint.constraints(withVisualFormat: label3row, options: [], metrics: nil, views: labels)
        let c4 = NSLayoutConstraint.constraints(withVisualFormat: label4row, options: [], metrics: nil, views: labels)
        let c5 = NSLayoutConstraint.constraints(withVisualFormat: label1Column, options: [], metrics: nil, views: labels)
        let c6 = NSLayoutConstraint.constraints(withVisualFormat: label2Column, options: [], metrics: nil, views: labels)
        let c7 = NSLayoutConstraint.constraints(withVisualFormat: label3Column, options: [], metrics: nil, views: labels)
        let c8 = NSLayoutConstraint.constraints(withVisualFormat: label4Column, options: [], metrics: nil, views: labels)
        NSLayoutConstraint.activate(c1 + c2 + c3 + c4 + c5 + c6 + c7 + c8)
        
       updateUI(forTrait: traitCollection)
    }
    
    override func updateConstraints(forNewTraitCollection traitCollection: UITraitCollection) {
        updateUI(forTrait: traitCollection)
    }
    
    lazy var compactWidthConstraints: [NSLayoutConstraint] = {
        let row1 = "|-[view1(==view2)]-[view2]-|"
        let column1 = "V:|-[view1(==view3)]-[view3]-|"
        let column2 = "V:|-[view2(==view4)]-[view4]-|"
        
        let row1Constraints = NSLayoutConstraint.constraints(withVisualFormat: row1, options: [.alignAllTop, .alignAllBottom], metrics: nil, views: subviewIds)
        let column1Constraints = NSLayoutConstraint.constraints(withVisualFormat: column1, options: [.alignAllLeft, .alignAllRight], metrics: nil, views: subviewIds)
        let column2Constraints = NSLayoutConstraint.constraints(withVisualFormat: column2, options: [.alignAllLeft, .alignAllRight], metrics: nil, views: subviewIds)
        return row1Constraints + column1Constraints + column2Constraints
    }()
    
    lazy var regularWidthConstraints: [NSLayoutConstraint] = {
        let row1 = "|-[view1(==view2,==view4)]-[view2]-[view4]-|"
        let column1 = "V:|-[view1(==view3)]-[view3]-|"
        let column2 = "V:|-[view2]-|"
        let column3 = "V:|-[view4]-|"
        
        let row1Constraints = NSLayoutConstraint.constraints(withVisualFormat: row1, options: .alignAllTop, metrics: nil, views: subviewIds)
        let column1Constraints = NSLayoutConstraint.constraints(withVisualFormat: column1, options: [.alignAllLeft, .alignAllRight], metrics: nil, views: subviewIds)
        let column2Constraints = NSLayoutConstraint.constraints(withVisualFormat: column2, options: [], metrics: nil, views: subviewIds)
        let column3Constraints = NSLayoutConstraint.constraints(withVisualFormat: column3, options: [], metrics: nil, views: subviewIds)
        return row1Constraints + column1Constraints + column2Constraints + column3Constraints
    }()
    
    func updateUI(forTrait traitCollection: UITraitCollection) {
        switch traitCollection.horizontalSizeClass {
        case .compact, .unspecified:
            NSLayoutConstraint.deactivate(regularWidthConstraints)
            NSLayoutConstraint.activate(compactWidthConstraints)
        case .regular: fallthrough
        @unknown default:
            NSLayoutConstraint.deactivate(compactWidthConstraints)
            NSLayoutConstraint.activate(regularWidthConstraints)
        }
    }
    
    //MARK: - Subviews
    
    lazy var subviewIds = ["view1": view1,
                           "view2": view2,
                           "view3" : view3,
                           "view4" : view4,
                           "label1" : label1,
                           "label2" : label2,
                           "label3" : label3,
                           "label4" : label4]
    
    private let view1: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    private let label1: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.textAlignment = .center
        return label
    }()
    
    private let view2: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    private let label2: UILabel = {
        let label = UILabel()
        label.text = "2"
        label.textAlignment = .center
        return label
    }()
    
    private let view3: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()
    
    private let label3: UILabel = {
        let label = UILabel()
        label.text = "3"
        label.textAlignment = .center
        return label
    }()
    
    private let view4: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    private let label4: UILabel = {
        let label = UILabel()
        label.text = "4"
        label.textAlignment = .center
        return label
    }()
}
