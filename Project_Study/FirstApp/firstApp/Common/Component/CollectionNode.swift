//
//  CollectionNode.swift
//  firstApp
//
//  Created by Quintet on 2021/06/16.
//

import UIKit
import AsyncDisplayKit
import DifferenceKit

public typealias RawModel = Codable & Differentiable

class CollectionNode<Model : RawModel, Cell: ASCellNode>: ASDisplayNode, ASCollectionDataSource, ASCollectionDelegate, ASCollectionDelegateFlowLayout, ASCollectionViewLayoutInspecting  {
    
    func collectionView(_ collectionView: ASCollectionView, constrainedSizeForNodeAt indexPath: IndexPath) -> ASSizeRange {
        <#code#>
    }
    
    func scrollableDirections() -> ASScrollDirection {
        <#code#>
    }
    
    override init() {
        super.init()
    }
}
