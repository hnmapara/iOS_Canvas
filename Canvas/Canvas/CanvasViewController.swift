//
//  CanvasViewController.swift
//  Canvas
//
//  Created by DINGKaile on 11/2/16.
//  Copyright © 2016 myPersonalProjects. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var trayView: UIView!
    
    var trayOriginalCenter: CGPoint!
    var gestureOriginalCenter: CGPoint!
    
    var openedLocation : CGPoint!
    var closedLocation : CGPoint!
    
    var velociyOfTray : CGPoint!
    
    var newFaceImage: UIImageView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //var heightDiff : CGFloat! = self.view.frame.height - trayView.frame.size.height
        let closedLocationY = trayView.frame.height/2.0 + self.view.frame.height - 35.0
        let openLocationY = self.view.frame.height - self.trayView.frame.height/2
        
        openedLocation = CGPoint(x: trayView.center.x, y: openLocationY)
        closedLocation = CGPoint(x: trayView.center.x, y: closedLocationY)
        
        trayView.center = closedLocation
        
        // Do any additional setup after loading the view.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
  
    @IBAction func onTrayGesture(_ sender: UIPanGestureRecognizer) {
        // Absolute (x,y) coordinates in parent view (parentView should be
        // the parent view of the tray)
        let point = sender.location(in: self.view)
        
        if sender.state == .began {
            print("Gesture began at: \(point)")
            self.trayOriginalCenter = self.trayView.center
            self.gestureOriginalCenter = point
            // self.trayOriginalCenter = point
        } else if sender.state == .changed {
            print("Gesture changed at: \(point)")
            velociyOfTray = sender.velocity(in: self.view)
            let translation = CGPoint(x: point.x-self.gestureOriginalCenter.x, y: point.y-self.gestureOriginalCenter.y)
            self.trayView.center = CGPoint(x: self.trayOriginalCenter.x, y: self.trayOriginalCenter.y + translation.y)
        } else if sender.state == .ended {
            print("Gesture ended at: \(point)")
            if velociyOfTray.y > 0 {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                        self.trayView.center = self.closedLocation
                    }, completion: { (Bool) in
                        
                })
//                UIView.animate(withDuration: 0.5, animations: {
//                    self.trayView.center = self.closedLocation
//                })
            } else if velociyOfTray.y < 0 {
//                UIView.animate(withDuration: 0.5, animations: {
//                    self.trayView.center = self.openedLocation
//                })
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                        self.trayView.center = self.openedLocation
                    }, completion: { (Bool) in
                        
                })

            }
            
        }
        
    }
    
    
    @IBAction func onTapGesture(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            if trayView.center.y > self.view.frame.height {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                    self.trayView.center = self.openedLocation
                    }, completion: { (Bool) in
                        
                })
            } else {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                    self.trayView.center = self.closedLocation
                    }, completion: { (Bool) in
                        
                })
            }

        }
    }
    
    
    
    @IBAction func onDrappedImage(_ sender: UIPanGestureRecognizer) {
        
        let point = sender.location(in: self.view)
        
        if sender.state == .began {
            print("Gesture began at: \(point)")
            let theImage = sender.view as! UIImageView
            self.newFaceImage = UIImageView(image: theImage.image!)
            self.newFaceImage.isUserInteractionEnabled = true
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(onPanHandler))
            panGesture.delegate = self
            self.newFaceImage.addGestureRecognizer(panGesture)
            self.view.addSubview(self.newFaceImage)
            self.newFaceImage.center = theImage.center
            
        } else if sender.state == .changed {
            self.newFaceImage.center = point
            
        } else if sender.state == .ended {
            
            
        }
        
    }
    
    
    func onPanHandler(sender: UIPanGestureRecognizer) {
        
        let point = sender.location(in: self.view)
        let newImageV = sender.view as! UIImageView
        
        if sender.state == .began {
            print("Gesture began at: \(point)")
            newImageV.center = point
            
        } else if sender.state == .changed {
            newImageV.center = point
            
        } else if sender.state == .ended {
            
            
        }
    }
    
    
    
    

}
