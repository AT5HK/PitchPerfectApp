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
    
    func stopAndResetAudio() {
        stopButton.hidden = false
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    func playAudioWithRate(rate: Float, currentTime: NSTimeInterval = 0.0) {
        stopAndResetAudio()
        audioPlayer.rate = rate
        audioPlayer.currentTime = currentTime
        audioPlayer.play()
    }

    func setUpAndAttachEngine(effect: AVAudioUnit) {
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        audioEngine.attachNode(effect)
        audioEngine.connect(audioPlayerNode, to: effect, format: nil)
        audioEngine.connect(effect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    func playAudioWithPitch(pitch: Float, currentTime: NSTimeInterval = 0.0) {
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        setUpAndAttachEngine(changePitchEffect)
    }
    
    func playAudioWithReverb(reverb: Float, currentTime: NSTimeInterval = 0.0) {
        let preset = AVAudioUnitReverbPreset(rawValue: 0)
        var reverbEffect = AVAudioUnitReverb()
        reverbEffect.loadFactoryPreset(preset!)
        reverbEffect.wetDryMix = reverb
        setUpAndAttachEngine(reverbEffect)
    }
    
    @IBAction func playSlowAudio(sender: UIButton) {
        stopAndResetAudio()
        playAudioWithRate(0.5)
    }
    
    @IBAction func playFastAudio(sender: UIButton) {
        stopAndResetAudio()
        playAudioWithRate(1.5)
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        stopAndResetAudio()
        playAudioWithPitch(1000)
    }
    
    @IBAction func playDarthVaderAudio(sender: UIButton) {
        stopAndResetAudio()
        playAudioWithPitch(-1000)
    }
    
    @IBAction func playReverbAudio(sender: UIButton) {
        stopAndResetAudio()
        playAudioWithReverb(50.0)
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        audioPlayer.stop()
        stopButton.hidden = true
    }
}
