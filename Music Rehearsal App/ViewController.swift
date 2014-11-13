//
//  ViewController.swift
//  Music Rehearsal App
//
//  Created by VJ on 11/12/14.
//  Copyright (c) 2014 Rapp Team. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Button Controls
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    //Variables accessed to all functions
    var timer = NSTimer()
    var timeElapsed = 1.000
    
        override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
            
        // Rounds out the Corners of Buttons
        self.startButton.layer.cornerRadius = 5.0
        self.stopButton.layer.cornerRadius = 5.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   
    @IBAction func didPushStartButton(sender: AnyObject) {
        
        //NSTimer will update every 1 second
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "timeTracker", userInfo: NSDate(), repeats: true)
        
        //Let's the start button appear
        startButton.hidden = true
        stopButton.hidden = false
    }
  
    func timeTracker() {
        
        // This will keep track of the seconds passing by
        var elapsed = -(self.timer.userInfo as NSDate).timeIntervalSinceNow
        timeElapsed = elapsed
    }
    
    @IBAction func didPushStopButton(sender: AnyObject) {
        
        timer.invalidate() // Stops the timer from repeating
        
        startButton.hidden = false
        stopButton.hidden = true
        
        println("\(timeElapsed)")
        
    }
    
}



