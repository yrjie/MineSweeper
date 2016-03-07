//
//  Square.swift
//  MineSweeper
//
//  Created by Yang, Ruijie on 9/28/15.
//  Copyright © 2015 Yang, Ruijie. All rights reserved.
//

import Foundation

class Square {
    let row:Int
    let col:Int
    
    var numNeighboringMines = 0
    var isMine = false
    var isRevealed = false
    
    init(row:Int, col:Int){
        self.row = row
        self.col = col
    }
}