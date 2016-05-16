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

    
    @IBOutlet weak var faceView: FaceView! { didSet { updateUI() } }
    
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
}

