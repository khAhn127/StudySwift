//
//  GameNode.swift
//  firstApp
//
//  Created by Quintet on 2021/06/22.
//

import Foundation
import UIKit
import AsyncDisplayKit

class GameNode: ASDisplayNode {
    var selectPlayer: Int = 1
    
    lazy var drawNode: ASDisplayNode = {
        let node = ASDisplayNode{ return DrawView(frame:self.view.frame) }
        node.backgroundColor = .init(hexString: "#8c79b4")
        return node
    }()
    lazy var headerNode: [ASTextNode] = {
        var node: [ASTextNode] = []
        for x in 1...GameConfigure.shared.playerCount {
            let text = ASTextNode().styled {
                $0.width = .init(unit: .fraction, value: 1/GameConfigure.shared.playerCount.toCGFloat)
                $0.height = .init(unit: .fraction, value: 1) }
            text.attributedText = .init(string: "사람\(x)")
            text.addTarget(self, action: #selector(selectedPlayer(_:)), forControlEvents: .touchUpInside)
            text.view.tag = x
            text.borderWidth = text.isSelected ? 1 : 0
            node.append(text)
        }
        return node
    }()

    var footer: [ASTextNode] {
        var node : [ASTextNode] = []
        for x in 1...GameConfigure.shared.playerCount {
            let text = ASTextNode().styled {
                $0.width = .init(unit: .fraction, value: 1/GameConfigure.shared.playerCount.toCGFloat)
                $0.height = .init(unit: .fraction, value: 1 )
            }
            if x <= GameConfigure.shared.winnerCount {
                text.attributedText = .init(string: "당첨\(x)")
                text.borderColor =  UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0).cgColor
                text.borderWidth = 1
            } else {
                text.attributedText = .init(string: "꽝")
            }
            text.view.tag = x
            node.append(text)
        }
        node.shuffle()
        return node
    }
    lazy var resetNode: ASButtonNode = {
        let node = ASButtonNode()
        node.contentEdgeInsets = .init(top: 0, left: 30, bottom: 0, right: 30)
        node.setAttributedTitle(.init(string: "reset"), for: .normal)
        node.addTarget(self, action: #selector(reset(_:)), forControlEvents: .touchUpInside)
        node.borderWidth = 2
        node.borderColor = UIColor.lightText.cgColor
        return node
    }()
    lazy var startNode: ASButtonNode = {
        let node = ASButtonNode()
        node.contentEdgeInsets = .init(top: 0, left: 30, bottom: 0, right: 30)
        node.setAttributedTitle(.init(string: "start"), for: .normal)
        node.addTarget(self, action: #selector(start(_:)), forControlEvents: .touchUpInside)
        node.borderWidth = 2
        node.borderColor = UIColor.lightText.cgColor
        return node
    }()
    
    override init() {
        super.init()
        _ =  self.drawNode.view as? DrawView
        self.automaticallyManagesSubnodes = true
        self.automaticallyRelayoutOnSafeAreaChanges = true
        self.automaticallyRelayoutOnLayoutMarginsChanges = true
        self.backgroundColor = .init(hexString: "#e67ea3")
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(
            insets: .init(top: 20, left: 10, bottom: 60, right: 10),
            child: ASStackLayoutSpec(
                direction: .vertical,
                spacing: 0,
                justifyContent: .spaceBetween,
                alignItems: .stretch,
                children: [
                    ASStackLayoutSpec(
                        direction: .horizontal,
                        spacing: 0,
                        justifyContent: .end,
                        alignItems: .stretch,
                        children: self.headerNode
                    ).styled({
                        $0.width = .init(unit: .fraction, value: 1)
                        $0.height = .init(unit: .points, value: 20)
                    }),
                    self.drawNode.styled({
                        $0.width = .init(unit: .fraction, value: 1)
                        $0.height = .init(unit: .fraction, value: 1)
                    }),
                    ASStackLayoutSpec(
                        direction: .horizontal,
                        spacing: 0,
                        justifyContent: .end,
                        alignItems: .stretch,
                        children: self.footer
                    ).styled({
                        $0.width = .init(unit: .fraction, value: 1)
                        $0.height = .init(unit: .points, value: 20)
                    }) ,
                    ASStackLayoutSpec(
                        direction: .horizontal,
                        spacing: 10,
                        justifyContent: .spaceBetween,
                        alignItems: .stretch,
                        children: [
                            self.resetNode.styled({
                                $0.width = .init(unit: .fraction, value: 0.5)
                                $0.height = .init(unit: .points, value: 20)}),
                            self.startNode.styled({
                                $0.width = .init(unit: .fraction, value: 0.5)
                                $0.height = .init(unit: .points, value: 20)}),
                        ]
                    ),
                ]
            )
        )
    }
    
    @objc func reset(_ sender: ASButtonNode) {
        let drawView =  self.drawNode.view as? DrawView
        drawView?.layer.sublayers?.removeAll()
        self.drawNode.view.setNeedsDisplay()
    }
    @objc func start(_ sender: ASButtonNode) {
        let drawView =  self.drawNode.view as? DrawView
        drawView?.layer.sublayers?.removeAll()
        drawView?.player(selectPlayer)
    }
    @objc func selectedPlayer(_ sender: ASTextNode) {
        self.selectPlayer = sender.view.tag
    }
}

extension Int {
    var toCGFloat: CGFloat {
        return CGFloat(self)
    }
}

class DrawView: UIView {
    lazy var gameWidth: CGFloat = (self.bounds.width - 20) / GameConfigure.shared.playerCount.toCGFloat
    lazy var gameHeight: CGFloat = (self.bounds.height - 20) / GameConfigure.shared.playerCount.toCGFloat
    
    var data: [[Int]] = [[]]
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        let playersCount: Int = GameConfigure.shared.playerCount
        data = [[Int]](repeating: [Int](repeating:0, count: playersCount+1), count: playersCount+1)
        //comment Y축 라인 선 그리기
        for x in 1...playersCount {
            context.setStrokeColor(UIColor.black.cgColor)
            context.move(to: CGPoint(x: gameWidth * x.toCGFloat, y: 10))
            context.addLine(to: CGPoint(x:gameWidth * x.toCGFloat, y: self.bounds.height - 20))
            context.strokePath()
            context.closePath()
            
            for _ in 1...playersCount-1 {
                //comment 가로 라인 축 그리기 데이터
                let randomX = Int.random(in: 1...playersCount - 1)
                //comment 세로 라인 축
                let randomY = Int.random(in: 1...playersCount - 1)
                data[randomX][randomY] = 1
            }
        }
        //comment 중복 체크
        var count: Int = 0
        for x in 1...playersCount-1 {
            count = 0
            
            for y in 1...playersCount-1 {
                if data[x][y] == 0 {
                    count += 1
                }
                if y > 0 && y < playersCount-1 {
                    //comment 동일 라인 선 중복 시 오른쪽 삭제
                    if data[x][y] == data[x][y+1] {
                        data[x][y+1] = 0
                    }
                }
                if data[x][y] == 1 {
                    context.setStrokeColor(UIColor.black.cgColor)
                    context.move(to: CGPoint(x: gameWidth * y.toCGFloat, y: gameHeight * x.toCGFloat))
                    context.addLine(to: CGPoint(x: gameWidth * (y.toCGFloat+1), y: gameHeight * x.toCGFloat))
                    context.strokePath()
                    context.closePath()
                }
            }
            var n = count - 2
            while n < count {
//                //comment 랜덤 가로 라인
                let y2 = Int.random(in: 1...playersCount-1)
                if y2 > 0 && y2 < playersCount - 1 {
                    if data[x][y2+1] == 1 { continue }
                    if data[x][y2-1] == 1 { continue }
                    context.setStrokeColor(UIColor.black.cgColor)
                    context.move(to: CGPoint(x: gameWidth * y2.toCGFloat, y: gameHeight * x.toCGFloat))
                    context.addLine(to: CGPoint(x: gameWidth * (y2.toCGFloat+1), y: gameHeight * x.toCGFloat))
                    context.strokePath()
                    data[x][y2] = 1
                }
                n += 1
            }
        }
        for rowData in data {
            print(rowData)
        }
    }
    
    func player(_ playerNumber: Int) {
        var v = 0
        var h = playerNumber
        //comment add line
        let basePath = { () -> UIBezierPath in
            let path: UIBezierPath = UIBezierPath()
            //comment 스타트 시점
            while v < GameConfigure.maxLine {
                //comment  h-1 == 1 일때 left 그리기, h+1 == 1 일때 right , false = h
                path.move(to: CGPoint(x: self.gameWidth * h.toCGFloat, y: self.gameHeight * v.toCGFloat))
                path.addLine(to: CGPoint(x: self.gameWidth * CGFloat(self.data[v][h-1] == 1 ? (h-1) : ( self.data[v][h] == 1 ? (h+1) : h)) ,
                                         y: self.gameHeight * v.toCGFloat))
                h = self.data[v][h-1] == 1 ? (h-1) : ( self.data[v][h] == 1 ? (h+1) : h)
                //comment y축 방향으로 그리기
                path.move(to: CGPoint(x: self.gameWidth * h.toCGFloat, y: self.gameHeight * v.toCGFloat))
                path.addLine(to: CGPoint(x: self.gameWidth * h.toCGFloat, y: self.gameHeight * (v.toCGFloat+1)))
                v += 1
            }
            return path
        }
        
        let baseLineLayer = { () -> CAShapeLayer in
            let layer: CAShapeLayer = CAShapeLayer()
            layer.lineWidth = 3
            layer.strokeColor = UIColor.red.cgColor
            layer.path = basePath().cgPath
            
            return layer
        }    
        self.layer.addSublayer(baseLineLayer())
    }
}

