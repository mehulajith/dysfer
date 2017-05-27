//
//  ViewController.swift
//  dsyfer
//
//  Created by Mehul Ajith on 5/27/17.
//  Copyright © 2017 Mehul Ajith. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
    
    var captureSession = AVCaptureSession()
    var sessionOutput = AVCapturePhotoOutput()
    var previewLayer = AVCaptureVideoPreviewLayer()
    
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var button: UIButton!

    override func viewWillAppear(_ animated: Bool) {
        
        let deviceSession = AVCaptureDeviceDiscoverySession(deviceTypes: [.builtInDuoCamera, .builtInTelephotoCamera,.builtInWideAngleCamera], mediaType: AVMediaTypeVideo, position: .back)
        
        for device in (deviceSession?.devices)! {
        
            if device.position == AVCaptureDevicePosition.front {
                
                do {
                    
                    let input = try AVCaptureDeviceInput(device: device)
                    
                    if captureSession.canAddInput(input){
                        captureSession.addInput(input)
                        
                        if captureSession.canAddOutput(sessionOutput) {
                            captureSession.addOutput(sessionOutput)
                            
                            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                            previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
                            previewLayer.connection.videoOrientation = .portrait
                            
                            cameraView.layer.addSublayer(previewLayer)
                            cameraView.addSubview(button)
                            
                            previewLayer.position = CGPoint(x: self.cameraView.frame.width / 2, y:  self.cameraView.frame.height / 2)
                            
                            previewLayer.bounds = cameraView.frame
                            captureSession.startRunning()
                        }
                    }
                    
                } catch let avError {
                    
                    print(avError)
                    
                }
                
            }
            
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func takePhoto(_ sender: UIButton) {
        
    }

}

