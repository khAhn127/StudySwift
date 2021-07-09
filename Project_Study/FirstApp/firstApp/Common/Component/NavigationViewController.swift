//
//  NavigationController.swift
//  firstApp
//
//  Created by Quintet on 2021/06/22.
//

import Foundation
import AsyncDisplayKit

class NavigationViewController: UINavigationController {
    
}
extension NavigationViewController {
    func transitionRootViewController(to target: UIViewController, transitionType: CATransitionType, transitionSubtype: CATransitionSubtype, completion: @escaping ()->() = {}) {
        // TODO: 메인 변경 처리 생각해보기
        guard
            let keyWindow = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate ?? nil,
//            let keyWindow = UIApplication.shared.delegate?.window ?? nil,
            type(of: keyWindow.window?.rootViewController) != type(of: target)
        else {
            return
        }

        CATransaction.flush()
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction.init(name: .easeInEaseOut)
        animation.type = transitionType
        animation.subtype = transitionSubtype
        animation.duration = 0.35

        let prevViewController = UIViewController()
        let prevView = keyWindow.window?.rootViewController?.view
        prevViewController.view = prevView?.snapshotView(afterScreenUpdates: false)
        let transitionWindow = UIWindow(frame: UIScreen.main.bounds)
        transitionWindow.rootViewController = prevViewController
        transitionWindow.makeKeyAndVisible()

        keyWindow.window?.layer.add(animation, forKey: "windowTransition")
        keyWindow.window?.rootViewController = target
        keyWindow.window?.makeKeyAndVisible()

        CATransaction.begin()
        CATransaction.setCompletionBlock {
            transitionWindow.removeFromSuperview()
            completion()
        }
        CATransaction.commit()
    }
}


