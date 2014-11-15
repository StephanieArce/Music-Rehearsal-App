//
//  ViewController.swift
//  Music Rehearsal App
//
//  Created by VJ on 11/12/14.
//  Copyright (c) 2014 Rapp Team. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    // Button Controls
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    
    //Variables to calculate the duration of the mSong Clip and the Song Clip Info
    var timer = NSTimer()
    var timeElapsed = 1.000
    var userSongClipInfoArray = [String]()
    var soundClipDurationArray = [FloatLiteralType]()
    
    //Variables for Audio Player
    var audioPlayer: AVAudioPlayer?
    
    
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

    // Playing Audio when the Play button is pushed
    @IBAction func didPushPlayButton(sender: AnyObject) {
        if let path = NSBundle.mainBundle().pathForResource("Flume &amp", ofType: "mp3"){
            audioPlayer = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: path), fileTypeHint: "mp3", error: nil)
            
            if let sound = audioPlayer {
                sound.prepareToPlay()
                sound.play()
                println("Sound Played! :D")
            }
        }
        
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
    
    
    //Passes desires Sound Clip Name and Duration to the next UI window
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var savedSongSectionDuration = timeElapsed
        soundClipDurationArray.append(savedSongSectionDuration)
        
        let nextViewController = segue.destinationViewController as
        SavedSoundSectionsTableViewController
        nextViewController.userSongClipTimeArray = soundClipDurationArray
        
    }
    
}



