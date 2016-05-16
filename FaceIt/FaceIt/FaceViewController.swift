//
//  ViewController.swift
//  FaceIt
//
//  Created by Farshad Faradji on 13/05/16.
//  Copyright © 2016 FaFa. All rights reserved.
//

import UIKit

class FaceViewController: UIViewController {

//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }

    var expression = FacialExpression(eyes: .Open , eyeBrows: .Relaxed , mouth: .Smirk) { didSet { updateUI() } }

    
    @IBOutlet weak var faceView: FaceView! {
        
        didSet {
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(
                target: faceView, action: #selector(FaceView.changeScale(_:))
                ))
            
            let happierSwipeGestureRecognizer = UISwipeGestureRecognizer(
                target: self, action: #selector(FaceViewController.increaseHappiness)
            )
            happierSwipeGestureRecognizer.direction = .Up
            faceView.addGestureRecognizer(happierSwipeGestureRecognizer)
            
            
            let sadderSwipeGestureRecognizer = UISwipeGestureRecognizer(
                target: self, action: #selector(FaceViewController.decreaseHappiness)
            )
            sadderSwipeGestureRecognizer.direction = .Down
            faceView.addGestureRecognizer(sadderSwipeGestureRecognizer)

            updateUI()
        }
    }
    
    func increaseHappiness() {
        expression.mouth = expression.mouth.happierMouth()
    }
    
    func decreaseHappiness() {
        expression.mouth = expression.mouth.sadderMouth()
    }
    private var mouthCurvatures = [FacialExpression.Mouth.Frown : -1.0 ,
                                   .Smirk: -0.5 ,
                                   .Neutral: 0.0 ,
                                   .Grin: 0.5 ,
                                   .Smile: 1.0 ]
                                   

    private var eyeBroeTilt = [ FacialExpression.EyeBrows.Furrowed: -0.5 ,
                                .Relaxed:0.5 ,
                                .Normal:0.0]
    
    private func updateUI() {
        switch expression.eyes {
        case .Open:      faceView.eyeOpen = true
        case .Closed:    faceView.eyeOpen = false
        case .Squinting: faceView.eyeOpen = false
        }
        faceView.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
        faceView.eyeBrowTilt = eyeBroeTilt[expression.eyeBrows] ?? 0.0
    }
    @IBAction func toggleEyes(recognizer: UITapGestureRecognizer) {
        if recognizer.state == .Ended {     //If tap ended
            switch expression.eyes {
            case .Open: expression.eyes = .Closed
            case .Closed : expression.eyes = .Open
            case .Squinting: break
            }
        }
    }
}

