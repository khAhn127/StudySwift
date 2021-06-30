//
//  GameNode.swift
//  firstApp
//
//  Created by Quintet on 2021/06/22.
//

import Foundation
import UIKit
import AsyncDisplayKit

class GameNode :ASDisplayNode {
    override init() {
        super.init()
        self.automaticallyManagesSubnodes = true
        self.automaticallyRelayoutOnSafeAreaChanges = true
        self.automaticallyRelayoutOnLayoutMarginsChanges = true
    }

}
