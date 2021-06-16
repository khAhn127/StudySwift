//
//  SetupViewController.swift
//  firstApp
//
//  Created by Quintet on 2021/06/11.
//

import UIKit
import AsyncDisplayKit

class SetupViewController: ViewController {
    lazy var headerNode : ASDisplayNode = {
        let node = ASDisplayNode()
        let bgNode = ASDisplayNode()
        let titleNode = ASTextNode()
        bgNode.backgroundColor = .init(hexString: "#e67ea3")
        
        titleNode.textContainerInset = .init(top: 20, left: 20, bottom: 20, right: 20)
        titleNode.attributedText = NSAttributedString(
            string: "게임설명",
            attributes: [.font: UIFont.boldSystemFont(ofSize: 12),
                         .foregroundColor : UIColor.white,
            ])
        node.automaticallyManagesSubnodes = true
        node.automaticallyRelayoutOnSafeAreaChanges = true
        node.layoutSpecBlock = { [weak self] (_, _) in
            guard let self = self else { return ASLayoutSpec() }
            return ASBackgroundLayoutSpec(
                child : ASCenterLayoutSpec(
                    centeringOptions: .XY,
                    sizingOptions: .minimumXY,
                    child: titleNode),
                background : bgNode.styled({
                    $0.flexShrink = 1.0
                    $0.flexGrow = 1.0
                    $0.height = .init(unit: .points,value: 20)
                })
            )
        }
        return node
    }()
    
    lazy var titleNode : ASTextNode = {
        let node = ASTextNode()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        node.attributedText = NSAttributedString(
            string: "인원수",
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
    
        // TODO: textNode에서 ASDisplayNode를 textField로 안에 넣고 감싸고 난 후 node 반환 처리
        return node
    }()
    
    lazy var footerNode : ASButtonNode = {
        let node = ASButtonNode()
        node.backgroundColor = UIColor.yellow
        node.style.height = .init(unit: .points, value: 20)
        node.setTitle("시작", with: nil, with: .blue, for: .normal)
        node.borderWidth = 1
        return node
    }()
    
    lazy var collectionNode : CollectionNode<PersonModel,SetupCellNode> = {
        let node = CollectionNode<PersonModel,SetupCellNode>()
        
        return node
    }()
    
    lazy var contentsNode : ASDisplayNode = {
        let node = ASDisplayNode()
        
        var headerLayoutSpec : ASLayoutSpec = {
            return ASStackLayoutSpec(
                direction: .horizontal,
                spacing: 0,
                justifyContent: .spaceBetween,
                alignItems: .stretch,
                children: [
                    self.titleNode.styled {
                        $0.flexGrow = 0.5
                        $0.flexShrink = 0.5
                        $0.height = .init(unit: .points, value: 20)
                    },
                    self.inputNode.styled({
//                        $0.width  = .init(unit: .points, value: 100)
                        $0.flexGrow = 0.5
                        $0.flexShrink = 0.5
                        $0.height = .init(unit: .fraction, value: 20)
                    }),
                ]
            )
        }()
        
        node.backgroundColor = .init(hexString: "#8c79b4")
        node.automaticallyManagesSubnodes = true
        node.automaticallyRelayoutOnSafeAreaChanges = true
        node.automaticallyRelayoutOnLayoutMarginsChanges = true
        node.layoutSpecBlock = { [weak self] (_,_)in
            guard let self = self else {
                return ASLayoutSpec()
            }
            return ASInsetLayoutSpec(
                insets: .init(top: 0, left: 20, bottom: 0, right: 20),
                child: ASStackLayoutSpec(
                    direction: .vertical,
                    spacing: 0,
                    justifyContent: .spaceBetween,
                    alignItems: .stretch,
                    children: [
                        headerLayoutSpec,
                        // TODO: collectionNode 대체 자리
                        self.collectionNode.styled({
                            $0.flexGrow = 1
                            $0.flexShrink = 1
                        }).setBackgroundColor(color: UIColor.white),
                        self.footerNode,
                    ]
                    )
                    
            )
        }
        
        return node
    }()
    
    override init(node: ASDisplayNode) {
        super.init(node: node)
        
        self.node.layoutSpecBlock = { [weak self] (_,_) in
            guard let self = self else {
                return ASLayoutSpec()
            }
            let separator = ASDisplayNode()
            separator.style.height = .init(unit: .points, value: 8)
            separator.backgroundColor = UIColor.separator
            return ASInsetLayoutSpec(
                insets  : self.node.safeAreaInsets,
                child   : ASStackLayoutSpec(
                    direction: .vertical,
                    spacing: 0,
                    justifyContent: .spaceBetween,
                    alignItems: .stretch,
                    children: [
                        self.headerNode,
                        separator,
                        self.contentsNode.styled({
                            $0.flexShrink = 1.0
                            $0.flexGrow = 1.0
                        }),
                    ])
            )
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
extension SetupViewController : ASTextNodeDelegate
{
    func textNode(_ textNode: ASTextNode!, shouldHighlightLinkAttribute attribute: String!, value: Any!, at point: CGPoint) -> Bool {
        return true
    }
    
    func textNode(_ textNode: ASTextNode!, tappedLinkAttribute attribute: String!, value: Any!, at point: CGPoint, textRange: NSRange) {
        
    }
    
}
