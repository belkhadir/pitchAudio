//
//  PlaySoundViewController.swift
//  Course 1
//
//  Created by Anas Belkhadir on 24/09/2015.
//  Copyright © 2015 Anas Belkhadir. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {

    var audioPlayer: AVAudioPlayer!
    var receiveAudio: RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioPlayer = try! AVAudioPlayer(contentsOfURL: receiveAudio.filePathUrl)
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading: receiveAudio.filePathUrl)
    }
    
    func playAudioWithRate(rate: Float){
        audioEngine.reset()
        audioPlayer.stop()
        audioPlayer.currentTime = 0.0
        audioPlayer.rate = rate
        audioPlayer.play()
    }
    
    func stop(){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    @IBAction func slowly(sender: UIButton) {
        playAudioWithRate(0.5)
    }

    @IBAction func fast(sender: UIButton) {
        playAudioWithRate(2.0)
    }
    
    func playAudioWithAVariablePitch(pitch: Float){
        stop()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
    
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        audioPlayerNode.play()
    }
    
    @IBAction func playDarthVaderAudio(sender: UIButton) {
        playAudioWithAVariablePitch(-1000)
    }
    
    @IBAction func chipmunkAudio(sender: UIButton) {
     playAudioWithAVariablePitch(1000)
        
    }
    
    @IBAction func reverbAudio(sender: UIButton) {
        stop()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let reverb = AVAudioUnitReverb()
        audioEngine.attachNode(reverb)
        
        let delay = AVAudioUnitDelay()
        audioEngine.attachNode(delay)
        
        audioEngine.connect(audioPlayerNode, to: delay, format: nil)
        audioEngine.connect(delay, to: reverb, format: nil)
        audioEngine.connect(reverb, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        audioPlayerNode.play()

    }
    
    
    @IBAction func echoAudio(sender: UIButton) {
        stop()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let echo = AVAudioUnitDelay()
        echo.delayTime = NSTimeInterval(0.3)
        audioEngine.attachNode(echo)
        
        audioEngine.connect(audioPlayerNode, to: echo, format: nil)
        audioEngine.connect(echo, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        audioPlayerNode.play()
        
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()
    }
}
