//
//  CanvasViewController.swift
//  Canvas
//
//  Created by DINGKaile on 11/2/16.
//  Copyright © 2016 myPersonalProjects. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {

    @IBOutlet weak var trayView: UIView!
    
    var trayOriginalCenter: CGPoint!
    var gestureOriginalCenter: CGPoint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
            let translation = CGPoint(x: point.x-self.gestureOriginalCenter.x, y: point.y-self.gestureOriginalCenter.y)
            self.trayView.center = CGPoint(x: self.trayOriginalCenter.x, y: self.trayOriginalCenter.y + translation.y)
        } else if sender.state == .ended {
            print("Gesture ended at: \(point)")
        }
        
    }
    
    
    
    
    
    
    
    

}
