//
//  MainViewController.swift
//  firstApp
//
//  Created by Quintet on 2021/06/10.
//

import Foundation
import AsyncDisplayKit

extension ASDisplayNode {
    class var contentNode: ASDisplayNode {
        let contentNode = ASDisplayNode()
        //comment 하위 노드 자동 설정
        contentNode.automaticallyManagesSubnodes = true
        //comment SetNeedLayout 처리의 플래그 처리
        contentNode.automaticallyRelayoutOnSafeAreaChanges = true
        //comment 자동으로 SetNeedLayout될 떄 마진 처리의 플래그 처리
        contentNode.automaticallyRelayoutOnLayoutMarginsChanges = true
       
        return contentNode
    }
}

extension String {
    
    func withFont(_ font: UIFont) -> NSAttributedString {
        return NSAttributedString(
            string: self,
            attributes:
            [
                .font: font,
            ]
        )
    }
    var localized: String {
        return self.localizedString()
    }
    
    func localizedString(_ comment: String? = nil) -> String {
        return NSLocalizedString(self, comment: comment ?? self)
    }
}

class MainViewController: ASDKViewController<ASDisplayNode> {
    lazy var nameNode : ASTextNode = {
        let node = ASTextNode()
        
        node.attributedText = .init( string: "Hellow World Texture")
        node.textContainerInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        return node
    }()

    override convenience init() {
        self.init(node: ASDisplayNode.contentNode)
//        self.hidesBottomBarWhenPushed = true

        self.node.layoutSpecBlock = { [weak self] (_, _) -> ASLayoutSpec in
            guard let self = self else {
                return ASLayoutSpec()
            }
            let topNode = ASDisplayNode()
            topNode.backgroundColor = UIColor.blue
            topNode.style.width = .init(unit: .fraction, value: 100.0)
            topNode.style.height = .init(unit: .points, value: 200.0)
            topNode.layoutMargins = .init(top: 20, left: 50, bottom: 50, right: 20)
            let bottomNode = ASDisplayNode()
            bottomNode.backgroundColor = UIColor.green
            bottomNode.style.width = .init(unit: .fraction, value: 100.0)
            bottomNode.style.height = .init(unit: .points, value: 200.0)
            bottomNode.layoutMargins = .init(top: 100, left: 100, bottom: 50, right: 20)
            return ASInsetLayoutSpec(
                insets: self.node.safeAreaInsets,
                child: ASStackLayoutSpec(
                    direction: .vertical,
                    spacing: .zero,
                    justifyContent: .spaceBetween,
                    alignItems: .baselineFirst,
                    children: [ topNode,
                                bottomNode,
                    ]
                    )
            )

        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = UIColor.systemPink
        //        node.addSubnode(nameNode)
//        view.addSubnode(node)
        // Do any additional setup after loading the view.
      
        chaneText()
        //nameNode.attributedText = .init( string: "view Did Load")
    }

    
    
    func chaneText () -> Void {
        nameNode.textContainerInset = .init(top: 20, left: 20, bottom: 20, right: 20)
        node.layoutMargins = .init(top: 100, left: 100, bottom: 100, right: 100)
        nameNode.attributedText = .init( string: "view Did Load")
        node.setNeedsLayout()
    }
}

