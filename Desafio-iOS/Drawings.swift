//
//  Drawings.swift
//  Desafio-iOS
//
//  Created by Rodrigo Cardoso on 15/05/16.
//  Copyright © 2016 Rodrigo Cardoso. All rights reserved.
//

import UIKit

//Utilizei o PaintCode para gerar essas classes.
//http://www.paintcodeapp.com

final public class Drawings:NSObject {
    
    public class func drawStar(frame frame: CGRect = CGRect(x: 0, y: 0, width: 50, height: 50), withColor color:UIColor) {
        //// Color Declarations
        let fillColor = color
        
        
        //// Subframes
        let group: CGRect = CGRect(x: frame.minX + floor(frame.width * 0.00000 + 0.5), y: frame.minY + floor(frame.height * 0.00000 + 0.5), width: floor(frame.width * 1.00000 + 0.5) - floor(frame.width * 0.00000 + 0.5), height: floor(frame.height * 1.00000 + 0.5) - floor(frame.height * 0.00000 + 0.5))
        
        
        //// Group
        //// Star 3 Drawing
        let star3Path = UIBezierPath()
        star3Path.moveToPoint(CGPoint(x: group.minX + 0.50000 * group.width, y: group.minY + 0.00000 * group.height))
        star3Path.addLineToPoint(CGPoint(x: group.minX + 0.66057 * group.width, y: group.minY + 0.27900 * group.height))
        star3Path.addLineToPoint(CGPoint(x: group.minX + 0.97553 * group.width, y: group.minY + 0.34549 * group.height))
        star3Path.addLineToPoint(CGPoint(x: group.minX + 0.75981 * group.width, y: group.minY + 0.58442 * group.height))
        star3Path.addLineToPoint(CGPoint(x: group.minX + 0.79389 * group.width, y: group.minY + 0.90451 * group.height))
        star3Path.addLineToPoint(CGPoint(x: group.minX + 0.50000 * group.width, y: group.minY + 0.77318 * group.height))
        star3Path.addLineToPoint(CGPoint(x: group.minX + 0.20611 * group.width, y: group.minY + 0.90451 * group.height))
        star3Path.addLineToPoint(CGPoint(x: group.minX + 0.24019 * group.width, y: group.minY + 0.58442 * group.height))
        star3Path.addLineToPoint(CGPoint(x: group.minX + 0.02447 * group.width, y: group.minY + 0.34549 * group.height))
        star3Path.addLineToPoint(CGPoint(x: group.minX + 0.33943 * group.width, y: group.minY + 0.27900 * group.height))
        star3Path.closePath()
        fillColor.setFill()
        star3Path.fill()
    }
    
