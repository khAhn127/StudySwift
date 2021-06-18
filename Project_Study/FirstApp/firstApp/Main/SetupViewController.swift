//
//  SetupViewController.swift
//  firstApp
//
//  Created by Quintet on 2021/06/11.
//

import UIKit
import AsyncDisplayKit

class SetupViewController: ViewController {
    enum Mode {
        case person
        case result
    }
    
    var mode = Mode.person {
        didSet{
            self.view.endEditing(true)
        }
    }
    var personModel : [SetupModel] = []
    var resultModel : [SetupModel] = []
    
    lazy var headerNode : ASDisplayNode = {
        let node = ASDisplayNode()
        let bgNode = ASDisplayNode()
        let titleNode = ASTextNode()
        bgNode.backgroundColor = .init(hexString: "#e67ea3")
        titleNode.textContainerInset = .init(top: 20, left: 20, bottom: 20, right: 20)
        titleNode.attributedText = NSAttributedString(
            string: "게임설명",
            attributes: [.font: UIFont.boldSystemFont(ofSize: 12),
                         .foregroundColor : UIColor.white,
            ])
        node.automaticallyManagesSubnodes = true
        node.automaticallyRelayoutOnSafeAreaChanges = true
        node.layoutSpecBlock = { [weak self] (_, _) in
            guard let self = self else { return ASLayoutSpec() }
            return ASBackgroundLayoutSpec(
                child : ASCenterLayoutSpec(
                    centeringOptions: .XY,
                    sizingOptions: .minimumXY,
                    child: titleNode),
                background : bgNode.styled({
                    $0.flexShrink = 1.0
                    $0.flexGrow = 1.0
                    $0.height = .init(unit: .points,value: 20)
                })
            )
        }
        return node
    }()
    
    lazy var titleNode : ASTextNode = {
        let node = ASTextNode()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        node.attributedText = NSAttributedString(
            string: "인원수",
            attributes: [.font: UIFont.boldSystemFont(ofSize: 12),
                         .foregroundColor : UIColor.white,
                         .paragraphStyle : paragraphStyle,
            ])
        node.borderColor = UIColor.black.cgColor
        node.borderWidth = 0.5
        return node
    }()
    
    lazy var inputNode : ASEditableTextNode = {
        let node = ASEditableTextNode()
        node.backgroundColor = UIColor.white
        node.borderColor = UIColor.black.cgColor
        node.borderWidth = 0.5
        node.delegate = self
        node.keyboardType = .numberPad
        return node
    }()
    
    lazy var footerNode : ASButtonNode = {
        let node = ASButtonNode()
        node.backgroundColor = UIColor.yellow
        node.style.height = .init(unit: .points, value: 20)
        node.setTitle("시작", with: nil, with: .blue, for: .normal)
        node.borderWidth = 1
        return node
    }()
    
    lazy var collectionNode : CollectionNode<SetupModel,SetupCellNode> = {
        let node = CollectionNode<SetupModel,SetupCellNode>()
        return node
    }()
    
    lazy var contentsNode : ASDisplayNode = {
        let node = ASDisplayNode()
        
        var headerLayoutSpec : ASLayoutSpec = {
            return ASStackLayoutSpec(
                direction: .horizontal,
                spacing: 0,
                justifyContent: .spaceBetween,
                alignItems: .stretch,
                children: [
                    self.titleNode.styled {
                        $0.flexGrow = 0.5
                        $0.flexShrink = 0.5
                        $0.height = .init(unit: .points, value: 20)
                    },
                    self.inputNode.styled({
//                        $0.width  = .init(unit: .points, value: 100)
                        $0.flexGrow = 0.5
                        $0.flexShrink = 0.5
                        $0.height = .init(unit: .fraction, value: 20)
                    }),
                ]
            )
        }()
        
        node.backgroundColor = .init(hexString: "#8c79b4")
        node.automaticallyManagesSubnodes = true
        node.automaticallyRelayoutOnSafeAreaChanges = true
        node.automaticallyRelayoutOnLayoutMarginsChanges = true
        node.layoutSpecBlock = { [weak self] (_,_)in
            guard let self = self else {
                return ASLayoutSpec()
            }
            return ASInsetLayoutSpec(
                insets: .init(top: 0, left: 20, bottom: 0, right: 20),
                child: ASStackLayoutSpec(
                    direction: .vertical,
                    spacing: 0,
                    justifyContent: .spaceBetween,
                    alignItems: .stretch,
                    children: [
                        headerLayoutSpec,
                        // TODO: collectionNode 대체 자리
                        self.collectionNode.styled({
                            $0.flexGrow = 1
                            $0.flexShrink = 1
                        }).setBackgroundColor(color: UIColor.white),
                        self.footerNode,
                    ]
                    )
                    
            )
        }
        
        return node
    }()
    
    override init(node: ASDisplayNode) {
        super.init(node: node)
        
        self.node.layoutSpecBlock = { [weak self] (_,_) in
            guard let self = self else {
                return ASLayoutSpec()
            }
            let separator = ASDisplayNode()
            separator.style.height = .init(unit: .points, value: 8)
            separator.backgroundColor = UIColor.separator
            return ASInsetLayoutSpec(
                insets  : self.node.safeAreaInsets,
                child   : ASStackLayoutSpec(
                    direction: .vertical,
                    spacing: 0,
                    justifyContent: .spaceBetween,
                    alignItems: .stretch,
                    children: [
                        self.headerNode,
                        separator,
                        self.contentsNode.styled({
                            $0.flexShrink = 1.0
                            $0.flexGrow = 1.0
                        }),
                    ])
            )
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true

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
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    @objc func create() {
        let number = (inputNode.attributedText?.string.intValue ?? 0 ) as Int
        switch self.mode {
        case .person:
            personModel.removeAll()
            for index in 0 ..< number
            {
                personModel.append(SetupModel(type: "이름", name: "사람\(index+1)"))
            }
            collectionNode.model = personModel
            
        case .result:
            collectionNode.model = resultModel
        }
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
