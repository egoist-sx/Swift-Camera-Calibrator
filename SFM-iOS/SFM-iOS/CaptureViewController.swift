//
//  CaptureViewController.swift
//  SFM-iOS
//
//  Created by Xin Sun on 11/4/14.
//  Copyright (c) 2014 Xin Sun. All rights reserved.
//

import UIKit
import AVFoundation

class CaptureViewController: UIViewController {

    var captureSession:AVCaptureSession?
    var previewLayer:AVCaptureVideoPreviewLayer?
    var captureDevice:AVCaptureDevice?
    var captureConnection:AVCaptureConnection?
    var stillImageOutput:AVCaptureStillImageOutput?
    var imageCollection:[UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setup() {
        initCaptureSessionWithPreset(AVCaptureSessionPreset1920x1080)
        initCaptureDeviceWithPosition(AVCaptureDevicePosition.Back)
        initPreviewLayerAndStillIamgeOutput()
        captureSession?.startRunning()
    }
    
    func initCaptureSessionWithPreset(preset:String) {
        captureSession = AVCaptureSession()
        captureSession?.sessionPreset = preset
    }
    
    func initCaptureDeviceWithPosition(position:AVCaptureDevicePosition) {
        let devices = AVCaptureDevice.devices()
        for device in devices {
            if device.hasMediaType(AVMediaTypeVideo) {
                if device.position == position {
                    captureDevice = device as? AVCaptureDevice
                    break
                }
            }
        }
        if captureDevice != nil {
            println("device found")
        }
    }
    
    func initPreviewLayerAndStillIamgeOutput() {
       
        var err:NSError? = nil
        captureSession?.addInput(AVCaptureDeviceInput(device: captureDevice, error: &err))
        if err != nil {
            println("err \(err?.localizedDescription)")
            return
        }
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.view.layer.insertSublayer(previewLayer, atIndex: 0)
        previewLayer?.frame = self.view.layer.frame
        
        
        let outputSetting = NSDictionary(dictionary: [AVVideoCodecKey: AVVideoCodecJPEG])
        stillImageOutput = AVCaptureStillImageOutput()
        stillImageOutput?.outputSettings = outputSetting
        
        captureSession?.addOutput(stillImageOutput)
        for connection:AVCaptureConnection in stillImageOutput?.connections as [AVCaptureConnection] {
            for port:AVCaptureInputPort in connection.inputPorts as [AVCaptureInputPort] {
                if port.mediaType == AVMediaTypeVideo {
                    captureConnection = connection as AVCaptureConnection
                    break
                }
                if captureConnection != nil {
                    break
                }
            }
            
        }
    }
    
    func captureImage() {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            if self.captureConnection != nil {
                self.stillImageOutput?.captureStillImageAsynchronouslyFromConnection(self.captureConnection, completionHandler: {
                    (imageSampleBuffer:CMSampleBuffer!,_) -> Void in
                    
                    let imageDataJpeg = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageSampleBuffer)
                    var image:UIImage = UIImage(data: imageDataJpeg)!
                    self.imageCollection.append(image)
                    self.didCaptureImage()
                    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
                    println("Image captured")
                    println("Current image count: \(self.imageCollection.count)")
                    
                })
            }
        })
    }
   
    func didCaptureImage() {
        
    }
    
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
