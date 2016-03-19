//
//  ViewController.swift
//  tapper
//
//  Created by Radu Tothazan on 08/03/16.
//  Copyright © 2016 radutot. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var maxTaps = 20
    var currentTaps = 0
    var Timer: NSTimer = NSTimer()
    var seconds: Int = 0
    var fractions: Int = 0
    var bestSeconds: Int = 1000000
    var bestFractions:Int = 0
    
    var newButtonX: CGFloat?
    var newButtonY: CGFloat?
    
    var timeString: String = ""

    @IBOutlet weak var infoLbl: UILabel!
    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var howManyTapsTxt: UITextField!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var bestLbl: UILabel!
    
    @IBOutlet weak var tapBtn: UIButton!
    @IBOutlet weak var tapsLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    
    @IBAction func onPlayBtnPressed(sender: UIButton!){
            
        logoImg.hidden = true
        playBtn.hidden = true
        bestLbl.hidden = true
        infoLbl.hidden = true
            
        tapBtn.hidden = false
        tapsLbl.hidden = false
        timeLbl.hidden = false
        currentTaps = 0
            
        updateTaps()
        timeLbl.text = "00.00"
   
    }
    @IBAction func onCoinTapped (sender: UIButton){
        
        coinButtonMove()
        currentTaps++
        if currentTaps == 1{
            Timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("UpdateTimer"), userInfo: nil, repeats: true)
        }
        updateTaps()
        if isGameOver(){
            restartGame()
        }
        
    }
    
    func coinButtonMove(){
        let buttonWidth = tapBtn.frame.width
        let buttonHeight = tapBtn.frame.height
        
        let viewWidth = tapBtn.superview!.bounds.width
        let viewHeight = tapBtn.superview!.bounds.height - 60
        
        let xwidth = viewWidth - buttonWidth
        let yheight = viewHeight - buttonHeight
        
        let xoffset = CGFloat(arc4random_uniform(UInt32(xwidth)))
        let yoffset = CGFloat(arc4random_uniform(UInt32(yheight)))
        
        newButtonX = xoffset + buttonWidth / 2
        newButtonY = yoffset + buttonHeight / 2
    }
    
    
    
    override func viewDidLayoutSubviews() {
        if let buttonX = newButtonX {
            tapBtn.center.x = buttonX
        }
        if let buttonY = newButtonY {
            tapBtn.center.y = buttonY
        }
    }
    
    func UpdateTimer(){
        fractions += 1
        if fractions == 100{
            seconds += 1
            fractions = 0
        }
        let fractionsString = fractions > 9 ? "\(fractions)" : "0\(fractions)"
        let secondsString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        
        timeString = "\(secondsString).\(fractionsString)"
        timeLbl.text = timeString
    }
    
    
    func updateTaps(){
        tapsLbl.text = "\(currentTaps) Taps"
    }
    
    func isGameOver() -> Bool{
        if currentTaps >= maxTaps{
            return true
        }else{
            return false
        }
    }
    
    func restartGame(){
        maxTaps = 20
        logoImg.hidden = false
        playBtn.hidden = false
        infoLbl.hidden = false
        bestLbl.hidden = false
        
        tapBtn.hidden = true
        tapsLbl.hidden = true
        timeLbl.hidden = true
        
        if NewBest(){
            bestSeconds = seconds
            bestFractions = fractions
        }
        bestLbl.text = "Best Time : \(bestSeconds). \(bestFractions)"
        
        Timer.invalidate()
        fractions = 0
        seconds = 0
        
    }
    
    func NewBest() -> Bool{
        if seconds > bestSeconds{
            return false
        }else if seconds == bestSeconds{
            if fractions >= bestFractions{
                return false
            }
        }
        return true
    }

}