    public class func drawFork(frame frame: CGRect = CGRect(x: 0, y: 0, width: 50, height: 50), withColor color:UIColor) {
        //// Color Declarations
        let fillColor = color
        
        
        //// Subframes
        let group: CGRect = CGRect(x: frame.minX + floor(frame.width * 0.09170 - 0.09) + 0.59, y: frame.minY + floor(frame.height * 0.00000 + 0.03) + 0.47, width: floor(frame.width * 0.89888 - 0.44) - floor(frame.width * 0.09170 - 0.09) + 0.36, height: floor(frame.height * 0.99058 + 0.5) - floor(frame.height * 0.00000 + 0.03) - 0.47)
        
        
        //// Group
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPoint(x: group.minX + 0.94532 * group.width, y: group.minY + 0.11980 * group.height))
        bezierPath.addCurveToPoint(CGPoint(x: group.minX + 0.81249 * group.width, y: group.minY + 0.08334 * group.height), controlPoint1: CGPoint(x: group.minX + 0.90885 * group.width, y: group.minY + 0.09549 * group.height), controlPoint2: CGPoint(x: group.minX + 0.86458 * group.width, y: group.minY + 0.08334 * group.height))
        bezierPath.addCurveToPoint(CGPoint(x: group.minX + 0.67970 * group.width, y: group.minY + 0.11980 * group.height), controlPoint1: CGPoint(x: group.minX + 0.76043 * group.width, y: group.minY + 0.08334 * group.height), controlPoint2: CGPoint(x: group.minX + 0.71616 * group.width, y: group.minY + 0.09549 * group.height))
        bezierPath.addCurveToPoint(CGPoint(x: group.minX + 0.62502 * group.width, y: group.minY + 0.20834 * group.height), controlPoint1: CGPoint(x: group.minX + 0.64325 * group.width, y: group.minY + 0.14410 * group.height), controlPoint2: CGPoint(x: group.minX + 0.62502 * group.width, y: group.minY + 0.17361 * group.height))
        bezierPath.addCurveToPoint(CGPoint(x: group.minX + 0.65039 * group.width, y: group.minY + 0.27116 * group.height), controlPoint1: CGPoint(x: group.minX + 0.62502 * group.width, y: group.minY + 0.23091 * group.height), controlPoint2: CGPoint(x: group.minX + 0.63346 * group.width, y: group.minY + 0.25185 * group.height))
        bezierPath.addCurveToPoint(CGPoint(x: group.minX + 0.71875 * group.width, y: group.minY + 0.31641 * group.height), controlPoint1: CGPoint(x: group.minX + 0.66731 * group.width, y: group.minY + 0.29048 * group.height), controlPoint2: CGPoint(x: group.minX + 0.69008 * group.width, y: group.minY + 0.30556 * group.height))
        bezierPath.addCurveToPoint(CGPoint(x: group.minX + 0.71047 * group.width, y: group.minY + 0.37598 * group.height), controlPoint1: CGPoint(x: group.minX + 0.71875 * group.width, y: group.minY + 0.33898 * group.height), controlPoint2: CGPoint(x: group.minX + 0.71599 * group.width, y: group.minY + 0.35884 * group.height))
        bezierPath.addCurveToPoint(CGPoint(x: group.minX + 0.68313 * group.width, y: group.minY + 0.42123 * group.height), controlPoint1: CGPoint(x: group.minX + 0.70492 * group.width, y: group.minY + 0.39312 * group.height), controlPoint2: CGPoint(x: group.minX + 0.69582 * group.width, y: group.minY + 0.40820 * group.height))
        bezierPath.addCurveToPoint(CGPoint(x: group.minX + 0.64356 * group.width, y: group.minY + 0.45443 * group.height), controlPoint1: CGPoint(x: group.minX + 0.67040 * group.width, y: group.minY + 0.43425 * group.height), controlPoint2: CGPoint(x: group.minX + 0.65725 * group.width, y: group.minY + 0.44531 * group.height))
        bezierPath.addCurveToPoint(CGPoint(x: group.minX + 0.58594 * group.width, y: group.minY + 0.48015 * group.height), controlPoint1: CGPoint(x: group.minX + 0.62988 * group.width, y: group.minY + 0.46355 * group.height), controlPoint2: CGPoint(x: group.minX + 0.61067 * group.width, y: group.minY + 0.47211 * group.height))
        bezierPath.addCurveToPoint(CGPoint(x: group.minX + 0.51709 * group.width, y: group.minY + 0.50033 * group.height), controlPoint1: CGPoint(x: group.minX + 0.56120 * group.width, y: group.minY + 0.48818 * group.height), controlPoint2: CGPoint(x: group.minX + 0.53824 * group.width, y: group.minY + 0.49490 * group.height))
        bezierPath.addCurveToPoint(CGPoint(x: group.minX + 0.43164 * group.width, y: group.minY + 0.51953 * group.height), controlPoint1: CGPoint(x: group.minX + 0.49593 * group.width, y: group.minY + 0.50575 * group.height), controlPoint2: CGPoint(x: group.minX + 0.46744 * group.width, y: group.minY + 0.51215 * group.height))
        bezierPath.addCurveToPoint(CGPoint(x: group.minX + 0.28125 * group.width, y: group.minY + 0.55664 * group.height), controlPoint1: CGPoint(x: group.minX + 0.36653 * group.width, y: group.minY + 0.53299 * group.height), controlPoint2: CGPoint(x: group.minX + 0.31641 * group.width, y: group.minY + 0.54535 * group.height))
        bezierPath.addLineToPoint(CGPoint(x: group.minX + 0.28125 * group.width, y: group.minY + 0.23307 * group.height))
        bezierPath.addCurveToPoint(CGPoint(x: group.minX + 0.34960 * group.width, y: group.minY + 0.18782 * group.height), controlPoint1: CGPoint(x: group.minX + 0.30989 * group.width, y: group.minY + 0.22222 * group.height), controlPoint2: CGPoint(x: group.minX + 0.33268 * group.width, y: group.minY + 0.20714 * group.height))
        bezierPath.addCurveToPoint(CGPoint(x: group.minX + 0.37499 * group.width, y: group.minY + 0.12500 * group.height), controlPoint1: CGPoint(x: group.minX + 0.36653 * group.width, y: group.minY + 0.16851 * group.height), controlPoint2: CGPoint(x: group.minX + 0.37499 * group.width, y: group.minY + 0.14756 * group.height))
        bezierPath.addCurveToPoint(CGPoint(x: group.minX + 0.32030 * group.width, y: group.minY + 0.03646 * group.height), controlPoint1: CGPoint(x: group.minX + 0.37499 * group.width, y: group.minY + 0.09028 * group.height), controlPoint2: CGPoint(x: group.minX + 0.35677 * group.width, y: group.minY + 0.06076 * group.height))
        bezierPath.addCurveToPoint(CGPoint(x: group.minX + 0.18750 * group.width, y: group.minY + 0.00000 * group.height), controlPoint1: CGPoint(x: group.minX + 0.28386 * group.width, y: group.minY + 0.01216 * group.height), controlPoint2: CGPoint(x: group.minX + 0.23959 * group.width, y: group.minY + 0.00000 * group.height))
        bezierPath.addCurveToPoint(CGPoint(x: group.minX + 0.05468 * group.width, y: group.minY + 0.03646 * group.height), controlPoint1: CGPoint(x: group.minX + 0.13541 * group.width, y: group.minY + 0.00000 * group.height), controlPoint2: CGPoint(x: group.minX + 0.09114 * group.width, y: group.minY + 0.01215 * group.height))
        bezierPath.addCurveToPoint(CGPoint(x: group.minX + 0.00000 * group.width, y: group.minY + 0.12500 * group.height), controlPoint1: CGPoint(x: group.minX + 0.01823 * group.width, y: group.minY + 0.06076 * group.height), controlPoint2: CGPoint(x: group.minX + 0.00000 * group.width, y: group.minY + 0.09028 * group.height))
        bezierPath.addCurveToPoint(CGPoint(x: group.minX + 0.02538 * group.width, y: group.minY + 0.18782 * group.height), controlPoint1: CGPoint(x: group.minX + 0.00000 * group.width, y: group.minY + 0.14756 * group.height), controlPoint2: CGPoint(x: group.minX + 0.00846 * group.width, y: group.minY + 0.16851 * group.height))
        bezierPath.addCurveToPoint(CGPoint(x: group.minX + 0.09374 * group.width, y: group.minY + 0.23307 * group.height), controlPoint1: CGPoint(x: group.minX + 0.04231 * group.width, y: group.minY + 0.20714 * group.height), controlPoint2: CGPoint(x: group.minX + 0.06509 * group.width, y: group.minY + 0.22222 * group.height))
        bezierPath.addLineToPoint(CGPoint(x: group.minX + 0.09374 * group.width, y: group.minY + 0.76693 * group.height))
        bezierPath.addCurveToPoint(CGPoint(x: group.minX + 0.02538 * group.width, y: group.minY + 0.81218 * group.height), controlPoint1: CGPoint(x: group.minX + 0.06509 * group.width, y: group.minY + 0.77777 * group.height), controlPoint2: CGPoint(x: group.minX + 0.04231 * group.width, y: group.minY + 0.79287 * group.height))
        bezierPath.addCurveToPoint(CGPoint(x: group.minX + 0.00000 * group.width, y: group.minY + 0.87501 * group.height), controlPoint1: CGPoint(x: group.minX + 0.00846 * group.width, y: group.minY + 0.83150 * group.height), controlPoint2: CGPoint(x: group.minX + 0.00000 * group.width, y: group.minY + 0.85245 * group.height))
        bezierPath.addCurveToPoint(CGPoint(x: group.minX + 0.05468 * group.width, y: group.minY + 0.96354 * group.height), controlPoint1: CGPoint(x: group.minX + 0.00000 * group.width, y: group.minY + 0.90973 * group.height), controlPoint2: CGPoint(x: group.minX + 0.01822 * group.width, y: group.minY + 0.93924 * group.height))
        bezierPath.addCurveToPoint(CGPoint(x: group.minX + 0.18750 * group.width, y: group.minY + 1.00000 * group.height), controlPoint1: CGPoint(x: group.minX + 0.09114 * group.width, y: group.minY + 0.98784 * group.height), controlPoint2: CGPoint(x: group.minX + 0.13542 * group.width, y: group.minY + 1.00000 * group.height))
        bezierPath.addCurveToPoint(CGPoint(x: group.minX + 0.32030 * group.width, y: group.minY + 0.96354 * group.height), controlPoint1: CGPoint(x: group.minX + 0.23958 * group.width, y: group.minY + 1.00000 * group.height), controlPoint2: CGPoint(x: group.minX + 0.28386 * group.width, y: group.minY + 0.98784 * group.height))
        bezierPath.addCurveToPoint(CGPoint(x: group.minX + 0.37499 * group.width, y: group.minY + 0.87501 * group.height), controlPoint1: CGPoint(x: group.minX + 0.35676 * group.width, y: group.minY + 0.93924 * group.height), controlPoint2: CGPoint(x: group.minX + 0.37499 * group.width, y: group.minY + 0.90973 * group.height))
        bezierPath.addCurveToPoint(CGPoint(x: group.minX + 0.34960 * group.width, y: group.minY + 0.81218 * group.height), controlPoint1: CGPoint(x: group.minX + 0.37499 * group.width, y: group.minY + 0.85245 * group.height), controlPoint2: CGPoint(x: group.minX + 0.36653 * group.width, y: group.minY + 0.83150 * group.height))
        bezierPath.addCurveToPoint(CGPoint(x: group.minX + 0.28125 * group.width, y: group.minY + 0.76693 * group.height), controlPoint1: CGPoint(x: group.minX + 0.33268 * group.width, y: group.minY + 0.79287 * group.height), controlPoint2: CGPoint(x: group.minX + 0.30989 * group.width, y: group.minY + 0.77777 * group.height))
        bezierPath.addLineToPoint(CGPoint(x: group.minX + 0.28125 * group.width, y: group.minY + 0.75001 * group.height))
        bezierPath.addCurveToPoint(CGPoint(x: group.minX + 0.32177 * group.width, y: group.minY + 0.68492 * group.height), controlPoint1: CGPoint(x: group.minX + 0.28125 * group.width, y: group.minY + 0.72006 * group.height), controlPoint2: CGPoint(x: group.minX + 0.29475 * group.width, y: group.minY + 0.69837 * group.height))
        bezierPath.addCurveToPoint(CGPoint(x: group.minX + 0.48730 * group.width, y: group.minY + 0.63869 * group.height), controlPoint1: CGPoint(x: group.minX + 0.34878 * group.width, y: group.minY + 0.67145 * group.height), controlPoint2: CGPoint(x: group.minX + 0.40396 * group.width, y: group.minY + 0.65604 * group.height))
        bezierPath.addCurveToPoint(CGPoint(x: group.minX + 0.68556 * group.width, y: group.minY + 0.58593 * group.height), controlPoint1: CGPoint(x: group.minX + 0.57520 * group.width, y: group.minY + 0.62002 * group.height), controlPoint2: CGPoint(x: group.minX + 0.64129 * group.width, y: group.minY + 0.60243 * group.height))
        bezierPath.addCurveToPoint(CGPoint(x: group.minX + 0.90625 * group.width, y: group.minY + 0.31641 * group.height), controlPoint1: CGPoint(x: group.minX + 0.83139 * group.width, y: group.minY + 0.53082 * group.height), controlPoint2: CGPoint(x: group.minX + 0.90496 * group.width, y: group.minY + 0.44098 * group.height))
        bezierPath.addCurveToPoint(CGPoint(x: group.minX + 0.97461 * group.width, y: group.minY + 0.27116 * group.height), controlPoint1: CGPoint(x: group.minX + 0.93492 * group.width, y: group.minY + 0.30556 * group.height), controlPoint2: CGPoint(x: group.minX + 0.95769 * group.width, y: group.minY + 0.29047 * group.height))
        bezierPath.addCurveToPoint(CGPoint(x: group.minX + 1.00000 * group.width, y: group.minY + 0.20834 * group.height), controlPoint1: CGPoint(x: group.minX + 0.99152 * group.width, y: group.minY + 0.25184 * group.height), controlPoint2: CGPoint(x: group.minX + 1.00000 * group.width, y: group.minY + 0.23090 * group.height))
        bezierPath.addCurveToPoint(CGPoint(x: group.minX + 0.94532 * group.width, y: group.minY + 0.11980 * group.height), controlPoint1: CGPoint(x: group.minX + 1.00001 * group.width, y: group.minY + 0.17361 * group.height), controlPoint2: CGPoint(x: group.minX + 0.98178 * group.width, y: group.minY + 0.14410 * group.height))
        bezierPath.closePath()
        bezierPath.moveToPoint(CGPoint(x: group.minX + 0.25392 * group.width, y: group.minY + 0.91930 * group.height))
        bezierPath.addCurveToPoint(CGPoint(x: group.minX + 0.18752 * group.width, y: group.minY + 0.93753 * group.height), controlPoint1: CGPoint(x: group.minX + 0.23568 * group.width, y: group.minY + 0.93145 * group.height), controlPoint2: CGPoint(x: group.minX + 0.21355 * group.width, y: group.minY + 0.93753 * group.height))
        bezierPath.addCurveToPoint(CGPoint(x: group.minX + 0.12110 * group.width, y: group.minY + 0.91930 * group.height), controlPoint1: CGPoint(x: group.minX + 0.16147 * group.width, y: group.minY + 0.93753 * group.height), controlPoint2: CGPoint(x: group.minX + 0.13933 * group.width, y: group.minY + 0.93145 * group.height))
        bezierPath.addCurveToPoint(CGPoint(x: group.minX + 0.09376 * group.width, y: group.minY + 0.87503 * group.height), controlPoint1: CGPoint(x: group.minX + 0.10288 * group.width, y: group.minY + 0.90715 * group.height), controlPoint2: CGPoint(x: group.minX + 0.09376 * group.width, y: group.minY + 0.89239 * group.height))
        bezierPath.addCurveToPoint(CGPoint(x: group.minX + 0.12110 * group.width, y: group.minY + 0.83075 * group.height), controlPoint1: CGPoint(x: group.minX + 0.09376 * group.width, y: group.minY + 0.85766 * group.height), controlPoint2: CGPoint(x: group.minX + 0.10287 * group.width, y: group.minY + 0.84291 * group.height))
        bezierPath.addCurveToPoint(CGPoint(x: group.minX + 0.18752 * group.width, y: group.minY + 0.81253 * group.height), controlPoint1: CGPoint(x: group.minX + 0.13933 * group.width, y: group.minY + 0.81860 * group.height), controlPoint2: CGPoint(x: group.minX + 0.16147 * group.width, y: group.minY + 0.81253 * group.height))
        bezierPath.addCurveToPoint(CGPoint(x: group.minX + 0.25392 * group.width, y: group.minY + 0.83075 * group.height), controlPoint1: CGPoint(x: group.minX + 0.21355 * group.width, y: group.minY + 0.81253 * group.height), controlPoint2: CGPoint(x: group.minX + 0.23569 * group.width, y: group.minY + 0.81861 * group.height))
        bezierPath.addCurveToPoint(CGPoint(x: group.minX + 0.28126 * group.width, y: group.minY + 0.87503 * group.height), controlPoint1: CGPoint(x: group.minX + 0.27215 * group.width, y: group.minY + 0.84291 * group.height), controlPoint2: CGPoint(x: group.minX + 0.28126 * group.width, y: group.minY + 0.85766 * group.height))
        bezierPath.addCurveToPoint(CGPoint(x: group.minX + 0.25392 * group.width, y: group.minY + 0.91930 * group.height), controlPoint1: CGPoint(x: group.minX + 0.28126 * group.width, y: group.minY + 0.89239 * group.height), controlPoint2: CGPoint(x: group.minX + 0.27215 * group.width, y: group.minY + 0.90715 * group.height))
        bezierPath.closePath()
        bezierPath.moveToPoint(CGPoint(x: group.minX + 0.25392 * group.width, y: group.minY + 0.16928 * group.height))
        bezierPath.addCurveToPoint(CGPoint(x: group.minX + 0.18752 * group.width, y: group.minY + 0.18750 * group.height), controlPoint1: CGPoint(x: group.minX + 0.23568 * group.width, y: group.minY + 0.18143 * group.height), controlPoint2: CGPoint(x: group.minX + 0.21355 * group.width, y: group.minY + 0.18750 * group.height))
        bezierPath.addCurveToPoint(CGPoint(x: group.minX + 0.12110 * group.width, y: group.minY + 0.16928 * group.height), controlPoint1: CGPoint(x: group.minX + 0.16147 * group.width, y: group.minY + 0.18750 * group.height), controlPoint2: CGPoint(x: group.minX + 0.13933 * group.width, y: group.minY + 0.18143 * group.height))
        bezierPath.addCurveToPoint(CGPoint(x: group.minX + 0.09376 * group.width, y: group.minY + 0.12500 * group.height), controlPoint1: CGPoint(x: group.minX + 0.10288 * group.width, y: group.minY + 0.15712 * group.height), controlPoint2: CGPoint(x: group.minX + 0.09376 * group.width, y: group.minY + 0.14237 * group.height))
        bezierPath.addCurveToPoint(CGPoint(x: group.minX + 0.12110 * group.width, y: group.minY + 0.08074 * group.height), controlPoint1: CGPoint(x: group.minX + 0.09376 * group.width, y: group.minY + 0.10764 * group.height), controlPoint2: CGPoint(x: group.minX + 0.10287 * group.width, y: group.minY + 0.09288 * group.height))
        bezierPath.addCurveToPoint(CGPoint(x: group.minX + 0.18752 * group.width, y: group.minY + 0.06251 * group.height), controlPoint1: CGPoint(x: group.minX + 0.13933 * group.width, y: group.minY + 0.06859 * group.height), controlPoint2: CGPoint(x: group.minX + 0.16147 * group.width, y: group.minY + 0.06251 * group.height))
        bezierPath.addCurveToPoint(CGPoint(x: group.minX + 0.25392 * group.width, y: group.minY + 0.08074 * group.height), controlPoint1: CGPoint(x: group.minX + 0.21355 * group.width, y: group.minY + 0.06251 * group.height), controlPoint2: CGPoint(x: group.minX + 0.23569 * group.width, y: group.minY + 0.06859 * group.height))
        bezierPath.addCurveToPoint(CGPoint(x: group.minX + 0.28126 * group.width, y: group.minY + 0.12500 * group.height), controlPoint1: CGPoint(x: group.minX + 0.27215 * group.width, y: group.minY + 0.09288 * group.height), controlPoint2: CGPoint(x: group.minX + 0.28126 * group.width, y: group.minY + 0.10764 * group.height))
        bezierPath.addCurveToPoint(CGPoint(x: group.minX + 0.25392 * group.width, y: group.minY + 0.16928 * group.height), controlPoint1: CGPoint(x: group.minX + 0.28126 * group.width, y: group.minY + 0.14237 * group.height), controlPoint2: CGPoint(x: group.minX + 0.27215 * group.width, y: group.minY + 0.15713 * group.height))
        bezierPath.closePath()
        bezierPath.moveToPoint(CGPoint(x: group.minX + 0.87891 * group.width, y: group.minY + 0.25261 * group.height))
        bezierPath.addCurveToPoint(CGPoint(x: group.minX + 0.81252 * group.width, y: group.minY + 0.27084 * group.height), controlPoint1: CGPoint(x: group.minX + 0.86068 * group.width, y: group.minY + 0.26476 * group.height), controlPoint2: CGPoint(x: group.minX + 0.83856 * group.width, y: group.minY + 0.27084 * group.height))
        bezierPath.addCurveToPoint(CGPoint(x: group.minX + 0.74611 * group.width, y: group.minY + 0.25261 * group.height), controlPoint1: CGPoint(x: group.minX + 0.78646 * group.width, y: group.minY + 0.27084 * group.height), controlPoint2: CGPoint(x: group.minX + 0.76432 * group.width, y: group.minY + 0.26476 * group.height))
        bezierPath.addCurveToPoint(CGPoint(x: group.minX + 0.71877 * group.width, y: group.minY + 0.20834 * group.height), controlPoint1: CGPoint(x: group.minX + 0.72789 * group.width, y: group.minY + 0.24047 * group.height), controlPoint2: CGPoint(x: group.minX + 0.71877 * group.width, y: group.minY + 0.22571 * group.height))
        bezierPath.addCurveToPoint(CGPoint(x: group.minX + 0.74611 * group.width, y: group.minY + 0.16407 * group.height), controlPoint1: CGPoint(x: group.minX + 0.71877 * group.width, y: group.minY + 0.19098 * group.height), controlPoint2: CGPoint(x: group.minX + 0.72789 * group.width, y: group.minY + 0.17623 * group.height))
        bezierPath.addCurveToPoint(CGPoint(x: group.minX + 0.81252 * group.width, y: group.minY + 0.14585 * group.height), controlPoint1: CGPoint(x: group.minX + 0.76434 * group.width, y: group.minY + 0.15192 * group.height), controlPoint2: CGPoint(x: group.minX + 0.78646 * group.width, y: group.minY + 0.14585 * group.height))
        bezierPath.addCurveToPoint(CGPoint(x: group.minX + 0.87891 * group.width, y: group.minY + 0.16407 * group.height), controlPoint1: CGPoint(x: group.minX + 0.83856 * group.width, y: group.minY + 0.14585 * group.height), controlPoint2: CGPoint(x: group.minX + 0.86068 * group.width, y: group.minY + 0.15192 * group.height))
        bezierPath.addCurveToPoint(CGPoint(x: group.minX + 0.90625 * group.width, y: group.minY + 0.20834 * group.height), controlPoint1: CGPoint(x: group.minX + 0.89713 * group.width, y: group.minY + 0.17622 * group.height), controlPoint2: CGPoint(x: group.minX + 0.90625 * group.width, y: group.minY + 0.19098 * group.height))
        bezierPath.addCurveToPoint(CGPoint(x: group.minX + 0.87891 * group.width, y: group.minY + 0.25261 * group.height), controlPoint1: CGPoint(x: group.minX + 0.90625 * group.width, y: group.minY + 0.22571 * group.height), controlPoint2: CGPoint(x: group.minX + 0.89715 * group.width, y: group.minY + 0.24047 * group.height))
        bezierPath.closePath()
        bezierPath.miterLimit = 4;
        
        fillColor.setFill()
        bezierPath.fill()
    }


}