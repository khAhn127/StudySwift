//
//  WinningNode.swift
//  firstApp
//
//  Created by Quintet on 2021/06/22.
//

import Foundation
import AsyncDisplayKit
import UIKit

class WinningNode : ASDisplayNode {

    lazy var inputNode : ASEditableTextNode = {
        let node = ASEditableTextNode()
        node.textContainerInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        node.backgroundColor = UIColor.white
        node.borderWidth = 1
        node.borderColor = UIColor.lightGray.cgColor
        return node
    }()
    
    lazy var headerNode : ASStackLayoutSpec = {
        let titleNode = ASTextNode()
        titleNode.textContainerInset = .init(top: 0, left: 10, bottom: 0, right: 10)
        titleNode.attributedText = .init(string: "당첨자 수")
        
       return ASStackLayoutSpec(
        direction: .horizontal,
        spacing: 0,
        justifyContent: .spaceBetween,
        alignItems: .stretch,
        children: [
            titleNode.styled({
                $0.width = .init(unit: .points, value: 60)
                $0.height = .init(unit: .fraction, value: 1)
            }),
            self.inputNode.styled({
                $0.width = .init(unit: .fraction, value: 1)
                $0.height = .init(unit: .fraction, value:1)
            }),
        ]).styled({
            $0.width = .init(unit: .fraction, value: 1)
            $0.height = .init(unit: .points, value: 20)
        })
    }()
    
    var model :[WinningModel] = []
    
    lazy var dataListNode : DataCollectionNode<WinningModel,WinningCellNode> = {
        let node = DataCollectionNode<WinningModel,WinningCellNode>()
       
        model.append(.init(name: "test"))
        model.append(.init(name: "test2"))
        model.append(.init(name: "test3"))
        model.append(.init(name: "test4"))
        
        node.model = model
        node.backgroundColor = UIColor.clear
        return node
    }()

    lazy var footerNode : ASDisplayNode = {
        let node = ASDisplayNode()
        let back = ASButtonNode()
        back.contentEdgeInsets = .init(top: 0, left: 30, bottom: 0, right: 30)
        back.setAttributedTitle(.init(string: "Back"), for: .normal)
        back.addTarget(self, action: #selector(goBackButtonDidPress), forControlEvents: .touchUpInside)
        back.borderWidth = 2
        back.borderColor = UIColor.red.cgColor
        
        let product = ASButtonNode()
        back.contentEdgeInsets = .init(top: 0, left: 30, bottom: 0, right: 30)
        back.setAttributedTitle(.init(string: "생성"), for: .normal)
        back.addTarget(self, action: #selector(produceButtonDidPress), forControlEvents: .touchUpInside)
        back.borderWidth = 2
        back.borderColor = UIColor.red.cgColor
        return node
    }()
    
    @objc func goBackButtonDidPress(_ button: ASButtonNode) {
        goBack()
    }
    
    @objc func produceButtonDidPress(_ button: ASButtonNode) {
        toProduct()
    }
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        self.borderColor = UIColor.blue.cgColor
        self.borderWidth = 1
        return ASInsetLayoutSpec(
            insets: .init(top: 40, left: 10, bottom: 40, right: 10),
            child: ASStackLayoutSpec(
                direction: .vertical,
                spacing: 0,
                justifyContent: .center,
                alignItems: .stretch,
                children: [
                    headerNode.styled({
                        $0.width = .init(unit: .fraction, value: 1)
                        $0.height = .init(unit: .points, value: 20)
                    }),
                    ASDisplayNode().styled({
                        $0.width = .init(unit: .fraction, value: 1)
                        $0.height = .init(unit: .points, value: 8)
                    }).setBackgroundColor(color: UIColor.black),
                    self.dataListNode.styled({
                        $0.width = .init(unit: .fraction, value: 1)
                        $0.height = .init(unit: .fraction, value: 1)
                    }),
                    footerNode.styled({
                        $0.width = .init(unit: .fraction, value: 1)
                        $0.height = .init(unit: .points, value: 20)
                    }),
                    ASDisplayNode().styled({
                        $0.width = .init(unit: .fraction, value: 1)
                        $0.height = .init(unit: .points, value: 20)
                    }),
                ])
            )
    }
    
    let toProduct: ()->()
    let goBack: ()->()
    
    init(toProduct: @escaping ()->() = {} , goBack: @escaping ()->() = {}) {
        self.toProduct = toProduct
        self.goBack = goBack
        super.init()
        self.automaticallyManagesSubnodes = true
        self.automaticallyRelayoutOnSafeAreaChanges = true
        self.automaticallyRelayoutOnLayoutMarginsChanges = true
    }

    override func didLoad() {
        let toolBarKeyboard = UIToolbar()
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: .none, action: .none)
        let btnDoneBar = UIBarButtonItem(title: "OK", style: .done, target: self, action: #selector(self.create))
        toolBarKeyboard.items = [space,btnDoneBar]
        toolBarKeyboard.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        toolBarKeyboard.backgroundColor = .init(hexString: "#8c79b4")
        toolBarKeyboard.sizeToFit()

        inputNode.textView.inputAccessoryView = toolBarKeyboard
        //comment 최대 라인 수
        inputNode.textView.textContainer.maximumNumberOfLines = 1
        // Do any additional setup after loading the view.

    }
    
    @objc func create() {
        let number = (inputNode.attributedText?.string.intValue ?? 0 ) as Int
        model.removeAll()
        for index in 0 ..< number
        {
            model.append(WinningModel(name: "사람\(index + 1)"))
        }
        dataListNode.model = model
        dataListNode.collectionNode.reloadData()
        self.view.endEditing(true)
    }
    

}
extension WinningNode : ASEditableTextNodeDelegate
{
    func editableTextNodeShouldBeginEditing(_ editableTextNode: ASEditableTextNode) -> Bool {
        return true
    }
    func editableTextNode(_ editableTextNode: ASEditableTextNode, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let nsString = editableTextNode.textView.text as NSString?
        guard
            let newString = nsString?.replacingCharacters(in: range, with: text),
            newString.lengthOfBytes(using: .utf8) <= 1
        else {
            return false
        }
        return true
    }
}
