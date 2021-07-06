//
//  GameViewController.swift
//  firstApp
//
//  Created by Quintet on 2021/06/22.
//

import Foundation
import UIKit
import AsyncDisplayKit

class GameViewController : ViewController {
    var playersCount = 1
    var winningCount = 1
    var isStart = false
    
    override init(node: ASDisplayNode) {
        super.init(node: node)
        node.layoutSpecBlock = { [weak self] (_,_) in
            guard let self = self else {
                return ASLayoutSpec()
            }
            return ASInsetLayoutSpec(
                insets: self.view.safeAreaInsets,
                child: 
                    (self.isStart == true ? GameNode() : ASDisplayNode().styled({
                        $0.width = .init(unit: .fraction, value: 1)
                        $0.height = .init(unit: .fraction, value: 1)
                    }).setBackgroundColor(color: UIColor.darkGray)))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
