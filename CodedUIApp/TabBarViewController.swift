//
//  TabBarViewController.swift
//  CodedUIApp
//
//  Created by Rohan Ramsay on 9/02/21.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstViewController = ListViewController(list: ListItem.list)
        firstViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 0)

        let secondViewController = VFLViewController()
        secondViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)

        viewControllers = [firstViewController, secondViewController]
    }
}
