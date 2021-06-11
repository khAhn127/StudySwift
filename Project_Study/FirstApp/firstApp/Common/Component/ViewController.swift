//
//  ViewController.swift
//  firstApp
//
//  Created by Quintet on 2021/06/11.
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
        contentNode.backgroundColor = UIColor.white
        return contentNode
    }
}

class ViewController: ASDKViewController<ASDisplayNode> {
    
    override convenience init() {
        self.init(node: ASDisplayNode.contentNode)
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

