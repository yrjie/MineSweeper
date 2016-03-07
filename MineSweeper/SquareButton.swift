//
//  UIButton.swift
//  MineSweeper
//
//  Created by Yang, Ruijie on 9/28/15.
//  Copyright © 2015 Yang, Ruijie. All rights reserved.
//

import Foundation
import UIKit

class SquareButton : UIButton {
    let squareSize:CGFloat
    let squareMargin:CGFloat
    var square:Square
    
    init(squareModel:Square, squareSize:CGFloat, squareMargin:CGFloat){
        self.square = squareModel
        self.squareSize = squareSize
        self.squareMargin = squareMargin
        let x = CGFloat(self.square.col) * (squareSize + squareMargin)
        let y = CGFloat(self.square.row) * (squareSize + squareMargin)
        let squareFrame = CGRectMake(x, y, squareSize, squareSize)
        super.init(frame: squareFrame)
    }
    
    required init(coder aDecoder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    func getLabelText() -> String {
        // check the isMineLocation and numNeighboringMines properties to determine the text to display
        if !self.square.isMine {
            if self.square.numNeighboringMines == 0 {
                // case 1: there's no mine and no neighboring mines
                return ""
            }else {
                // case 2: there's no mine but there are neighboring mines
                return "\(self.square.numNeighboringMines)"
            }
        }
        // case 3: there's a mine
        return "M"
    }
    
}