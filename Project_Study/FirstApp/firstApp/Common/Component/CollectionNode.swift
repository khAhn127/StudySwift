//
//  CollectionNode.swift
//  firstApp
//
//  Created by Quintet on 2021/06/16.
//

import UIKit
import AsyncDisplayKit
import DifferenceKit

public typealias RawModel = Codable 

class CollectionNode<Model : RawModel, Cell: ASCellNode>: ASDisplayNode, ASCollectionDataSource, ASCollectionDelegate, ASCollectionDelegateFlowLayout, ASCollectionViewLayoutInspecting  {
    var model : [SetupModel] = []
    
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
        return ASInsetLayoutSpec(insets: .zero, child: collectionNode)
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
        let cellNode = SetupCellNode()
        let model : SetupModel  = self.model[indexPath.item]
        
        cellNode.titleNode.attributedText = .init(string: model.type)
        cellNode.inputNode.attributedText = .init(string: model.name)
        
        return cellNode
    }
}
