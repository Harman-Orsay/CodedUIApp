//
//  ListTableViewCell.swift
//  CodedUIApp
//
//  Created by Rohan Ramsay on 10/02/21.
//

import UIKit

class ListTableViewCell: CodedTableViewCell {
    
    fileprivate(set) var item: ListItem! {
        didSet {
            updateCell(for: item)
        }
    }
    
    override func initSubviews() {
        addSubview(headerLabel)
        addSubview(subheaderLabel)
        addSubview(iconImageView)
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        subheaderLabel.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        headerLabel.setContentCompressionResistancePriority(.defaultHigh + 1, for: .vertical)
        subheaderLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
    }
    
    override func initConstraints() {
        NSLayoutConstraint.activate([
                                        iconImageView.widthAnchor.constraint(equalToConstant: Self.iconHeight),
        iconImageView.heightAnchor.constraint(equalTo: iconImageView.widthAnchor, multiplier: 1),
                                        iconImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: Self.padding),
                                        iconImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Self.padding),
        
        headerLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor, constant: 0),
                                        headerLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: Self.padding),
                                        headerLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: Self.padding),
        
        subheaderLabel.leadingAnchor.constraint(equalTo: iconImageView.leadingAnchor),
        subheaderLabel.trailingAnchor.constraint(equalTo: headerLabel.trailingAnchor),
                                        subheaderLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: Self.padding),
                                        subheaderLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -Self.padding)])
    }
    
    func updateCell(for item: ListItem) {
        headerLabel.text = item.header
        subheaderLabel.text = item.subheader
        iconImageView.backgroundColor = item.iconColor
    }
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.minimumScaleFactor = 0.5
        label.lineBreakMode = .byClipping
        label.textAlignment = .left
        return label
    }()
    
    private let subheaderLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()
    
    static let iconHeight: CGFloat = 38
    static let padding: CGFloat = 12
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = ListTableViewCell.iconHeight / 2
        imageView.layer.masksToBounds = true
        return imageView
    }()
}

extension UITableView {
    func dequeueListTableViewCell(forItem item: ListItem, withReuseidentifier identifier: String, for indexPath: IndexPath ) -> ListTableViewCell {
        let listCell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ListTableViewCell
        listCell.item = item
        return listCell
    }
}
