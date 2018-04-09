//
//  ViewController.swift
//  Animate Examples
//
//  Created by John Gallaugher on 4/7/18.
//  Copyright © 2018 John Gallaugher. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!
    @IBOutlet weak var motivationImage: UIImageView!
    
    var originalFirstFrame: CGRect!
    var originalSecondX: CGFloat!
    var motivationNumber: UInt32 = 0
    var originalMotivationBounds: CGRect!
    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        originalFirstFrame = firstImageView.frame
        originalSecondX = secondImageView.frame.origin.x
        secondImageView.frame.origin.x = -secondImageView.frame.width
        originalMotivationBounds = motivationImage.bounds
    }
    
    func motivationZoomAndPlay() {
        playSound(soundName: "motivationSound\(motivationNumber)", audioPlayer: &audioPlayer)
        motivationImage.image = UIImage(named: "motivation\(motivationNumber)")
        
        let shrunkBounds = CGRect(x: 0, y: 0, width: 0, height: 0)
        motivationImage.bounds = shrunkBounds
        motivationImage.isHidden = false
        
        UIView.animate(withDuration: 1.0, animations: {self.motivationImage.bounds = self.originalMotivationBounds })
        
        //        if motivationNumber == 0 {
        //            motivationNumber = 1
        //        } else {
        //            motivationNumber = 0
        //        }
        
        motivationNumber = ( motivationNumber == 0 ? 1 : 0 )
    }
    
    func playSound(soundName: String, audioPlayer: inout AVAudioPlayer) {
        if let sound = NSDataAsset(name: soundName) {
            do {
                try audioPlayer = AVAudioPlayer(data: sound.data)
                audioPlayer.play()
            } catch {
                print("ERROR: Data from \(soundName) could not be played as an audio file")
            }
        } else {
            print("ERROR: Could not load data from file \(soundName)")
        }
    }

    
    @IBAction func resetPressed(_ sender: UIButton) {
        // No animation so it transitions to this state immediately
        firstImageView.frame = originalFirstFrame
        view.frame.origin.x = 0
        firstImageView.alpha = 1.0
        view.backgroundColor = UIColor.white
        secondImageView.frame.origin.x = -secondImageView.frame.width
    }
    
    @IBAction func changeBackgroundPressed(_ sender: UIButton) {
        UIView.animate(withDuration: 2.0, animations: {self.view.backgroundColor = UIColor.red})
    }
    
    @IBAction func loopLogoPressed(_ sender: UIButton) {
        
        if firstImageView.frame.origin.x > view.frame.width {
            firstImageView.frame.origin.x = -firstImageView.frame.width
        }
        
        UIView.animate(withDuration: 0.25, animations: {self.firstImageView.frame.origin.x += 100 })
    }
    
    @IBAction func flyInEagleWhenPressed(_ sender: UIButton) {
        UIView.animate(withDuration: 1.0, animations: {self.secondImageView.frame.origin.x = self.originalSecondX})
    }
    
    @IBAction func increaseBy60Pressed(_ sender: UIButton) {
        let newBounds = CGRect(x: firstImageView.bounds.origin.x - 60, y: firstImageView.bounds.origin.y - 60, width: firstImageView.bounds.width + 60, height: firstImageView.bounds.height + 60)
        
        UIView.animate(withDuration: 0.25, animations: {self.firstImageView.bounds = newBounds})
        
    }
    
    @IBAction func decreaseBy60Pressed(_ sender: UIButton) {
        let newBounds = CGRect(x: firstImageView.bounds.origin.x + 60, y: firstImageView.bounds.origin.y + 60, width: firstImageView.bounds.width - 60, height: firstImageView.bounds.height - 60)
        UIView.animate(withDuration: 0.25, animations: {self.firstImageView.bounds = newBounds})
    }
    
    @IBAction func pushImageRightPressed(_ sender: UIButton) {
        print("😡firstImageView.frame.origin.y = \(firstImageView.frame.origin.y)")
        print("😡firstImageView.bounds.origin.y = \(firstImageView.bounds.origin.y)")
        
        UIView.animate(withDuration: 1.0, animations: {self.firstImageView.frame.origin.x = self.view.frame.width})
    }
    
    @IBAction func slideScreenRightPressed(_ sender: UIButton) {
        UIView.animate(withDuration: 2.0, animations: {self.view.frame.origin.x += 100})
    }
    
    @IBAction func fadePressed(_ sender: UIButton) {
        UIView.animate(withDuration: 1.0, animations: {self.firstImageView.alpha = 0.0})
    }
    

    @IBAction func motivationTapped(_ sender: UITapGestureRecognizer) {
        motivationZoomAndPlay()
    }
    
    
    @IBAction func motivationButtonPressed(_ sender: UIButton) {
        motivationNumber = arc4random_uniform(2)
        motivationZoomAndPlay()
    }
    
}

