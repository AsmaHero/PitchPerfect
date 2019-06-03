//
//  RecordSoundViewController.swift
//  PitchPerfect
//
//  Created by Asmahero on ٢٧ رجب، ١٤٤٠ هـ.
//  Copyright © ١٤٤٠ هـ Asmahero. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController {
    
    //MARK: extension recordsoundview properties of audio
    var recordedAudioURL : URL!
    var audioRecorder : AVAudioRecorder!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
   // MARK: Outlets
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    @IBOutlet weak var recordButton: UIButton!

    @IBOutlet weak var recordingLabel: UILabel!
    
    //MARK: viewDidLoad activity of app
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI(.notRecording)
    }
    //MARK: viewWillAppear activity of app
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //MARK: calling function of extension to record button
    @IBAction func recordAudio(_ sender: AnyObject) {
        recordSound()
    }
       //MARK: calling function of extension to stop button
    @IBAction func stopRecording(_ sender: Any) {
        stopAudio()
        recordingLabel.text = "Tap to Record"
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    //MARK: calling function when audio is finish recording to send audio

    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag
        {
            performSegue(withIdentifier: "StopRecording", sender: audioRecorder.url)
        }
        else
        {
            //if something wrong with recording showing alert
            showAlert("RecordingFailed", message: "recording was not successful")
        }
    }
    
       //MARK: calling function of moving to the second view when recording is finish to store it
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StopRecording"
        {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
}
