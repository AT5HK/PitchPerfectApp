//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Michael Recachinas on 7/12/15.
//  Copyright (c) 2015 Michael Recachinas. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordingInProgress: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    var recordedAudio: RecordedAudio!
    var isPaused: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        audioStopped()
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func recordAudio(sender: UIButton) {
        recordButton.enabled = false
        recordingInProgress.text = "Recording in Progress"
        stopButton.hidden = false
        pauseButton.hidden = false
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] 
        let recordingName = "my_audio.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        
        let session = AVAudioSession.sharedInstance()
        
        do {
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        } catch _ {
            NSLog("Error occurred while trying to set the session as AVAudioSessionCategoryPlayAndRecord")
        }
        
        if let path = filePath {
            audioRecorder = try? AVAudioRecorder(URL: path, settings: [:])
            audioRecorder.delegate = self
            audioRecorder.meteringEnabled = true
            audioRecorder.prepareToRecord()
            audioRecorder.record()
        } else {
            NSLog("Error: The file path is non-existent.")
        }
    }

    func audioStopped() {
        recordButton.enabled = true
        stopButton.hidden = true
        pauseButton.hidden = true
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {

        if flag {
            recordedAudio = RecordedAudio(title: recorder.url.lastPathComponent!, filePathUrl: recorder.url)

            performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        } else {
            recordingInProgress.text = "Recording Not Successful"
            audioStopped()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC: PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! RecordedAudio
            playSoundsVC.receivedAudio = data
        }
    }
    
    @IBAction func stopRecording(sender: UIButton) {
        recordingInProgress.text = "Tap to Record"
        audioStopped()
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setActive(false)
        } catch _ {
            NSLog("Exception occurred while setting AudioSession.setActive(false)")
        }
    }
    
    @IBAction func pauseRecording(sender: UIButton) {
        if !isPaused {
            recordingInProgress.text = "Paused"
            audioRecorder.pause()
            pauseButton.setTitle("Resume", forState: UIControlState.Normal)
        } else {
            recordingInProgress.text = "Recording in Progress"
            audioRecorder.record()
            pauseButton.setTitle("Pause", forState: UIControlState.Normal)
        }
        isPaused = !isPaused
    }
}

