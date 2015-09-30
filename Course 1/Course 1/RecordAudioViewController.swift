//
//  ViewController.swift
//  Course 1
//
//  Created by Anas Belkhadir on 23/09/2015.
//  Copyright © 2015 Anas Belkhadir. All rights reserved.
//

import UIKit
import AVFoundation
class RecordAudioViewController: UIViewController, AVAudioRecorderDelegate {


    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var mricophone: UIButton!
    @IBOutlet weak var pause: UIButton!
    
    var audioRecorded:AVAudioRecorder!
    var recordedAudio:RecordedAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopButton.hidden = true
        pause.hidden = true
    }
    
    
    @IBAction func startRecording(sender: UIButton) {
        stopButton.hidden = false
        stopButton.enabled = true
        
        pause.hidden = false
        pause.enabled = true
        
        mricophone.enabled = false
        mricophone.hidden = true
        info.text = "Recording in progress"
        
        
        
        let recordingName = "my_audio.wav"
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        try! audioRecorded = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorded.meteringEnabled = true
        audioRecorded.delegate = self
        audioRecorded.prepareToRecord()
        audioRecorded.record()
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if(flag){
            let title = recorder.url.lastPathComponent
            recordedAudio = RecordedAudio(filePathUrl: recorder.url,title: title!)
            performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        }else{
            print("probleme occur while recording audio")
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "stopRecording"){
            let playSoundsVc:PlaySoundViewController = segue.destinationViewController as! PlaySoundViewController
            let data = sender as! RecordedAudio
            playSoundsVc.receiveAudio = data
            
        }
    }
    
    
    @IBAction func pauseAudio(sender: UIButton) {
        if(audioRecorded.recording){
            audioRecorded.pause()
            pause.setImage(UIImage(named: "resume"), forState: UIControlState.Normal)
        }else{
            audioRecorded.record()
            pause.setImage(UIImage(named: "pause"), forState: UIControlState.Normal)
        }
    }
    
    @IBAction func stopRecording(sender: UIButton) {
        audioRecorded.stop()
        
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        
        stopButton.enabled = false
        stopButton.hidden = true
        
        mricophone.enabled = true
        mricophone.hidden = false
        info.text = "Tap To Record"
        
        pause.enabled = false
        pause.hidden = true
        pause.setImage(UIImage(named: "pause"), forState: UIControlState.Normal)
        
        
    }
    
}

