//
//  StatusBarManager.swift
//  status-replacer
//
//  Created by Matteo Gavagnin on 05/12/14.
//  Copyright (c) 2014 MacTeo. All rights reserved.
//

import Foundation
import UIKit

public class StatusBarManager : NSObject, UIGestureRecognizerDelegate {
    var wifiReplacementView : UIView?
    var batteryReplacementView : UIImageView?
    var signalReplacementView : UIView?
    var timeLabel : UILabel?
    var fakeStatusVisible : Bool = false

    public class var sharedInstance : StatusBarManager {
        struct Static {
            static let instance : StatusBarManager = StatusBarManager()
        }
        return Static.instance
    }
    
    public override init() {
        super.init()
        if let status = statusBarView() {
            let gesture = UITapGestureRecognizer(target: self, action: Selector("handleGestureOnStatus:"))
            gesture.numberOfTouchesRequired = 1
            gesture.numberOfTapsRequired = 2
            gesture.delegate = self
            status.addGestureRecognizer(gesture)
        }
    }
    
    public func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func handleGestureOnStatus(gesture: UITapGestureRecognizer) {
        if gesture.state == .Ended {
            self.replaceStatusBar()
            
            //            if fakeStatusVisible {
            //                UIView.animateWithDuration(0.5, animations: { () -> Void in
            //                })
            //
            //                UIView.animateWithDuration(0.3, animations: { () -> Void in
            //                    self.window?.frame = UIScreen.mainScreen().bounds
            //                    if let status = self.statusBarView() {
            //                        status.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, 20);
            //                    }
            //                }, completion: { (completed) -> Void in
            //                    self.replaceStatusBar()
            //                })
            //            } else {
            //                UIView.animateWithDuration(0.5, animations: { () -> Void in
            //                    self.window?.frame = CGRectMake(0, 0, 320, 548)
            //                    if let status = self.statusBarView() {
            //                        status.frame = CGRectMake(0, 0, 320, 20);
            //                    }
            //                }, completion: { (completed) -> Void in
            //                        self.replaceStatusBar()
            //                })
            //            }
        }
    }
    
    
    func statusBarView() -> UIView? {
        let keyString = NSString(data: NSData(bytes: [0x73, 0x74, 0x61, 0x74, 0x75, 0x73, 0x42, 0x61, 0x72] as [Byte], length: 9), encoding: NSASCIIStringEncoding)
        var statusBar : UIView? = nil
        if let key = keyString {
            let app = UIApplication.sharedApplication()
            
            if app.respondsToSelector(NSSelectorFromString(key)) {
                statusBar = app.valueForKey(key) as? UIView
            }
        }
        return statusBar
    }
    
