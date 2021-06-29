//
//  PlayerNode.swift
//  firstApp
//
//  Created by Quintet on 2021/06/22.
//

import Foundation
import AsyncDisplayKit
import UIKit

class PlayerNode : ASDisplayNode {
    
    lazy var inputNode : ASEditableTextNode = {
        let node = ASEditableTextNode()
        node.textContainerInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        node.backgroundColor = UIColor.white
        node.borderWidth = 1
        node.borderColor = UIColor.lightGray.cgColor
        return node
    }()
    
    lazy var headerNode : ASDisplayNode = {
        let node = ASDisplayNode()
        let titleNode = ASTextNode()
        titleNode.textContainerInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        titleNode.attributedText = .init(string: "인원수")
        
       
        node.automaticallyManagesSubnodes = true
        node.automaticallyRelayoutOnSafeAreaChanges = true
        node.automaticallyRelayoutOnLayoutMarginsChanges = true
        node.layoutSpecBlock = { [weak self] (_,_) in
            guard let self = self else { return ASLayoutSpec() }
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
                        $0.width = .init(unit: .fraction, value: 0.5)
                        $0.height = .init(unit: .fraction, value:1)
                        }),
                    ]
                )
        }
        return node
    }()
    
    var model :[PlayerModel] = []
    
    lazy var collectionNode : DataCollectionNode<PlayerModel,PlayerCellNode> = {
        let node = DataCollectionNode<PlayerModel,PlayerCellNode>()
       
        model.append(.init(name: "test"))
        model.append(.init(name: "test2"))
        node.model = model
        node.backgroundColor = UIColor.clear
        return node
    }()

    lazy var footerNode : ASButtonNode = {
        let node = ASButtonNode()
        node.contentEdgeInsets = .init(top: 0, left: 30, bottom: 0, right: 30)
        node.setAttributedTitle(.init(string: "NEXT"), for: .normal)
        node .addTarget(self, action: #selector(ButtonDidPress), forControlEvents: .touchUpInside)
        node.borderWidth = 2
        node.borderColor = UIColor.lightText.cgColor
        return node
    }()
    
    @objc func ButtonDidPress(_ button: ASButtonNode) {
        onNext()
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
                    collectionNode.styled({
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
    
    let onNext: ()->()
    init(onNext: @escaping ()->() = {} ) {
        //comment escaping
        self.onNext = onNext
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
        //#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
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
                model.append(PlayerModel(name: "사람\(index + 1)"))
            }
            collectionNode.model = model
            collectionNode.collectionNode.reloadData()
            self.view.endEditing(true)
        }

}
extension SetupViewController : ASEditableTextNodeDelegate
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

   

