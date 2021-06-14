//
//  IntroViewController.swift
//  firstApp
//
//  Created by Quintet on 2021/06/11.
//

import Foundation
import AsyncDisplayKit

class IntroViewController: UINavigationController {
    var viewController : ViewController = ViewController()
    
    lazy var startButton : ASButtonNode = {
        let node = ASButtonNode()
        node.backgroundColor = UIColor.systemPink
        node.contentEdgeInsets = .init(top: 40, left: 40, bottom: 40, right: 40)
        node.setAttributedTitle(.init(string: "게임 시작"), for: .normal)
        node.addTarget(self, action: #selector(goSetup), forControlEvents: .touchUpInside)
        return node
    }()
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.pushViewController(self.viewController, animated: true)
        self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.viewController.view.backgroundColor = UIColor.white
        self.isToolbarHidden = true
        
        self.viewController.node.layoutSpecBlock = { [weak self] (_,_)  in
            guard let self = self else { return ASLayoutSpec() }
            
            return ASStackLayoutSpec(
                direction: .vertical,
                spacing: .zero,
                justifyContent: .center,
                alignItems: .center,
                children: [
                    self.startButton,
//                    ASInsetLayoutSpec(
//                        insets: .init(top: 20, left: 20, bottom: 20, right: 20),
//                        child: self.startButton
//                    ),
                ]
            )
        }
    }

}

extension IntroViewController {
    @objc func goSetup() {
        DispatchQueue.main.async {
            self.pushViewController(SetupViewController(), animated: true)
        }
    }
}

