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

    
    
    lazy var drawNode :ASDisplayNode = {
        let node = ASDisplayNode{ return DrawView(frame:self.view.frame)
        }
        node.backgroundColor = .init(hexString: "#8c79b4")
        return node
    }()

    lazy var resetNode :ASButtonNode = {
        let node = ASButtonNode()
        node.contentEdgeInsets = .init(top: 0, left: 30, bottom: 0, right: 30)
        node.setAttributedTitle(.init(string: "reset"), for: .normal)
        node .addTarget(self, action: #selector(reset), forControlEvents: .touchUpInside)
        node.borderWidth = 2
        node.borderColor = UIColor.lightText.cgColor
        return node
    }()
    lazy var startNode :ASButtonNode = {
        let node = ASButtonNode()
        node.contentEdgeInsets = .init(top: 0, left: 30, bottom: 0, right: 30)
        node.setAttributedTitle(.init(string: "start"), for: .normal)
        node .addTarget(self, action: #selector(start), forControlEvents: .touchUpInside)
        node.borderWidth = 2
        node.borderColor = UIColor.lightText.cgColor
        return node
    }()
    override init() {
        super.init()
        self.automaticallyManagesSubnodes = true
        self.automaticallyRelayoutOnSafeAreaChanges = true
        self.automaticallyRelayoutOnLayoutMarginsChanges = true
        self.backgroundColor = .init(hexString: "#e67ea3")
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        
        
        return ASInsetLayoutSpec(
            insets: .init(top: 20, left: 10, bottom: 20, right: 10),
            child: ASStackLayoutSpec(
                direction: .vertical,
                spacing: 0,
                justifyContent: .spaceBetween,
                alignItems: .stretch,
                children: [
                    self.drawNode.styled({
                        $0.width = .init(unit: .fraction, value: 1)
                        $0.height = .init(unit: .fraction, value: 1)
                    }),
                    ASStackLayoutSpec (
                        direction: .horizontal,
                        spacing: 10,
                        justifyContent: .spaceBetween,
                        alignItems: .stretch,
                        children: [
                            self.resetNode.styled({
                                $0.width = .init(unit: .fraction, value: 0.5)
                                $0.height = .init(unit: .points, value: 20)
                            }),
                            self.startNode.styled({
                                $0.width = .init(unit: .fraction, value: 0.5)
                                $0.height = .init(unit: .points, value: 20)
                            }),
                            
                        ]
                    ),
                    
                ]
            )
        )
    }
    @objc func reset() {
        let drawView =  self.drawNode.view as? DrawView
      
        
    }
    @objc func start() {
        let drawView =  self.drawNode.view as? DrawView
        drawView?.layer.sublayers?.removeAll()
        drawView?.player(1)
      
    }
}

class DrawView : UIView{
    var data :[[Int]] = [[Int]](repeating: [Int](repeating:0, count: 11), count: 11)
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        var vertical:CGFloat = 0
        var playersCount = 8
        //comment Y축 라인 선 그리기
        for x in 1...9{
            vertical = vertical + ((self.bounds.width-10)/10)
            context.setStrokeColor(UIColor.black.cgColor)
            context.move(to: CGPoint(x: vertical, y: 10))
            context.addLine(to: CGPoint(x:vertical, y: ((self.bounds.height-10))))
            context.strokePath()
            context.closePath()
            
            for _ in 1...10 {
                //comment 가로 라인 축 그리기 데이터
                let randomX = Int.random(in: 1...9)
                //comment 세로 라인 축
                let randomY = Int.random(in: 1...8)
                
                data[randomX][randomY] = 1
            }
        }
        //comment 중복 체크
        var count : Int = 0
        for x in 1...9 {
            count = 0

            for y in 1...8{
                if data[x][y] == 0 {
                    count += 1
                }
                if y > 0 && y < 9 {
                    //comment 동일 라인 선 중복 시 오른쪽 삭제
                    if data[x][y] == data[x][y+1] {
                        data[x][y+1] = 0
                    }
                }
                if data[x][y] == 1 {
                
                    context.setStrokeColor(UIColor.black.cgColor)
                    context.move(to: CGPoint(x: (((self.bounds.width-10)/10)*CGFloat(y)),
                                             y: (((self.bounds.height-10)/10)*CGFloat(x)) ))
                    context.addLine(to: CGPoint(x: ((self.bounds.width-10)/10)*CGFloat(y+1) ,
                                                y: (((self.bounds.height-10)/10)*CGFloat(x))))
                    context.strokePath()
                    context.closePath()
                }
            }
            var n = count - 2
            while n < count {
//                //comment 랜덤 가로 라인
                let y2 = Int.random(in: 1...8)
                if y2 > 0 && y2 < 9 {
                    if data[x][y2+1] == 1 { continue }
                    if data[x][y2-1] == 1 { continue }

                        context.setStrokeColor(UIColor.black.cgColor)
                        context.move(to: CGPoint(x: (((self.bounds.width-10)/10)*CGFloat(y2)),
                                                 y: (((self.bounds.height-10)/10)*CGFloat(x)) ))
                        context.addLine(to: CGPoint(x: ((self.bounds.width-10)/10)*CGFloat(y2+1) ,
                                                    y: (((self.bounds.height-10)/10)*CGFloat(x))))
                        context.strokePath()
                        data[x][y2] = 1
                        n += 1
                } else { n += 1 }

            }
        }
    }
    
    func player(_ playerNumber : Int) {
        let width : CGFloat = ((self.bounds.width-10)/10)
        let height : CGFloat = ((self.bounds.height-10)/10)
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
                        path.move(to: CGPoint(x: width * CGFloat(h) , y: height * CGFloat(v)))
                        path.addLine(to: CGPoint(x: width * CGFloat(h-1) , y: height * CGFloat(v)))
                        h -= 1
                    }
                    path.move(to: CGPoint(x: width * CGFloat(h) , y: height * CGFloat(v)))
                    path.addLine(to: CGPoint(x: width * CGFloat(h) , y: height * CGFloat(v+1)))
                    v += 1
                } else if self.data[v][h] == 1 {    //comment right 라인 체크 후 y축 다운
                    path.move(to: CGPoint(x: width * CGFloat(h) , y: height * CGFloat(v)))
                    path.addLine(to: CGPoint(x: width * CGFloat(h+1) , y: height * CGFloat(v)))
                    h += 1
                    
                    path.move(to: CGPoint(x: width * CGFloat(h) , y: height * CGFloat(v)))
                    path.addLine(to: CGPoint(x: width * CGFloat(h) , y: height * CGFloat(v+1)))
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

