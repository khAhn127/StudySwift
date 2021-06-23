//
//  MainViewController.swift
//  firstApp
//
//  Created by Quintet on 2021/06/22.
//

import UIKit
import Foundation



class MainTabBarController : UITabBarController
{
    override func viewDidLoad() {
        print("MainViewLoad")
        
        self.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create Tab one
        let tabOne = SetupViewController()
        let tabOneBarItem = UITabBarItem(title: "Tab 1", image: UIImage(named: "defaultImage.png"), selectedImage: UIImage(named: "selectedImage.png"))
        tabOne.tabBarItem = tabOneBarItem
        self.viewControllers = [tabOne, ]
    }
}

extension MainTabBarController : UITabBarControllerDelegate
{
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
         print("Selected \(viewController.title!)")
     }
}
