//
//  WinnigModel.swift
//  firstApp
//
//  Created by Quintet on 2021/06/28.
//

import Foundation

struct WinningModel: Codable {
    var name :String?
    
    enum Codingkeys: Int,CodingKey{
        case name
    }
}
