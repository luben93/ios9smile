//
//  FaceView.swift
//  smile
//
//  Created by lucas persson on 2016-11-09.
//  Copyright © 2016 lucas persson. All rights reserved.
//

import UIKit

class FaceView: UIView {
    
    var scale: CGFloat = 0.90
    let mouthCurvature: Double = 1.0

    private var skullRadius: CGFloat {
        return min(bounds.size.width,bounds.size.height) / 2 * scale
    }
    private var skullCenter: CGPoint {
        return CGPoint(x: bounds.midX,y:bounds.midY)
    }
    
    private struct Ratios {
        static let SkullRaidusToEyeOffset:  CGFloat = 3
        static let SkullRaidusToEyeRadius:   CGFloat = 10
        static let SkullRaidusToMouthWidth:  CGFloat = 1
        static let SkullRaidusToMouthHeight: CGFloat = 3
        static let SkullRaidusToMouthOffset: CGFloat = 3
    }
    
    private enum Eye {
        case Left
        case Right
    }
    
    private func pathForCircleCenterdAtPoint( midPoint: CGPoint,radius withRadius: CGFloat) -> UIBezierPath {
        let path =  UIBezierPath(arcCenter: midPoint,radius: withRadius, startAngle: 0.0, endAngle: CGFloat(2*M_PI), clockwise: false)
        path.lineWidth = 5.0
        return path
    }
    
    private func pathForMouth() -> UIBezierPath{
        let mouthWidth = skullRadius / Ratios.SkullRaidusToMouthWidth
        let mouthHeight = skullRadius / Ratios.SkullRaidusToMouthHeight
        let mouthOffset = skullRadius / Ratios.SkullRaidusToMouthOffset
        
        let mouthRect = CGRect(x: skullCenter.x - mouthWidth/2, y: skullCenter.y +  mouthOffset, width: mouthWidth, height: mouthHeight)
      //  return UIBezierPath(rect: mouthRect)
        
        
        let smileOffset = CGFloat(max(-1,min(mouthCurvature,1))) * mouthRect.height
        let start = CGPoint(x: mouthRect.minX, y: mouthRect.minY)
        let end = CGPoint(x: mouthRect.maxX, y: mouthRect.minY)
        let cp1 = CGPoint(x: mouthRect.minX + mouthRect.width / 3 , y: mouthRect.minY + smileOffset)
        let cp2 = CGPoint(x: mouthRect.maxX - mouthRect.width / 3, y: mouthRect.minY + smileOffset)
        
        let path = UIBezierPath()
        path.move(to: start)
        path.addCurve(to: end,controlPoint1: cp1,controlPoint2: cp2)
        path.lineWidth = 5.0
        
        return path
    }
    
    private func getEyeCenter(_ eye: Eye) -> CGPoint {
        let eyeOffset = skullRadius / Ratios.SkullRaidusToEyeOffset
        var eyeCenter = skullCenter
        eyeCenter.y -= eyeOffset
        switch eye {
        case .Left:  eyeCenter.x -= eyeOffset
        case .Right: eyeCenter.x += eyeOffset
        }
        return eyeCenter
    }
    
    private func pathForEye(_ eye: Eye) -> UIBezierPath {
        let eyeRadius = skullRadius / Ratios.SkullRaidusToEyeRadius
        let eyeCenter = getEyeCenter(eye)
        return pathForCircleCenterdAtPoint(midPoint: eyeCenter, radius: eyeRadius)
    }
    
    //*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        UIColor.blue.set()
        pathForCircleCenterdAtPoint(midPoint: skullCenter, radius: skullRadius).stroke()
        pathForEye(.Left).stroke()
        pathForEye(.Right).stroke()
        pathForMouth().stroke()

    }
    //*/
    
    
    
}
