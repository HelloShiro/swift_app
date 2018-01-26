//
//  ViewController.swift
//  CameraML
//
//  Created by SnoopyKing on 2017/11/10.
//  Copyright © 2017年 SnoopyKing. All rights reserved.
//

import UIKit
import AVKit
import Vision

class ViewController: UIViewController ,AVCaptureVideoDataOutputSampleBufferDelegate{

    @IBOutlet weak var lblMLMsg: UILabel!
    var lblText : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        //where we start up camera
        let captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo
        guard let captureDevice = AVCaptureDevice.default(for: .video) else{return}
        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else {return}
        captureSession.addInput(input)
        captureSession.startRunning()
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        view.layer.addSublayer(previewLayer)
        previewLayer.frame = view.frame
        
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession.addOutput(dataOutput)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
//        print("Camera was able to capture a frame ", Date())
                guard let pixelBuffer : CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {return}
                guard let model = try? VNCoreMLModel(for: Resnet50().model) else {return}
                let request = VNCoreMLRequest(model: model) { (finishedReq, error) in
                    //perhaps check the error
//                    print(finishedReq.results)
                    guard let results = finishedReq.results as? [VNClassificationObservation] else {return}
                    guard let firstObservation = results.first else {return}
//                    print(firstObservation.identifier,firstObservation.confidence)
                    DispatchQueue.main.async(){
                        UIApplication.shared.registerForRemoteNotifications()
                        let accuracy = Int((firstObservation.confidence)*100)
                        if accuracy > 30 && accuracy < 60{
                            self.lblMLMsg.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
                            self.lblMLMsg.text = "Looks like \"\(firstObservation.identifier)\"\n\(accuracy)%"
                        }else if accuracy >= 60{
                            self.lblMLMsg.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                            self.lblMLMsg.text = "Looks like \"\(firstObservation.identifier)\"\n\(accuracy)%"
                        }else{
                            self.lblMLMsg.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
                            self.lblMLMsg.text = "Looks like \"\(firstObservation.identifier)\"\n\(accuracy)%"
                        }
                    }
                }
                try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
        
    }


}

