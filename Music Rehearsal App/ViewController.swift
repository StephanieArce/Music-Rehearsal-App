//
//  ViewController.swift
//  Music Rehearsal App
//
//  Created by VJ on 11/12/14.
//  Copyright (c) 2014 Rapp Team. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation

class ViewController: UIViewController {

    // Button Controls
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var musicProgressBar: UIProgressView!
    @IBOutlet weak var musicTimeTextLabel: UILabel!
    
    //Variables to calculate the duration of the mSong Clip and the Song Clip Info
    var timer = NSTimer()
    var timeElapsed = 1.000
    var userSongClipInfoArray = [String]()
    var soundClipDurationArray = [FloatLiteralType]()
    
    //Variables for Audio Player
    var audioPlayer: AVAudioPlayer!
    var audioTimeProgress = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readFileIntoAudioPLayer()
        audioTimeProgress = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "updateMyAudioProgress", userInfo: self, repeats: true)
            
        // Rounds out the Corners of Buttons
        self.startButton.layer.cornerRadius = 5.0
        self.stopButton.layer.cornerRadius = 5.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Audio Player progress bar and controls of pausing and playing the song.
    func readFileIntoAudioPLayer(){
        if let path = NSBundle.mainBundle().pathForResource("Flume &amp", ofType: "mp3"){
            self.audioPlayer = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: path), error: nil)
            audioPlayer.prepareToPlay()
        }
    }
    @IBAction func didPushPlayButton(sender: AnyObject) {
        audioPlayer.play()
        println("Music is Playing :DDD")
        
    }
    @IBAction func didPushPauseButton(sender: AnyObject) {
        if audioPlayer.playing {
            audioPlayer.pause()
            println("Sound Paused")
        }
    }
    func updateMyAudioProgress(){
        // This Function will update the progress bar and the the progress time for the particular 
        // piece of music that is being played.
        var timeProgress = Float(audioPlayer.currentTime / audioPlayer.duration)
        self.musicProgressBar.progress = timeProgress
        if  audioPlayer.playing{
            if audioPlayer.currentTime % 60 < 10 {
                musicTimeTextLabel.text = String(format: "%.0f:0%.0f", audioPlayer.currentTime / 60, audioPlayer.currentTime % 60)
            }else if audioPlayer.currentTime < 60 {
                musicTimeTextLabel.text = String(format: "0:%.0f", audioPlayer.currentTime)
            }else {
                musicTimeTextLabel.text = String(format: "%.0f:%.0f", audioPlayer.currentTime / 60, audioPlayer.currentTime % 60)
            }
        }
    }
    
   
    // Timer for the time elapsed when the person starts and stops the section of the song that
    // they want to save and modify later.
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



