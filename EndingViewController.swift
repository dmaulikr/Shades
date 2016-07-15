//
//  EndingViewController.swift
//  Shades
//
//  Created by Mike Chen on 2016-07-03.
//  Copyright © 2016 Jikai Chen. All rights reserved.
//

import UIKit

class EndingViewController: UIViewController {

    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var scoreLabel2: UILabel!
    
    var ending_score = Int()
    var highScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        scoreLabel2.text = "Score: \(ending_score)"
        let highScoreDefault = NSUserDefaults.standardUserDefaults()
        if(highScoreDefault.valueForKey("highScore") != nil){
            highScore = highScoreDefault.valueForKey("highScore") as! NSInteger!
        }
        
        highScoreLabel.text = ("Highscore: \(highScore)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
