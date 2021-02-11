//
//  DetailsView.swift
//  CodedUIApp
//
//  Created by Rohan Ramsay on 10/02/21.
//

import UIKit

class DetailsView: CodedView {

    let item: ListItem
    weak var delegate: CloseButtonDelegate?
    
    init(item: ListItem, delegate: CloseButtonDelegate) {
        self.item = item
        self.delegate = delegate
        super.init()
        loadData()
    }
    
    func loadData() {
        headerLabel.text = item.header
        subheaderLabel.text = item.subheader
        detailsLabel.text = item.details
        iconImageView.backgroundColor = item.iconColor
    }
    
    func updateCloseButton(hidden: Bool) {
        closeButton.isHidden = hidden
    }
    
    @objc
    func closeButtonTapped() {
        delegate?.tapped()
    }
   
    override func initSubviews() {
        addSubview(closeButton)
        addSubview(headerLabel)
        scrollView.addSubview(stackView)
        addSubview(scrollView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let padding: CGFloat = 12
    override func initConstraints() {
        NSLayoutConstraint(item: closeButton, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leadingMargin, multiplier: 1.0, constant: padding).isActive = true
        NSLayoutConstraint(item: closeButton, attribute: .top, relatedBy: .equal, toItem: self, attribute: .topMargin, multiplier: 1.0, constant: padding).isActive = true
        NSLayoutConstraint(item: closeButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0.0, constant: 42).isActive = true
        NSLayoutConstraint(item: closeButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0.0, constant: 42.0).isActive = true

        NSLayoutConstraint(item: headerLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leadingMargin, multiplier: 1.0, constant: 8.0).isActive = true
        NSLayoutConstraint(item: headerLabel, attribute: .top, relatedBy: .equal, toItem: closeButton, attribute: .bottom, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: headerLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1.0, constant: -padding).isActive = true
        
        NSLayoutConstraint(item: iconImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0.0, constant: 100).isActive = true
        NSLayoutConstraint(item: iconImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0.0, constant: 100).isActive = true

        NSLayoutConstraint(item: detailsLabel, attribute: .width, relatedBy: .equal, toItem: scrollView, attribute: .width, multiplier: 1.0, constant: -padding).isActive = true

        NSLayoutConstraint(item: scrollView, attribute: .top, relatedBy: .equal, toItem: headerLabel, attribute: .bottom, multiplier: 1.0, constant: padding).isActive = true
        NSLayoutConstraint(item: scrollView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottomMargin, multiplier: 1.0, constant: -padding).isActive = true
        NSLayoutConstraint(item: scrollView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leadingMargin, multiplier: 1.0, constant: padding).isActive = true
        NSLayoutConstraint(item: scrollView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1.0, constant: -padding).isActive = true

        NSLayoutConstraint(item: stackView, attribute: .top, relatedBy: .equal, toItem: scrollView, attribute: .top, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: stackView, attribute: .bottom, relatedBy: .equal, toItem: scrollView, attribute: .bottom, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: stackView, attribute: .leading, relatedBy: .equal, toItem: scrollView, attribute: .leading, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: stackView, attribute: .trailing, relatedBy: .equal, toItem: scrollView, attribute: .trailing, multiplier: 1.0, constant: 0.0).isActive = true
    }
    
    //MARK: - Subviews
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 32)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let subheaderLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .darkGray
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let detailsLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .lightGray
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private let closeButton: UIButton = {
        let button = UIButton(type: .close)
        button.addTarget(self, action: #selector(DetailsView.closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let scrollView: UIScrollView = UIScrollView()

    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        return imageView
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [iconImageView,
                                                   subheaderLabel,
                                                   detailsLabel])
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 10
        return stack
    }()
}

protocol CloseButtonDelegate: class {
    func tapped()
}
