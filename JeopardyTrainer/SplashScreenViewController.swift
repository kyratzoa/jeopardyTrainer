//
//  SplashScreenViewController.swift
//  JeopardyTrainer
//
//  Created by Anastasia on 12/15/19.
//  Copyright © 2019 Anastasia. All rights reserved.
//

import UIKit
import AVFoundation

class SplashScreenViewController: UIViewController {
    @IBOutlet weak var logoImageView: UIImageView!
    
    var yAtLaunch: CGFloat = 0.0
    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        yAtLaunch = logoImageView.frame.origin.y
        logoImageView.frame.origin.y = self.view.frame.height
    }
    
    override func viewDidAppear(_ animated: Bool) {
        playSound(soundName: "jeopardy-intro", audioPlayer: &audioPlayer)
        UIView.animate(withDuration: 2.0, animations: {self.logoImageView.frame.origin.y = self.yAtLaunch})
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
    
    func playSound(soundName: String, audioPlayer: inout AVAudioPlayer){
        if let sound = NSDataAsset(name: soundName){
            do {
                try audioPlayer = AVAudioPlayer(data: sound.data)
                audioPlayer.play()
            } catch {
                print("ERROR: Could not play \(soundName)")
            }
        } else {
            print("ERROR: Counld not load \(soundName) file. ")
        }
    }

    
    @IBAction func logoTapped(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "ShowCategories", sender: nil)
    }
    
}
