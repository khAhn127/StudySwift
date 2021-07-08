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
    var players: Int = 1
    var winning: Int = 1
    var selectPlayer: Int = 1
    
    lazy var drawNode: ASDisplayNode = {
        let node = ASDisplayNode{ return DrawView(frame:self.view.frame) }
        node.backgroundColor = .init(hexString: "#8c79b4")
        return node
    }()
    
    lazy var headerNode: [ASTextNode] = {
        var node: [ASTextNode] = []
        for x in 1...self.players {
            let text = ASTextNode().styled {
                $0.width = .init(unit: .fraction, value: 1/CGFloat(players))
                $0.height = .init(unit: .fraction, value: 1) }
            text.attributedText = .init(string: "사람\(x)")
            text.addTarget(self, action: #selector(selectedPlayer(_:)), forControlEvents: .touchUpInside)
            text.view.tag = x
            text.borderWidth = text.isSelected ? 1 : 0
            node.append(text)
        }
        return node
    }()

    lazy var footer: [ASTextNode] = {
        var node : [ASTextNode] = []
        for x in 1...self.players {
            let text = ASTextNode().styled {
                $0.width = .init(unit: .fraction, value: 1/CGFloat(players))
                $0.height = .init(unit: .fraction, value: 1 )
            }
            if x <= self.winning {
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
    }()
    
    lazy var resetNode: ASButtonNode = {
        let node = ASButtonNode()
        node.contentEdgeInsets = .init(top: 0, left: 30, bottom: 0, right: 30)
        node.setAttributedTitle(.init(string: "reset"), for: .normal)
        node.addTarget(self, action: #selector(reset), forControlEvents: .touchUpInside)
        node.borderWidth = 2
        node.borderColor = UIColor.lightText.cgColor
        return node
    }()
    lazy var startNode: ASButtonNode = {
        let node = ASButtonNode()
        node.contentEdgeInsets = .init(top: 0, left: 30, bottom: 0, right: 30)
        node.setAttributedTitle(.init(string: "start"), for: .normal)
        node .addTarget(self, action: #selector(start), forControlEvents: .touchUpInside)
        node.borderWidth = 2
        node.borderColor = UIColor.lightText.cgColor
        return node
    }()
    
    init(_ players:Int, _ winning: Int) {
        super.init()
        self.players = players
        self.winning = winning
        let drawView =  self.drawNode.view as? DrawView
        drawView?.playersCount = CGFloat(players)
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
    @objc func reset() {
        let drawView =  self.drawNode.view as? DrawView
        drawView?.layer.sublayers?.removeAll()
        self.drawNode.view.setNeedsDisplay()
    }
    @objc func start() {
        let drawView =  self.drawNode.view as? DrawView
        drawView?.layer.sublayers?.removeAll()
        drawView?.player(selectPlayer)
    }
    @objc func selectedPlayer(_ sender : ASTextNode) {
        self.selectPlayer = sender.view.tag
    }
    
}


class DrawView: UIView {
    lazy var gameWidth: CGFloat = {
        let width = CGFloat()
        return width
    }()
    lazy var gameHeight: CGFloat = {
        let height = CGFloat()
        return height
    }()
    lazy var playersCount: CGFloat = {
        let count = CGFloat(1)
        return count
    }()
    var data: [[Int]] = [[]]
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        gameWidth = self.bounds.width - 20
        gameHeight = self.bounds.height - 20
        data = [[Int]](repeating: [Int](repeating:0, count: Int(playersCount)+1), count: Int(playersCount)+1)
        var vertical: CGFloat = 0
//        playersCount = CGFloat(10)
        //comment Y축 라인 선 그리기
        for _ in 1...Int(playersCount) {
            vertical += ((gameWidth)/playersCount)
            context.setStrokeColor(UIColor.black.cgColor)
            context.move(to: CGPoint(x: vertical, y: 10))
            context.addLine(to: CGPoint(x:vertical, y: (gameHeight)))
            context.strokePath()
            context.closePath()
            
            for _ in 1...Int(playersCount) {
                //comment 가로 라인 축 그리기 데이터
                let randomX = Int.random(in: 1...Int(playersCount) - 1)
                //comment 세로 라인 축
                let randomY = Int.random(in: 1...Int(playersCount) - 1)
                
                data[randomX][randomY] = 1
            }
        }
        //comment 중복 체크
        var count: Int = 0
        for x in 1...Int(playersCount)-1 {
            count = 0

            for y in 1...Int(playersCount)-1 {
                if data[x][y] == 0 {
                    count += 1
                }
                if y > 0 && y < Int(playersCount)-1 {
                    //comment 동일 라인 선 중복 시 오른쪽 삭제
                    if data[x][y] == data[x][y+1] {
                        data[x][y+1] = 0
                    }
                }
                if data[x][y] == 1 {
                
                    context.setStrokeColor(UIColor.black.cgColor)
                    context.move(to: CGPoint(x: (self.gameWidth/playersCount) * CGFloat(y),
                                             y: (self.gameHeight/playersCount) * CGFloat(x)))
                    context.addLine(to: CGPoint(x: (self.gameWidth/playersCount) * CGFloat(y+1),
                                                y: (self.gameHeight/playersCount) * CGFloat(x)))
                    context.strokePath()
                    context.closePath()
                }
            }
            var n = count - 2
            while n < count {
//                //comment 랜덤 가로 라인
                let y2 = Int.random(in: 1...Int(playersCount)-1)
                if y2 > 0 && y2 < Int(playersCount) - 1 {
                    if data[x][y2+1] == 1 { continue }
                    if data[x][y2-1] == 1 { continue }
                        context.setStrokeColor(UIColor.black.cgColor)
                        context.move(to: CGPoint(x: (self.gameWidth/playersCount) * CGFloat(y2),
                                                 y: (self.gameHeight/playersCount) * CGFloat(x)))
                        context.addLine(to: CGPoint(x: (self.gameWidth/playersCount)*CGFloat(y2+1),
                                                    y:(self.gameHeight/playersCount)*CGFloat(x)))
                        context.strokePath()
                        data[x][y2] = 1
                        n += 1
                } else { n += 1 }

            }
        }
        for rowData in data {
            print(rowData)
        }
    }
    
    func player(_ playerNumber: Int) {
        var v = 0
        var h = playerNumber
        let maxLine = 10
        //comment add line
        let basePath = { () -> UIBezierPath in
            let path: UIBezierPath = UIBezierPath()
            //comment 스타트 시점
            while v < maxLine {
                //comment vetical line down
                if self.data[v][h] == 0 {
                    //comment left 라인 체크
                    if (self.data[v][h-1] == 1) {
                        path.move(to: CGPoint(x: (self.gameWidth/self.playersCount) * CGFloat(h) , y: (self.gameHeight/self.playersCount) * CGFloat(v)))
                        path.addLine(to: CGPoint(x: (self.gameWidth/self.playersCount) * CGFloat(h-1) , y: (self.gameHeight/self.playersCount) * CGFloat(v)))
                        h -= 1
                    }
                    path.move(to: CGPoint(x: (self.gameWidth/self.playersCount) * CGFloat(h) , y: (self.gameHeight/self.playersCount) * CGFloat(v)))
                    path.addLine(to: CGPoint(x: (self.gameWidth/self.playersCount) * CGFloat(h) , y: (self.gameHeight/self.playersCount) * CGFloat(v+1)))
                    v += 1
                } else if self.data[v][h] == 1 {    //comment right 라인 체크 후 y축 다운
                    path.move(to: CGPoint(x: (self.gameWidth/self.playersCount) * CGFloat(h) , y: (self.gameHeight/self.playersCount) * CGFloat(v)))
                    path.addLine(to: CGPoint(x: (self.gameWidth/self.playersCount) * CGFloat(h+1) , y: (self.gameHeight/self.playersCount) * CGFloat(v)))
                    h += 1
                    
                    path.move(to: CGPoint(x: (self.gameWidth/self.playersCount) * CGFloat(h) , y: (self.gameHeight/self.playersCount) * CGFloat(v)))
                    path.addLine(to: CGPoint(x: (self.gameWidth/self.playersCount) * CGFloat(h) , y: (self.gameHeight/self.playersCount) * CGFloat(v+1)))
                    v += 1
                }
               
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

