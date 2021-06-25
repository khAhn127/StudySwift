//
//  PlayerNode.swift
//  firstApp
//
//  Created by Quintet on 2021/06/22.
//

import Foundation
import AsyncDisplayKit
import UIKit

class PlayerNode : ASDisplayNode {
    
    lazy var headerNode : ASStackLayoutSpec = {
        let titleNode = ASTextNode()
        titleNode.textContainerInset = .init(top: 0, left: 10, bottom: 0, right: 10)
        titleNode.attributedText = .init(string: "인원수")
        
        let inputNode = ASEditableTextNode()
        inputNode.textContainerInset = .init(top: 0, left: 10, bottom: 0, right: 10)
        inputNode.backgroundColor = UIColor.white
        
       return ASStackLayoutSpec(
        direction: .horizontal,
        spacing: 0,
        justifyContent: .spaceBetween,
        alignItems: .stretch,
        children: [
            titleNode.styled({
                $0.width = .init(unit: .points, value: 60)
                $0.height = .init(unit: .fraction, value: 1)
            }),
            inputNode.styled({
                $0.width = .init(unit: .fraction, value: 1)
                $0.height = .init(unit: .fraction, value:1)
            }),
        ]).styled({
            $0.width = .init(unit: .fraction, value: 1)
            $0.height = .init(unit: .points, value: 20)
        })
    }()
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(
            insets: .zero,
            child: ASStackLayoutSpec(
                direction: .vertical,
                spacing: 0,
                justifyContent: .center,
                alignItems: .start,
                children: [
                    headerNode,
                ])
        )
    }
    
    override init() {
        super.init()
        self.automaticallyManagesSubnodes = true
        self.automaticallyRelayoutOnSafeAreaChanges = true
        self.automaticallyRelayoutOnLayoutMarginsChanges = true
    }
    

}
