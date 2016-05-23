//
//  Emitions ViewController.swift
//  FaceIt
//
//  Created by Farshad Faradji on 20/05/16.
//  Copyright © 2016 FaFa. All rights reserved.
//

import UIKit

class Emitions_ViewController: UIViewController {

    private let emotionalFaces : Dictionary<String , FacialExpression> = [
        "Angry" :       FacialExpression(eyes: .Closed, eyeBrows: .Furrowed , mouth: .Frown),
        "Happy" :       FacialExpression(eyes: .Open , eyeBrows: .Normal , mouth: .Smile),
        "Worried" :     FacialExpression(eyes: .Open , eyeBrows: .Relaxed , mouth: .Smirk),
        "Mischievious" : FacialExpression(eyes: .Closed , eyeBrows: .Furrowed , mouth: .Grin),
    ] 

    /*
    // MARK: - Navigation

     In a storyboard-based application, you will often want to do a little preparation before navigation
        */
    
 override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
        var destinationVC = segue.destinationViewController
        if let navCon = destinationVC as? UINavigationController {
        destinationVC = navCon.visibleViewController ?? destinationVC
        }
        if let faceVc = destinationVC as? FaceViewController {
            if let identifier = segue.identifier {
                if let expression = emotionalFaces[identifier]{
                    faceVc.expression = expression
                    if let sendingButton = sender as? UIButton {
                        faceVc.navigationItem.title = sendingButton.currentTitle
                    }
                }
            }
        }
    }
}
