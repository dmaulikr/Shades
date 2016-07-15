//
//  ViewController.swift
//  Shades
//
//  Created by Mike Chen on 2016-07-02.
//  Copyright © 2016 Jikai Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var button0: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var progressTimer: UIProgressView!
    
    
    var buttons = [UIButton]()
    var score = 0
    var highScore = 0
    var random_button = 0
    var random_red: CGFloat = 0
    var random_green: CGFloat = 0
    var random_blue: CGFloat = 0
    var progress : Float = 0.0
    var speed = 4.0
    var timer : NSTimer = NSTimer()
    var changeProgress : NSTimer = NSTimer()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        buttons.append(button0)
        buttons.append(button1)
        buttons.append(button2)
        buttons.append(button3)
        buttons.append(button4)
        buttons.append(button5)
        buttons.append(button6)
        buttons.append(button7)
        buttons.append(button8)
        
        changeColours()
        startTimer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func randomNumber() -> CGFloat {
        return CGFloat(Float(arc4random()) / Float(UINT32_MAX))
    }
    
    func randomButton() -> Int {
        return Int(arc4random_uniform(9))
    }
    
    func updateScore() {
        score += 1
        self.scoreLabel.text = "Score: \(score)"
    }
    
    func changeColours() {
        random_red = randomNumber()
        random_green = randomNumber()
        random_blue = randomNumber()
        random_button = randomButton()
        
        let colour = UIColor(red: random_red, green: random_green, blue: random_blue, alpha: 1.0)
        let colour_shade = UIColor(red: random_red, green: random_green, blue: random_blue, alpha: 0.8)
        
        for i in 0...8{
            buttons[i].backgroundColor = colour
        }

        buttons[random_button].backgroundColor = colour_shade
        progressTimer.progressTintColor = colour
        progressTimer.setProgress(1.0, animated: false)
    }
    
    @IBAction func button0_action(sender: UIButton) {
        if (sender.backgroundColor == buttons[random_button].backgroundColor){
            updateScore()
            changeColours()
            speedUpTimer()
            timer.invalidate()
            changeProgress.invalidate()
            progressTimer.setProgress(1.0, animated: false)
            progress = 0
            startTimer()
        }else{
            gameOver()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let DestViewController : EndingViewController = segue.destinationViewController as! EndingViewController
        
        DestViewController.ending_score = score
    }
    
    func startTimer(){
        timer = NSTimer.scheduledTimerWithTimeInterval(speed, target: self, selector : #selector(ViewController.gameOver), userInfo: nil, repeats: false)
        changeProgress = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: #selector (ViewController.updateProgress), userInfo: nil, repeats: true)
        
    }
    
    func speedUpTimer() {
        if speed > 0.85 {
            speed = speed * 0.9
        }
    }
    
    func gameOver(){
        timer.invalidate()
        changeProgress.invalidate()
        
        
        let highScoreDefault = NSUserDefaults.standardUserDefaults()
        
        if(highScoreDefault.valueForKey("highScore") != nil){
            highScore = highScoreDefault.valueForKey("highScore") as! NSInteger!
        }
        
        if (score > highScore){
            highScore = score
            highScoreDefault.setValue(highScore, forKey: "highScore")
            highScoreDefault.synchronize()
        }
        
        self.performSegueWithIdentifier("ToEndingSegue", sender: self)
    }
    
    func updateProgress(){
        progress += 0.01
        progressTimer.setProgress(1 - progress / Float(speed), animated: true)
    }
    
}

