//
//  GameNode.swift
//  firstApp
//
//  Created by Quintet on 2021/06/22.
//

import Foundation
import UIKit
import AsyncDisplayKit

class GameNode :ASDisplayNode {
    
    lazy var drawNode :ASDisplayNode = {
        let node = ASDisplayNode{ return DrawView(frame: self.view.frame)
        }
        node.backgroundColor = .init(hexString: "#8c79b4")
        return node
    }()

    
    override init() {
        super.init()
        self.automaticallyManagesSubnodes = true
        self.automaticallyRelayoutOnSafeAreaChanges = true
        self.automaticallyRelayoutOnLayoutMarginsChanges = true
        self.backgroundColor = .init(hexString: "#e67ea3")
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(
            insets: .init(top: 10, left: 10, bottom: 10, right: 10),
            child: self.drawNode
        )
    }

}

class DrawView : UIView{
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
//        context.setLineWidth(4.0)
//        context.setStrokeColor(UIColor.black.cgColor)
//        context.move(to: CGPoint(x: 10, y: 10))
//        context.addLine(to: CGPoint(x: 10, y: self.bounds.height-10))
//        context.strokePath()
//
//
//        context.setStrokeColor(UIColor.blue.cgColor)
//        context.move(to: CGPoint(x: 50, y: 10))
//        context.addLine(to: CGPoint(x: 50, y: self.bounds.height-10))
//        context.strokePath()
        var vertical:CGFloat = 0
        
        for _ in 1...9{
            vertical = vertical + ((self.bounds.width-10)/10)
            context.setStrokeColor(UIColor.black.cgColor)
            context.move(to: CGPoint(x: vertical, y: 10))
            context.addLine(to: CGPoint(x: vertical, y: ((self.bounds.height-10)/10)))
            context.strokePath()
            
            var horizontal:CGFloat = 0
            for _ in 1...9{
                if Bool.random(){
                    context.setStrokeColor(UIColor.yellow.cgColor)
                    horizontal = horizontal + ((self.bounds.height-10)/10)
                    context.move(to: CGPoint(x: vertical, y: horizontal))
                    context.addLine(to: CGPoint(x: 50, y: horizontal))
                    context.strokePath()
                }
            }
        }
    }
}
