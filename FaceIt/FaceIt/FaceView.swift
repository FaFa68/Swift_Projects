//
//  FaceView.swift
//  FaceIt
//
//  Created by Farshad Faradji on 13/05/16.
//  Copyright © 2016 FaFa. All rights reserved.
//

import UIKit

@IBDesignable

class FaceView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    @IBInspectable
    var scale :CGFloat = 0.90 { didSet { setNeedsDisplay()} }
     @IBInspectable
    var mouthCurvature: Double  = 1.0 { didSet { setNeedsDisplay()} } // 1 full smile , -1 full frown
     @IBInspectable
    var eyeOpen: Bool = true { didSet { setNeedsDisplay()} }
     @IBInspectable
    var eyeBrowTilt: Double = 0.0 { didSet { setNeedsDisplay()} }// -1 full furrow , 1 fully relaxed
     @IBInspectable
    var color : UIColor = UIColor.blueColor() { didSet { setNeedsDisplay()} }
     @IBInspectable
    var lineWidth: CGFloat = 5.0 { didSet { setNeedsDisplay()} }
     @IBInspectable
    var skullRadius : CGFloat{
        return min(bounds.size.width, bounds.size.height)/2 * scale
    }
    @IBInspectable
    var skullCenter : CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    private struct Ratios {
        static let SkullRadiusToEyeOffset: CGFloat = 3
        static let SkullRadiusToEyeRadius: CGFloat = 10
        static let SkullRadiusToMouthWidth : CGFloat = 1
        static let SkullRadiusToMouthHeight : CGFloat = 3
        static let SkullRadiusToMouthOffset: CGFloat = 3
        static let SkullRadiusToBrowOffset: CGFloat = 5
    }
    
    private enum Eye {
        case Left
        case Right
    }
    
    private func pathForCircleCenteredAtPoint(midPoint: CGPoint , withRadius radius: CGFloat) -> UIBezierPath {
        
        let path = UIBezierPath(
            arcCenter: midPoint,
            radius: radius,
            startAngle: 0.0,
            endAngle: CGFloat(2*M_PI),
            clockwise: false)
        
        path.lineWidth = lineWidth
        
        return path
    }
    
    private func getEyeCenter(eye: Eye) -> CGPoint {
        
        let eyeOffset = skullRadius / Ratios.SkullRadiusToEyeOffset
        var eyeCenter = skullCenter
        eyeCenter.y -=  eyeOffset
        switch eye {
        case .Left: eyeCenter.x -= eyeOffset
        case .Right: eyeCenter.x += eyeOffset
        }
        return eyeCenter
    }
    
    private func pathForEye(eye : Eye) -> UIBezierPath {
        
        let eyeRadius = skullRadius / Ratios.SkullRadiusToEyeRadius
        let eyeCenter = getEyeCenter(eye)
        if  eyeOpen {
                return  pathForCircleCenteredAtPoint(eyeCenter, withRadius: eyeRadius)
        } else {
            let path = UIBezierPath()
            path.moveToPoint(CGPoint(x: eyeCenter.x - eyeRadius, y: eyeCenter.y))
            path.addLineToPoint(CGPoint(x: eyeCenter.x + eyeRadius, y: eyeCenter.y))
            path.lineWidth = lineWidth
            return path
        }
        
    }
    
    private func pathForMouth() -> UIBezierPath {
        
         let mouthWith = skullRadius / Ratios.SkullRadiusToMouthWidth
         let mouthHeight = skullRadius / Ratios.SkullRadiusToMouthHeight
         let mouthOffset = skullRadius / Ratios.SkullRadiusToMouthOffset
        
        let mouthRect = CGRect(x: skullCenter.x - mouthWith/2, y: skullCenter.y + mouthOffset, width: mouthWith, height: mouthHeight)
        
       
        
        let smileOffset = CGFloat(max(-1 , min(mouthCurvature , 1))) * mouthRect.height
        let start = CGPoint(x: mouthRect.minX, y: mouthRect.minY)
        let end = CGPoint(x: mouthRect.maxX, y: mouthRect.minY)
        let cp1 = CGPoint(x: mouthRect.minX + mouthRect.width / 3, y: mouthRect.minY + smileOffset)
        let cp2 = CGPoint(x: mouthRect.maxX - mouthRect.width / 3, y: mouthRect.minY + smileOffset)

        let path = UIBezierPath()
        path.moveToPoint(start)
        path.addCurveToPoint(end, controlPoint1: cp1, controlPoint2: cp2)
        path.lineWidth = lineWidth
        
        return path
    }
    
    private func pathForBrow(eye : Eye) -> UIBezierPath {
        var tilt = eyeBrowTilt
        switch eye {
        case .Left:tilt *= -1.0
        case .Right: break
        }
        var browCenter = getEyeCenter(eye)
        browCenter.y -= skullRadius / Ratios.SkullRadiusToBrowOffset
        let eyeRadius = skullRadius / Ratios.SkullRadiusToEyeRadius
        let tiltOffset = CGFloat(max(-1 , min(tilt,1))) * eyeRadius / 2
        let browStart = CGPoint(x: browCenter.x - eyeRadius, y: browCenter.y - tiltOffset)
        let browEnd = CGPoint(x: browCenter.x + eyeRadius, y: browCenter.y + tiltOffset)
        let path = UIBezierPath()
        path.moveToPoint(browStart)
        path.addLineToPoint(browEnd)
        path.lineWidth = lineWidth
        return path
        
    }
    
    
    override func drawRect(rect: CGRect) {
        
        //UIColor.blueColor().set()
        color.set()
        pathForCircleCenteredAtPoint(skullCenter, withRadius: skullRadius).stroke()
        pathForEye(.Left).stroke()
        pathForEye(.Right).stroke()
        pathForMouth().stroke()
        pathForBrow(.Left).stroke()
        pathForBrow(.Right).stroke()
    }
}