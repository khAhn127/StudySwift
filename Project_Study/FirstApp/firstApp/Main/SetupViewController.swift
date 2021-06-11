//
//  SetupViewController.swift
//  firstApp
//
//  Created by Quintet on 2021/06/11.
//

import UIKit
import AsyncDisplayKit

class SetupViewController: ViewController {
    
    override init(node: ASDisplayNode) {
        super.init(node: node)
        self.node.layoutSpecBlock = { [weak self] (_,_) in
            guard let self = self else {
                return ASLayoutSpec()
            }
            let node = ASDisplayNode()
            node.bounds = .infinite
            node.backgroundColor = UIColor.systemPink
            return ASInsetLayoutSpec(
                insets: .zero,
                child: node
            )
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
