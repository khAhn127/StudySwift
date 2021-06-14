//
//  SetupViewController.swift
//  firstApp
//
//  Created by Quintet on 2021/06/11.
//

import UIKit
import AsyncDisplayKit

class SetupViewController: ViewController {
    let contentsNode = ASDisplayNode()
    
    override init(node: ASDisplayNode) {
        super.init(node: node)
      
        self.contentsNode.backgroundColor = UIColor.systemPink
        self.node.layoutSpecBlock = { [weak self] (_,_) in
            guard let self = self else {
                return ASLayoutSpec()
            }
            return ASInsetLayoutSpec(
                insets  : .zero,
                child   : self.contentsNode
            )
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
