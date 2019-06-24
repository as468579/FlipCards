//
//  Card.swift
//  FlipGame
//
//  Created by User18 on 2019/6/23.
//  Copyright © 2019 jackliu. All rights reserved.
//

import Foundation

class Card{
    let face: String
    
    // construct
    init(face: String){
        self.face = face
    }
    
    func getFace() -> String{
        return face
    }
}
