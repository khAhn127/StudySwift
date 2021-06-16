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
                         .foregroundColor : UIColor.white,
                         .paragraphStyle : paragraphStyle,
            ])
        node.borderColor = UIColor.black.cgColor
        node.borderWidth = 0.5
        return node
    }()
    
    lazy var inputNode : ASEditableTextNode = {
        let node = ASEditableTextNode()
        node.backgroundColor = UIColor.white
        node.borderColor = UIColor.black.cgColor
        node.borderWidth = 0.5
        return node
    }()
    
    override init() {
        super.init()
    }
    
}
