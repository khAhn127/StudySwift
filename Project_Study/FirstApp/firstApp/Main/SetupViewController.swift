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
        titleNode.attributedText = .init(string: "게임설명")
        
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
    
    lazy var contentsNode : ASDisplayNode = {
        let node = ASDisplayNode()
        node.backgroundColor = UIColor.yellow
        return node
    }()
    
    override init(node: ASDisplayNode) {
        super.init(node: node)
      
        self.contentsNode.backgroundColor = UIColor.systemPink
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
