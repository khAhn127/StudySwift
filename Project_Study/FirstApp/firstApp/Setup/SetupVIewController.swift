//
//  SetupVIewController.swift
//  firstApp
//
//  Created by Quintet on 2021/06/22.
//

import Foundation
import UIKit
import AsyncDisplayKit

class SetupViewController : ViewController {
    
    lazy var titleNode : ASDisplayNode = {
        let node = ASDisplayNode()
        let textNode = ASTextNode()
        node.automaticallyManagesSubnodes = true
        node.automaticallyRelayoutOnSafeAreaChanges = true
        node.automaticallyRelayoutOnLayoutMarginsChanges = true
        node.backgroundColor = UIColor.white
       
        textNode.attributedText = .init(string: "게임설정")
        node.layoutSpecBlock = { [weak self] (_,_) in
            guard let self = self else {
                return ASLayoutSpec()
            }
            return ASInsetLayoutSpec(
                insets: .init(top: 10, left: 0, bottom: 0, right: 0),
                child: ASStackLayoutSpec(
                    direction: .horizontal,
                    spacing: 0,
                    justifyContent: .center,
                    alignItems: .stretch,
                    children: [
                        textNode,
                    ])
                )
        }
        return node
    }()
    
    lazy var contentsNode : ASDisplayNode = {
        let node = ASDisplayNode()
        node.automaticallyManagesSubnodes = true
        node.automaticallyRelayoutOnSafeAreaChanges = true
        node.automaticallyRelayoutOnLayoutMarginsChanges = true
        node.backgroundColor = UIColor.white
        node.layoutSpecBlock = { [weak self] (_,_) in
            guard let self = self else { return ASLayoutSpec() }
            return ASInsetLayoutSpec(
                insets: .init(top: 10, left: 10, bottom: 10, right: 10),
                child: PlayerNode().setBackgroundColor(color:.init(hexString: "#e67ea3") )
            )
        }
        return node
    }()
    
    override init(node: ASDisplayNode) {
        super.init(node: node)

        node.layoutSpecBlock = { [weak self] (_,_) in
            guard let self = self else {
                return ASLayoutSpec()
            }
            return ASInsetLayoutSpec(
                insets: self.view.safeAreaInsets,
                child: ASStackLayoutSpec(
                    direction: .vertical,
                    spacing: 0,
                    justifyContent: .center,
                    alignItems: .stretch,
                    children: [
                        self.titleNode.styled({
                            $0.width  = .init(unit: .fraction,value: 1)
                            $0.height = .init(unit: .points, value: 30)
                        }),
                        ASDisplayNode().styled({
                            $0.width = .init(unit: .fraction, value: 1)
                            $0.height = .init(unit: .points, value: 8)
                        }).setBackgroundColor(color: UIColor.black),
                        self.contentsNode.styled({
                            $0.width = .init(unit: .fraction, value: 1)
                            $0.height = .init(unit: .fraction, value: 1)
                        }),
                        
                ])
            )
        }
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white
    }
}
