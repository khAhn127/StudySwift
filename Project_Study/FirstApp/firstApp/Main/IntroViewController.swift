//
//  IntroViewController.swift
//  firstApp
//
//  Created by Quintet on 2021/06/21.
//

import UIKit
import AsyncDisplayKit

class IntroViewController: ViewController {

    lazy var titleNode : ASTextNode = {
        let node = ASTextNode()
        node.attributedText = .init(string: "사디타기 게임")
        node.textContainerInset = .init(top: 0, left: 40, bottom: 40, right: 40)
        node.backgroundColor = .init(hexString: "#e67ea3")
        
        return node
    }()
    
    lazy var stratNode : ASButtonNode = {
        let node = ASButtonNode()
        node.backgroundColor = .init(hexString: "#e67ea3")
        node.contentEdgeInsets = .init(top: 40, left: 40, bottom: 40, right: 40)
        node.setAttributedTitle(.init(string: "게임 시작"), for: .normal)
        node.addTarget(self, action: #selector(goMain), forControlEvents: .touchUpInside)
        return node
    }()
    
    
    override init(node: ASDisplayNode) {
        super.init(node: node)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
