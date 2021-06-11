//
//  IntroViewController.swift
//  firstApp
//
//  Created by Quintet on 2021/06/11.
//

import Foundation
import AsyncDisplayKit

class IntroViewController: ViewController {
    lazy var startButton : ASButtonNode = {
        let node = ASButtonNode()
        node.backgroundColor = UIColor.systemPink
        node.contentEdgeInsets = .init(top: 40, left: 40, bottom: 40, right: 40)
        node.setAttributedTitle(.init(string: "게임 시작"), for: .normal)
        node.addTarget(self, action: #selector(goSetup), forControlEvents: .touchUpInside)
        return node
    }()
    
    override init(node : ASDisplayNode) {
        super.init(node : node)
        self.node.layoutSpecBlock = { [weak self] (_,_)  in
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
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension IntroViewController {
    @objc func goSetup() {
        DispatchQueue.main.async {
            let view = SetupViewController()
           
        }
    }
}

