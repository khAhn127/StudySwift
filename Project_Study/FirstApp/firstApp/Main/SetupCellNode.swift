//
//  SetupCellNode.swift
//  firstApp
//
//  Created by Quintet on 2021/06/14.
//

import UIKit
import AsyncDisplayKit

class SetupCellNode: ASCellNode {

    lazy var titleNode : ASTextNode = {
        let node = ASTextNode()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        node.attributedText = NSAttributedString(
            string: "이름",
            attributes: [.font: UIFont.boldSystemFont(ofSize: 12),
                         .foregroundColor : UIColor.black,
                         .paragraphStyle : paragraphStyle,
            ])
        node.borderColor = UIColor.red.cgColor
        node.borderWidth = 0.5
        return node
    }()
    
    lazy var inputNode : ASEditableTextNode = {
        let node = ASEditableTextNode()
        node.backgroundColor = UIColor.white
        node.borderColor = UIColor.blue.cgColor
        node.borderWidth = 0.5
        return node
    }()
    
    override init() {
        super.init()
        self.automaticallyManagesSubnodes = true
        self.automaticallyRelayoutOnLayoutMarginsChanges = true
        self.automaticallyRelayoutOnSafeAreaChanges = true
        self.style.width = .init(unit: .fraction, value: 1)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(
            insets: .zero,
            child: ASStackLayoutSpec(
                direction: .horizontal,
                spacing: 0,
                justifyContent: .spaceBetween,
                alignItems: .stretch,
                children: [
                    titleNode.styled({
                        $0.width = .init(unit: .fraction, value: 0.5)
                        $0.height = .init(unit: .points, value: 20)
                    }),
                    inputNode.styled({
                        $0.width = .init(unit: .fraction, value: 0.5)
                        $0.height = .init(unit: .points, value: 20)
                    }),
                ]
            )
        )
    }
    
}
