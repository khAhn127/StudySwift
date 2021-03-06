//
//  IntroViewController.swift
//  firstApp
//
//  Created by Quintet on 2021/06/21.
//

import UIKit
import AsyncDisplayKit

class IntroViewController: ViewController {

    var titleNode: ASTextNode = {
        let node = ASTextNode()
        node.attributedText = .init(string: "사디타기 게임")
        node.textContainerInset = .init(top: 10, left: 40, bottom: 10, right: 40)
        node.backgroundColor = UIColor.white
        return node
    }()
    
    lazy var stratNode: ASButtonNode = {
        let node = ASButtonNode()
        node.backgroundColor = .init(hexString: "#e67ea3")
        node.contentEdgeInsets = .init(top: 40, left: 40, bottom: 40, right: 40)
        node.setAttributedTitle(.init(string: "게임 시작"), for: .normal)
        node.addTarget(self, action: #selector(goMain(_:)), forControlEvents: .touchUpInside)
        return node
    }()
    
    override init(node: ASDisplayNode) {
        super.init(node: node)
        self.node.layoutSpecBlock = { [weak self] (_,_)  in
            guard let self = self else { return ASLayoutSpec() }
            return ASStackLayoutSpec(
                direction: .vertical,
                spacing: 20,
                justifyContent: .center,
                alignItems: .center,
                children: [
                    self.titleNode,
                    self.stratNode,
                ])
            }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @objc func goMain(_ sender: ASButtonNode) {
        NavigationViewController.transitionRootViewController(to:MainTabBarController(), transitionType: .push, transitionSubtype: .fromRight)
    }

}
