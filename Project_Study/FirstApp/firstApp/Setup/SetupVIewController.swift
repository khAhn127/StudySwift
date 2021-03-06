//
//  SetupVIewController.swift
//  firstApp
//
//  Created by Quintet on 2021/06/22.
//

import Foundation
import UIKit
import AsyncDisplayKit

class GameConfigure {
    static let shared = GameConfigure()
    static let maxLine = 10
    var playerCount: Int = 0
    var winnerCount: Int = 0
}

class SetupViewController: ViewController {
    enum Mode {
        case player
        case winning
    }
    var mode = Mode.player {
        didSet {
            self.contentsNode.setNeedsLayout()
        }
    }

    lazy var playerNode = PlayerNode(onNext: { [weak self] (count) in
        self?.mode = .winning
        GameConfigure.shared.playerCount = count
    }).setBackgroundColor(color: .init(hexString: "#e67ea3") )
    
    lazy var winningNode = WinningNode(toProduct: { [weak self] (count) in
        GameConfigure.shared.winnerCount = count
        if
            let mainTab = self?.tabBarController as? MainTabBarController,
            let vc = self?.tabBarController?.viewControllers?[1] as? GameViewController
        {
            if mainTab.tabBarController(mainTab, shouldSelect: vc) {
                vc.isStart = true
                vc.node.setNeedsLayout()
                self?.tabBarController?.selectedIndex = 1
            }
        }
    }, goBack: { [weak self] in
        self?.mode = .player
    }).setBackgroundColor(color:.init(hexString: "#8c79b4") )
    
    lazy var titleNode: ASDisplayNode = {
        let node = ASDisplayNode()
        let textNode = ASTextNode()
        node.automaticallyManagesSubnodes = true
        node.automaticallyRelayoutOnSafeAreaChanges = true
        node.automaticallyRelayoutOnLayoutMarginsChanges = true
        node.backgroundColor = UIColor.white
        textNode.attributedText = .init(string: "게임설정")
        node.layoutSpecBlock = { [weak self] (_,_) in
            guard let self = self else {
                return ASLayoutSpec()
            }
            return ASInsetLayoutSpec(
                insets: .init(top: 10, left: 0, bottom: 0, right: 0),
                child: ASStackLayoutSpec(
                    direction: .horizontal,
                    spacing: 0,
                    justifyContent: .center,
                    alignItems: .stretch,
                    children: [
                        textNode,
                    ]
                )
            )
        }
        return node
    }()
    
    lazy var contentsNode: ASDisplayNode = {
        let node = ASDisplayNode()
        node.automaticallyManagesSubnodes = true
        node.automaticallyRelayoutOnSafeAreaChanges = true
        node.automaticallyRelayoutOnLayoutMarginsChanges = true
        node.borderWidth = 1
        node.borderColor = UIColor.yellow.cgColor
        node.backgroundColor = UIColor.white
        node.layoutSpecBlock = { [weak self] (_,_) in
            guard let self = self else { return ASLayoutSpec() }
            var child = ASDisplayNode()
            switch self.mode {
            case .player:
                child = self.playerNode
            case .winning:
                child = self.winningNode
            }
            return ASInsetLayoutSpec(
                insets: .zero,
                child: child
            )
        }
        return node
    }()

    override init(node: ASDisplayNode) {
        super.init(node: node)
        node.layoutSpecBlock = { [weak self] (_,_) in
            guard let self = self else { return ASLayoutSpec() }
            return ASInsetLayoutSpec(
                insets: self.view.safeAreaInsets,
                child: ASStackLayoutSpec(
                    direction: .vertical,
                    spacing: 0,
                    justifyContent: .center,
                    alignItems: .stretch,
                    children: [
                        self.titleNode.styled({
                            $0.width  = .init(unit: .fraction,value: 1)
                            $0.height = .init(unit: .points, value: 30)
                        }),
                        ASDisplayNode().styled({
                            $0.width = .init(unit: .fraction, value: 1)
                            $0.height = .init(unit: .points, value: 8)
                        }).setBackgroundColor(color: UIColor.black),
                        self.contentsNode.styled({
                            $0.width = .init(unit: .fraction, value: 1)
                            $0.height = .init(unit: .fraction, value: 1)
                        }),
                    ]
                )
            )
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white
        swipeRecognizer()
    }
    
}
extension SetupViewController {
    func swipeRecognizer() {
        // Initialize Swipe Gesture Recognizer
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(_:)))
        // Configure Swipe Gesture Recognizer
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(_:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
    }
        
    @objc func respondToSwipeGesture(_ gesture: UIGestureRecognizer) {
        guard let recognizer = gesture as? UISwipeGestureRecognizer else { return }
        switch recognizer.direction {
        case .right:
            // 스와이프 시, 원하는 기능 구현.
            switch self.mode {
            case .player: self.mode = .winning
                break
            case .winning:
                break
            }
            break
        case .left:
            switch self.mode {
            case .player:
                break
            case .winning:
                self.mode = .player
                break
            }
            break
        default: break
        }
    }

}
