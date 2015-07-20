//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Michael Recachinas on 7/12/15.
//  Copyright (c) 2015 Michael Recachinas. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    @IBOutlet weak var stopButton: UIButton!
    
    var audioPlayer: AVAudioPlayer!
    var receivedAudio: RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    override func viewWillAppear(animated: Bool) {
        stopButton.hidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func playAudioWithRate(rate: Float, currentTime: NSTimeInterval = 0.0) {
        stopButton.hidden = false
        
        audioPlayer.stop()
        audioPlayer.rate = rate
        audioPlayer.currentTime = currentTime
        audioPlayer.play()
    }
    
    func playAudioWithPitch(pitch: Float, currentTime: NSTimeInterval = 0.0) {
        stopButton.hidden = false
        
        audioPlayer.stop()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)

        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    @IBAction func playSlowAudio(sender: UIButton) {
        audioEngine.stop()
        audioEngine.reset()
        playAudioWithRate(0.5)
    }
    
    @IBAction func playFastAudio(sender: UIButton) {
        audioEngine.stop()
        audioEngine.reset()
        playAudioWithRate(1.5)
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        audioEngine.stop()
        audioEngine.reset()
        playAudioWithPitch(1000)
    }
    
    @IBAction func playDarthVaderAudio(sender: UIButton) {
        audioEngine.stop()
        audioEngine.reset()
        playAudioWithPitch(-1000)
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        audioPlayer.stop()
        stopButton.hidden = true
    }
}
