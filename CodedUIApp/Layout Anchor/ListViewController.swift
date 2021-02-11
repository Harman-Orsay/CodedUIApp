//
//  MasterLIstViewController.swift
//  CodedUIApp
//
//  Created by Rohan Ramsay on 9/02/21.
//

import UIKit

class ListViewController: CodedViewController {

    private let list: [ListItem]
    private var regularWidthConstraints: [NSLayoutConstraint] = []
    private var compactWidthConstraints: [NSLayoutConstraint] = []
    private var commonConstraints: [NSLayoutConstraint] = []

    init(list: [ListItem]) {
        self.list = list
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        updateUI(forTrait: traitCollection)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateUI(forTrait: traitCollection)
    }
    
    func setupUI() {
        leftView.addSubview(tableView)
        leftView.addSubview(titleLabel)
        view.addSubview(rightView)
        view.addSubview(leftView)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        leftView.translatesAutoresizingMaskIntoConstraints = false
        rightView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupConstraints() {
        commonConstraints.append(contentsOf: [
            leftView.topAnchor.constraint(equalTo: view.topAnchor),
            leftView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            leftView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 64),
            titleLabel.leadingAnchor.constraint(equalTo: leftView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: leftView.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leftView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: leftView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            rightView.topAnchor.constraint(equalTo: view.topAnchor),
            rightView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            rightView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        regularWidthConstraints.append(contentsOf: [
            rightView.leadingAnchor.constraint(equalTo: leftView.trailingAnchor),
            leftView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 2/5)
        ])
        
        compactWidthConstraints.append(contentsOf: [
            rightView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            leftView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            leftView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1)
        ])
        
        NSLayoutConstraint.activate(commonConstraints)
    }
    
    func containViaConstraints(childView: UIView, to parentView: UIView) {
        NSLayoutConstraint.activate([
            childView.topAnchor.constraint(equalTo: parentView.topAnchor),
            childView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor),
            childView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
            childView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor)
        ])
    }
    
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

    var detailsVC: DetailsViewController?
    func showDetails(item: ListItem) {
        if detailsVC != nil {
            hideDetails()
        }
        
        view.bringSubviewToFront(rightView)
        let childVC = DetailsViewController(item: item, delegate: self)
        addChild(childVC)
        childVC.view.translatesAutoresizingMaskIntoConstraints = false
        rightView.addSubview(childVC.view)
        containViaConstraints(childView: childVC.view, to: rightView)
        childVC.didMove(toParent: self)
        self.detailsVC = childVC
    }
    
    func hideDetails() {
        defer {view.bringSubviewToFront(leftView)}

        guard let childVC = detailsVC else {return}
        childVC.view.removeFromSuperview()
        childVC.removeFromParent()
        detailsVC = nil
    }
    
    //MARK: - Subviews
    
    lazy private var leftView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    lazy private var rightView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 32)
        label.textAlignment = .center
        label.backgroundColor = .white
        label.text = "List"
        return label
    }()
    
    let cellId = "ListCellID"
    lazy private var tableView: UITableView = {
       let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 64
        return tableView
    }()
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueListTableViewCell(forItem: list[indexPath.row],
                                           withReuseidentifier: cellId,
                                           for: indexPath)
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showDetails(item: list[indexPath.row])
    }
}

extension ListViewController: DetailsViewDelegate {
    func viewClosed() {
        hideDetails()
    }
}
