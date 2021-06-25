//
//  MainViewController.swift
//  firstApp
//
//  Created by Quintet on 2021/06/22.
//

import UIKit
import Foundation

enum MainTab : Int, CaseIterable{
    case setup
    case game
    
    var title :String{
        switch self {
        case .setup :
            return "설정"
        case .game :
            return "게임"
        }
    }
    
    var images : (normal: UIImage,selected: UIImage){
        switch self {
        case .setup:
            return (UIImage(),UIImage())
        case .game:
            return (UIImage(),UIImage())
        }
    }
    
    var viewController : UIViewController
    {
        switch self {
        case .setup:
            return SetupViewController()
        case .game:
            return GameViewController()
        }
    }
    var tabBarItem : UITabBarItem
    {
        let tabBarItem = UITabBarItem()
        tabBarItem.title = self.title
        tabBarItem.image = self.images.normal
        tabBarItem.selectedImage = self.images.selected
        switch self {
        case .setup:
            fallthrough
        case .game:
            return tabBarItem
        }
    }
    var configured: UIViewController {
        let viewController = self.viewController
        viewController.title = self.title
        viewController.hidesBottomBarWhenPushed = false
        viewController.tabBarItem = self.tabBarItem
        return viewController
    }
    
    
}

class MainTabBarController : UITabBarController
{
    lazy var tabs: [UIViewController]? = {
        var viewControllers :[UIViewController] = []
        for navController in MainTab.allCases {
            viewControllers.append(navController.configured)
        }
        return viewControllers
    }()
    
    override func viewDidLoad() {
        print("MainViewLoad")
        
        self.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setViewControllers(tabs, animated: true)
    }

}

extension MainTabBarController : UITabBarControllerDelegate
{
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected \(viewController.title!)")
        print("Selected is RootViewController :\(String(describing: (UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate).window?.rootViewController))")
     }
}
