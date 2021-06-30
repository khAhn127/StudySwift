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
    override init(node: ASDisplayNode) {
        super.init(node: node)
        node.layoutSpecBlock = { [weak self] (_,_) in
            guard let self = self else {
                return ASLayoutSpec()
            }
            return ASInsetLayoutSpec(
                insets: self.view.safeAreaInsets,
                child: GameNode()
            )
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
