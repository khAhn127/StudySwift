//
//  MainViewController.swift
//  firstApp
//
//  Created by Quintet on 2021/06/22.
//

import UIKit
import Foundation

enum MainTab: CaseIterable {
    case setup
    case game
    
    var title: String {
        switch self {
        case .setup:
            return "설정"
        case .game:
            return "게임"
        }
    }
    var images: (normal: UIImage, selected: UIImage) {
        switch self {
        case .setup:
            return (UIImage(),UIImage())
        case .game:
            return (UIImage(),UIImage())
        }
    }
    var viewController: UIViewController {
        switch self {
        case .setup:
            return SetupViewController()
        case .game:
            return GameViewController()
        }
    }
    var tabBarItem : UITabBarItem {
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

class MainTabBarController: UITabBarController {
    var tabs: [UIViewController]? = {
        var viewControllers :[UIViewController] = []
        for navController in MainTab.allCases {
            viewControllers.append(navController.configured)
        }
        return viewControllers
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MainViewLoad")
        setViewControllers(tabs, animated: true)
        self.delegate = self
    }
    //comment 여러번 초기화 되는 함수
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

}

extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController is GameViewController? {
            guard
                GameConfigure.shared.playerCount >= 2,
                GameConfigure.shared.winnerCount >= 1,
                GameConfigure.shared.playerCount != GameConfigure.shared.winnerCount
            else {
                let alert = UIAlertController(title: "경고", message: "아직 생성 되지 않았습니다.\n 설정 탭으로 이동해주세요.", preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "확인", style: .default)
                alert.addAction(okAction)
                present(alert, animated: false, completion: nil)
                return false
            }
        }
        return true
    }
}
