//
//  GameViewController.swift
//  firstApp
//
//  Created by Quintet on 2021/06/22.
//

import Foundation
import UIKit
import AsyncDisplayKit

class GameViewController: ViewController {
    var playersCount: Int = 1
    var winningCount: Int = 1
    var isStart = false

    var gameNode = GameNode()
        .styled({
            $0.width = .init(unit: .fraction, value: 1)
            $0.height = .init(unit: .fraction, value: 1)
        })
    let emptyNode = ASDisplayNode()
        .styled({
            $0.width = .init(unit: .fraction, value: 1)
            $0.height = .init(unit: .fraction, value: 1)
        }).setBackgroundColor(color: UIColor.darkGray)
    
    override init(node: ASDisplayNode) {
        super.init(node: node)
        node.layoutSpecBlock = { [weak self] (_,_) in
            guard let self = self else { return ASLayoutSpec() }
          
            return ASInsetLayoutSpec(
                insets: self.view.safeAreaInsets,
                child: ASStackLayoutSpec(
                    direction: .vertical,
                    spacing: 0,
                    justifyContent: .center,
                    alignItems: .stretch,
                    children: [
                        self.isStart ? GameNode().styled({
                            $0.width = .init(unit: .fraction, value: 1)
                            $0.height = .init(unit: .fraction, value: 1)
                        })
                        : self.emptyNode,
                    ]
                )
            )
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
