//
//  DataCollectionNode.swift
//  firstApp
//
//  Created by Quintet on 2021/06/25.
//

import Foundation
import UIKit
import AsyncDisplayKit
import DifferenceKit

class DataCollectionNode<Model: Codable, Cell: ASCellNode>: ASDisplayNode, ASCollectionDataSource, ASCollectionDelegate, ASCollectionDelegateFlowLayout, ASCollectionViewLayoutInspecting {
    var model: [Model] = []
    
    lazy var collectionNode: ASCollectionNode = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0.0
        let node = ASCollectionNode(collectionViewLayout: layout)
        node.layoutInspector = self
        node.dataSource = self
        node.delegate = self
        node.alwaysBounceVertical = true
        node.style.flexGrow = 1.0
        return node
    }()
    
    override init() {
        super.init()
        self.automaticallyManagesSubnodes = true
        self.automaticallyRelayoutOnSafeAreaChanges = true
        self.automaticallyRelayoutOnLayoutMarginsChanges = true
    }
    
    override func didLoad() {
        super.didLoad()
        collectionNode.view.delaysContentTouches = false
        //comment collectionNode의 자동 스크롤 조정 없이
        collectionNode.view.contentInsetAdjustmentBehavior = .never
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: .zero , child: collectionNode)
    }
    
    override func didEnterVisibleState() {
        super.didEnterVisibleState()
        setNeedsLayout()
        setNeedsDisplay()
    }
    
    func collectionView(_ collectionView: ASCollectionView, constrainedSizeForNodeAt indexPath: IndexPath) -> ASSizeRange {
        return ASSizeRangeMake(.zero, .init(width: collectionView.frame.size.width, height: CGFloat.infinity))
    }
    
    func scrollableDirections() -> ASScrollDirection {
        return [.up,.down]
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
        // data source 연동 하기
        var cellNode = Cell()
        let model: Model = self.model[indexPath.item]

        switch cellNode {
        case is PlayerCellNode:
            (cellNode as! PlayerCellNode).inputNode.attributedText = .init(string: (model as! PlayerModel).name )
        case is WinningCellNode:
            (cellNode as! WinningCellNode).inputNode.attributedText = .init(string: (model as! WinningModel).name )
        default:
            cellNode = ASCellNode() as! Cell
        }
        
        return cellNode
    }
}

