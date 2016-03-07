//
//  ViewController.swift
//  MineSweeper
//
//  Created by Yang, Ruijie on 9/28/15.
//  Copyright © 2015 Yang, Ruijie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var boardView: UIView!
    @IBOutlet weak var movesLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBAction func newGamePressed() {
        self.endCurrentGame()
        print("new game")
        self.startNewGame()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.initializeBoard()
        self.startNewGame()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let BOARD_SIZE:Int = 10
    var board:Board
    
    required init(coder aDecoder: NSCoder){
        self.board = Board(size: BOARD_SIZE)
        super.init(coder: aDecoder)
    }
    
    var squareButtons:[SquareButton] = []
    
    func initializeBoard() {
        for row in 0 ..< board.size {
            for col in 0 ..< board.size {
                let square = board.squares[row][col]
                let squareSize:CGFloat = self.boardView.frame.width / CGFloat(BOARD_SIZE)
                let squareButton = SquareButton(squareModel: square, squareSize: squareSize, squareMargin: 0);
                squareButton.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
                squareButton.addTarget(self, action: "squareButtonPressed:", forControlEvents: .TouchUpInside)
                self.boardView.addSubview(squareButton)
                self.squareButtons.append(squareButton)
            }
        }
    }
    
    func squareButtonPressed(sender: SquareButton) {
        print("Pressed row:\(sender.square.row), col:\(sender.square.col)")
//        sender.setTitle("", forState: .Normal)
        self.moves++
        if(!sender.square.isRevealed) {
            sender.square.isRevealed = true
            sender.setTitle("\(sender.getLabelText())", forState: .Normal)
        }
        if (sender.square.isMine){
            self.minePressed()
        }
    }
    
    func resetBoard() {
        // resets the board with new mine locations & sets isRevealed to false for each square
        self.board.resetBoard()
        // iterates through each button and resets the text to the default value
        for squareButton in self.squareButtons {
            squareButton.setTitle("[x]", forState: .Normal)
        }
    }
    
    func startNewGame() {
        //start new game
        self.resetBoard()
        self.moves = 0
        self.timeTaken = 0
        self.oneSecondTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("oneSecond"), userInfo: nil, repeats: true)
    }
    
    func minePressed(){
        // show an alert when you tap on a mine
        let alertView = UIAlertView()
        self.endCurrentGame()
        alertView.addButtonWithTitle("New Game")
        alertView.title = "BOOM!"
        alertView.message = "You tapped on a mine."
        alertView.show()
        alertView.delegate = self
    }
    
    func alertView(View: UIAlertView!, clickedButtonAtIndex buttonIndex: Int) {
        //start new game when the alert is dismissed
        self.startNewGame()
    }
    
    var moves:Int = 0 {
        didSet {
            self.movesLabel.text = "Moves: \(moves)"
            self.movesLabel.sizeToFit()
        }
    }
    var timeTaken:Int = 0  {
        didSet {
            self.timeLabel.text = "Time: \(timeTaken)"
            self.timeLabel.sizeToFit()
        }
    }
    
    var oneSecondTimer:NSTimer?
 
    func oneSecond() {
        self.timeTaken++
    }
    
    func endCurrentGame() {
        self.oneSecondTimer!.invalidate()
        self.oneSecondTimer = nil
    }
}