    public func replaceStatusBar () {
        if let status = statusBarView() {
            
            for subview in status.subviews {
                for subsubview in subview.subviews {
                    let style = UIApplication.sharedApplication().statusBarStyle
                    
                    if subsubview.isKindOfClass(NSClassFromString("UIStatusBarLocationItemView")) {
                        if let location = subsubview as? UIView {
                            if fakeStatusVisible {
                                location.hidden = false
                            } else {
                                location.hidden = true
                            }
                        }
                    }
                    if subsubview.isKindOfClass(NSClassFromString("UIStatusBarBluetoothItemView")) {
                        if let bluetooth = subsubview as? UIView {
                            if fakeStatusVisible {
                                bluetooth.hidden = false
                            } else {
                                bluetooth.hidden = true
                            }
                        }
                    }
                    
                    if subsubview.isKindOfClass(NSClassFromString("UIStatusBarBatteryPercentItemView")) {
                        if let batteryPercentage = subsubview as? UIView {
                            if fakeStatusVisible {
                                batteryPercentage.hidden = false
                            } else {
                                batteryPercentage.hidden = true
                            }
                        }
                    }
                    
                    if subsubview.isKindOfClass(NSClassFromString("UIStatusBarIndicatorItemView")) {
                        if let indicator = subsubview as? UIView {
                            if fakeStatusVisible {
                                indicator.hidden = false
                            } else {
                                indicator.hidden = true
                            }
                        }
                    }
                    
                    if subsubview.isKindOfClass(NSClassFromString("UIStatusBarServiceItemView")) {
                        if let service = subsubview as? UIView {
                            if fakeStatusVisible {
                                service.hidden = false
                            } else {
                                service.hidden = true
                            }
                        }
                    }
                    
                    var color = UIColor.blackColor()
                    if style == .LightContent {
                        color = UIColor.whiteColor()
                    }
                    
                    if subsubview.isKindOfClass(NSClassFromString("UIStatusBarBatteryItemView")) {
                        if let battery = subsubview as? UIView {
                            if batteryReplacementView == nil {
                                let scale = UIApplication.sharedApplication().windows[0].screen.scale;

                                if scale == 1 {
                                    batteryReplacementView = UIImageView(frame: CGRectMake(status.frame.size.width - 30, 0, 25, 20))
                                } else if scale == 2 {
                                    batteryReplacementView = UIImageView(frame: CGRectMake(status.frame.size.width - 30, 5.5, 24.5, 9.5))
                                } else if scale == 3 {
                                    batteryReplacementView = UIImageView(frame: CGRectMake(status.frame.size.width - 30, 5.4, 24.3, 9.6))
                                }
                                
                                batteryReplacementView!.image = UIImage(named: "battery")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
                                batteryReplacementView?.tintColor = color
                                batteryReplacementView?.contentMode = .Left
                                battery.superview?.addSubview(batteryReplacementView!)
                            }
                            
                            
                            if fakeStatusVisible {
                                battery.hidden = false
                                batteryReplacementView?.hidden = true
                            } else {
                                battery.hidden = true
                                batteryReplacementView?.hidden = false
                            }
                        }
                    }
                    
                    if subsubview.isKindOfClass(NSClassFromString("UIStatusBarDataNetworkItemView")) {
                        if let wifi = subsubview as? UIView {
                            if wifiReplacementView == nil {
                                wifiReplacementView = UIView(frame: CGRectMake(45.5, 0.5, 13, 20))
                                wifi.superview?.addSubview(wifiReplacementView!)
                                
                                //// Wifi Drawing
                                var wifiPath = UIBezierPath()
                                wifiPath.moveToPoint(CGPointMake(12.47, 12.02))
                                wifiPath.addCurveToPoint(CGPointMake(8.16, 13.57), controlPoint1: CGPointMake(10.83, 12.02), controlPoint2: CGPointMake(9.32, 12.66))
                                wifiPath.addLineToPoint(CGPointMake(12.47, 18.11))
                                wifiPath.addLineToPoint(CGPointMake(16.79, 13.58))
                                wifiPath.addCurveToPoint(CGPointMake(12.47, 12.02), controlPoint1: CGPointMake(15.62, 12.66), controlPoint2: CGPointMake(14.11, 12.02))
                                wifiPath.closePath()
                                wifiPath.moveToPoint(CGPointMake(12.64, 3.05))
                                wifiPath.addCurveToPoint(CGPointMake(23.31, 6.82), controlPoint1: CGPointMake(16.73, 3.05), controlPoint2: CGPointMake(20.46, 4.48))
                                wifiPath.addLineToPoint(CGPointMake(25.29, 4.74))
                                wifiPath.addCurveToPoint(CGPointMake(12.64, 0), controlPoint1: CGPointMake(21.91, 1.95), controlPoint2: CGPointMake(17.49, 0))
                                wifiPath.addCurveToPoint(CGPointMake(0, 4.73), controlPoint1: CGPointMake(7.79, 0), controlPoint2: CGPointMake(3.38, 1.95))
                                wifiPath.addLineToPoint(CGPointMake(1.98, 6.81))
                                wifiPath.addCurveToPoint(CGPointMake(12.64, 3.05), controlPoint1: CGPointMake(4.84, 4.47), controlPoint2: CGPointMake(8.56, 3.05))
                                wifiPath.closePath()
                                wifiPath.moveToPoint(CGPointMake(12.58, 9.06))
                                wifiPath.addCurveToPoint(CGPointMake(19, 11.29), controlPoint1: CGPointMake(15.03, 9.06), controlPoint2: CGPointMake(17.27, 9.9))
                                wifiPath.addLineToPoint(CGPointMake(21.1, 9.09))
                                wifiPath.addCurveToPoint(CGPointMake(12.58, 6.01), controlPoint1: CGPointMake(18.81, 7.23), controlPoint2: CGPointMake(15.84, 6.01))
                                wifiPath.addCurveToPoint(CGPointMake(4.08, 9.08), controlPoint1: CGPointMake(9.33, 6.01), controlPoint2: CGPointMake(6.36, 7.22))
                                wifiPath.addLineToPoint(CGPointMake(6.17, 11.29))
                                wifiPath.addCurveToPoint(CGPointMake(12.58, 9.06), controlPoint1: CGPointMake(7.9, 9.9), controlPoint2: CGPointMake(10.14, 9.06))
                                wifiPath.closePath()
                                wifiPath.miterLimit = 4;
                                
                                var wifiTransform = CGAffineTransformMakeTranslation(CGRectGetMidX(wifiReplacementView!.bounds) / 2.0, CGRectGetMidY(wifiReplacementView!.bounds) / 2.0)
                                wifiTransform = CGAffineTransformScale(wifiTransform, 0.5, 0.5)
                                wifiPath.applyTransform(wifiTransform)
                                
                                wifiPath.usesEvenOddFillRule = true;
                                
                                let wifiShapeLayer = CAShapeLayer()
                                wifiShapeLayer.lineWidth = 1.5
                                wifiShapeLayer.path = wifiPath.CGPath
                                wifiShapeLayer.fillColor = color.CGColor
                                wifiShapeLayer.strokeColor = UIColor.clearColor().CGColor
                                
                                wifiReplacementView!.layer.addSublayer(wifiShapeLayer)
                            }
                            
                            if fakeStatusVisible {
                                wifi.hidden = false
                                wifiReplacementView?.hidden = true
                            } else {
                                wifi.hidden = true
                                wifiReplacementView?.hidden = false
                            }
                        }
                    }
                    
                    if subsubview.isKindOfClass(NSClassFromString("UIStatusBarSignalStrengthItemView")) || subsubview.isKindOfClass(NSClassFromString("UIStatusBarServiceItemView")) {
                        if let signalView = subsubview as? UIView {
                            
                            if signalReplacementView == nil {
                                signalReplacementView = UIView(frame: CGRectMake(6.5, -0.5, 35, 20))
                                signalView.superview?.addSubview(signalReplacementView!)
                                
                                for i in 0..<5 {
                                    let x = CGFloat(7.0 * CGFloat(i))
                                    let path = UIBezierPath(ovalInRect: CGRectMake(x, 8, 5, 5))
                                    let shapePath = CAShapeLayer()
                                    shapePath.frame = signalReplacementView!.bounds
                                    shapePath.path = path.CGPath
                                    shapePath.lineWidth = 0.5
                                    shapePath.fillColor = color.CGColor
                                    shapePath.strokeColor = color.CGColor
                                    signalReplacementView!.layer.addSublayer(shapePath)
                                }
                            }
                            
                            if fakeStatusVisible {
                                signalView.hidden = false
                                signalReplacementView?.hidden = true
                            } else {
                                signalView.hidden = true
                                signalReplacementView?.hidden = false
                            }
                        }
                    }
                    
                    if subsubview.isKindOfClass(NSClassFromString("UIStatusBarTimeItemView")) {
                        if let timeView = subsubview as? UIView {
                            
                            
                            if timeLabel == nil {
                                timeLabel = UILabel(frame: CGRectMake(138, 0, 48, 20))
                                timeView.superview?.addSubview(timeLabel!)
                                
                                let helveticaNeue = NSDictionary(object: UIFont(name: "HelveticaNeue-Medium", size: 12.0)!,forKey: NSFontAttributeName)
                                let avenir = NSDictionary(objects: [UIFont(name: "AvenirNext-Medium", size: 14)!, 0.8], forKeys: [NSFontAttributeName, NSBaselineOffsetAttributeName])
                                
                                var attributedClock = NSMutableAttributedString(string:"9", attributes:helveticaNeue)
                                var colonString = NSMutableAttributedString(string:":", attributes:avenir)
                                var lastTimeString = NSMutableAttributedString(string:"41 AM", attributes:helveticaNeue)
                                
                                attributedClock.appendAttributedString(colonString)
                                attributedClock.appendAttributedString(lastTimeString)
                                
                                timeLabel?.attributedText = attributedClock
                                timeLabel?.center = CGPointMake(status.center.x + 1, status.center.y - 0.15)
                                timeLabel?.textColor = color
                                timeView.superview?.addSubview(timeLabel!)
                            }
                            
                            if fakeStatusVisible {
                                timeView.hidden = false
                                timeLabel?.hidden = true
                            } else {
                                timeView.hidden = true
                                timeLabel?.hidden = false
                            }
                            
                        }
                    }
                }
            }
            fakeStatusVisible = !fakeStatusVisible
        }
    }
}