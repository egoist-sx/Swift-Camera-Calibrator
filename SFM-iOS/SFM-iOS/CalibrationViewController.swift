//
//  CalibrationViewController.swift
//  SFM-iOS
//
//  Created by Xin Sun on 11/4/14.
//  Copyright (c) 2014 Xin Sun. All rights reserved.
//

import UIKit

class CalibrationViewController:CaptureViewController {
    
    @IBOutlet var captureBtn: UIButton!
    @IBOutlet var imageCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        imageCountLabel.text = "0"
    }
    
    @IBAction func captureImage(sender: AnyObject) {
        captureImage()
    }
    
    override func didCaptureImage() {
        imageCountLabel.text = String(imageCollection.count)
        //Specify the number of image you want to be used for calibration
        if imageCollection.count >= 10 {
            
            println("Enough image, start calibration")
            calibrateCamera()
        }
    }
    
    func calibrateCamera() {
        CVWrapper.calibrateWithImageArray(imageCollection)
        println("Start calibrating camera");
    }
}