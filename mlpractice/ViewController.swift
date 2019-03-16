//
//  Copyright (c) 2018 Google Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import UIKit
import AVFoundation
import Firebase
import Vision
import SwiftyJSON
import Alamofire

let SEGUE_IDENTIFIER = "FRAME_TO_PHOTO"
typealias TextPhoto = (String, UIImage)

@IBDesignable


class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    @IBOutlet weak var imageView: UIImageView!
    
    let session = AVCaptureSession()
    var requests = [VNRequest]()
    
    var captureDevice: AVCaptureDevice!
    var shouldTakePhoto = false
    
    var textDetector: VisionTextDetector!
    var frameCount = 0
    
    var allIngredients: Array = Ingredients.ingredientArray
    //    var allIngredients: [String] = []
    //    var allIngredients: Array = ["mineral oil", "benzyl alcohol", "linalool"]
    
    var scannedWords = [String]()
    
    @IBOutlet weak var ingredientList: UITextView!
    @IBOutlet weak var textView2: UITextView!
    
    @IBOutlet weak var searchBox: UITextField!
    
    var screenWidth: CGFloat = UIScreen.main.bounds.size.width
    var screenHeight: CGFloat = UIScreen.main.bounds.size.height
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textDetector = Vision().textDetector()
        prepareCamera()
        searchBox.addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        setupKeyboardDismissRecognizer()
    }
    
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
    }
    
    private func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    
    func setupKeyboardDismissRecognizer(){
        let tapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(ViewController.dismissKeyboard))
        
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
        print(searchBox.text!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        startTextDetection()
    }
    
    func addRightButtonBarItem() {
        let rightButton = UIBarButtonItem(title: "Take", style: .plain, target: self, action: #selector(ViewController.cameraDidTouch))
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    // MARK: Navigation methods
    
    @objc func cameraDidTouch() {
        // Flip the photo bit to true so it triggers the photo action
        // in the captureOutput loop below
        shouldTakePhoto = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    // MARK: Camera methods
    
    // Create an AVCaptureSession and begin streaming
    func prepareCamera() {
        session.sessionPreset = AVCaptureSession.Preset.medium
        captureDevice = AVCaptureDevice.DiscoverySession(
            deviceTypes: [.builtInWideAngleCamera],
            mediaType: AVMediaType.video, position:
            AVCaptureDevice.Position.back
            ).devices.first
        beginSession()
    }
    
    // Begin an AVCaptureSession by findinding a device and creating a layer
    // to stream the frames to
    func beginSession() {
        //1
        session.sessionPreset = AVCaptureSession.Preset.photo
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        
        //2
        let deviceInput = try! AVCaptureDeviceInput(device: captureDevice!)
        let deviceOutput = AVCaptureVideoDataOutput()
        deviceOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_32BGRA)]
        deviceOutput.setSampleBufferDelegate(self, queue: DispatchQueue.global(qos: DispatchQoS.QoSClass.default))
        session.addInput(deviceInput)
        session.addOutput(deviceOutput)
        
        //3
        let imageLayer = AVCaptureVideoPreviewLayer(session: session)
        imageLayer.frame = imageView.bounds
        imageView.layer.addSublayer(imageLayer)
        imageLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        session.startRunning()
        
        
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.videoSettings = [
            ((kCVPixelBufferPixelFormatTypeKey as NSString) as String): NSNumber(value: kCVPixelFormatType_32BGRA)
        ]
        
        dataOutput.alwaysDiscardsLateVideoFrames = true
        
        if session.canAddOutput(dataOutput) {
            session.addOutput(dataOutput)
        }
        
        session.commitConfiguration()
        
        let queue = DispatchQueue(label: "captureQueue")
        dataOutput.setSampleBufferDelegate(self, queue: queue)
    }
    
    // Process frames only at a specific duration. This skips redundant frames and
    // avoids memory issues.
    func proccess(every: Int, callback: () -> Void) {
        frameCount = frameCount + 1
        // Process every nth frame
        if(frameCount % every == 0) {
            callback()
        }
    }
    
    // Combine all VisionText into one String
    private func flattenVisionText(visionText: [VisionText]?) -> String {
        var text = ""
        visionText?.forEach(){ vText in
            text += " " + vText.text
        }
        return text
    }
    
    // Detect text in a CMSampleBuffer by converting to a UIImage to determine orientation
    func detectText(in buffer: CMSampleBuffer, completion: @escaping (_ text: String, _ image: UIImage) -> Void) {
        if let image = buffer.toUIImage() {
            let viImage = image.toVisionImage()
            textDetector.detect(in: viImage) { (visionText, error) in
                completion(self.flattenVisionText(visionText: visionText), image)
            }
        }
    }
    
    // Take a photo and segue to PhotoCaptureViewControlelr
    func takePhoto(buffer: CMSampleBuffer) {
        shouldTakePhoto = false
        self.detectText(in: buffer) { text, image  in
            let tuple: TextPhoto = (text, image)
            self.performSegue(withIdentifier: SEGUE_IDENTIFIER, sender: tuple)
        }
    }
    
    func detectBarcode(in buffer: CMSampleBuffer, completion: @escaping (_ barcode: String) -> Void) {
        let metadata = VisionImageMetadata()
        let imageBarcode = VisionImage(buffer: buffer)
        imageBarcode.metadata = metadata
        let vision = Vision.vision()
        let barcodeDetector = vision.barcodeDetector()
        let format = VisionBarcodeFormat.all
        _ = VisionBarcodeDetectorOptions(formats: format)
        barcodeDetector.detect(in: imageBarcode) { (barcodes, error) in
            guard error == nil, let barcodes = barcodes, !barcodes.isEmpty else {
                // Error. You should also check the console for error messages.
                // ...
                return
            }
            for barcode in barcodes {
                completion(barcode.rawValue!)
            }
            // Detected and read barcodes
            // ...
        }
    }
    
    // MARK: AVCaptureVideoDataOutputSampleBufferDelegate
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        // Detect text every 45 frames
        proccess(every: 45) {
            if self.barcodeLbl.isSelected == false {
                self.detectText(in: sampleBuffer) { text, image in
                    self.ingredientList.text = text
                    self.parseIngredientList(text: text)
                }
                
            } else {
                self.detectBarcode(in: sampleBuffer, completion: { (barcode) in
                    print("***** BARCODE: \(barcode)")
                    self.textView2.text = "Barcode: \(barcode)"
                })
            }
            
        }
        
        if shouldTakePhoto {
            takePhoto(buffer: sampleBuffer)
        }
        
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        
        var requestOptions:[VNImageOption : Any] = [:]
        
        if let camData = CMGetAttachment(sampleBuffer, kCMSampleBufferAttachmentKey_CameraIntrinsicMatrix, nil) {
            requestOptions = [.cameraIntrinsics:camData]
        }
        
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: CGImagePropertyOrientation(rawValue: 6)!, options: requestOptions)
        
        do {
            try imageRequestHandler.perform(self.requests)
        } catch {
            print(error)
        }
    }
    
    
    @IBOutlet weak var skinnoVision: UILabel!
    
    @IBOutlet weak var barcodeLbl: UIButton!
    
    @IBAction func barcodeSelected(_ sender: Any) {
        barcodeLbl.isSelected = !barcodeLbl.isSelected
        
        if barcodeLbl.isSelected {
            skinnoVision.text = "BARCODE SCANNER"
            barcodeLbl.setTitle("barcode", for: .selected)
            textView2.backgroundColor = .skinnoBlue
            textView2.textColor = .skinnoGreen
            skinnoVision.backgroundColor = .skinnoBlue
            skinnoVision.textColor = .skinnoGreen
        } else {
            skinnoVision.text = "SKINNOVISION OCR"
            barcodeLbl.setTitle("text", for: .normal)
            textView2.backgroundColor = .skinnoGreen
            textView2.textColor = .skinnoBlue
            skinnoVision.backgroundColor = .skinnoGreen
            skinnoVision.textColor = .skinnoBlue
        }
    }
    
    func parseIngredientList(text: String) {
        let ingredientItem = text.lowercased()
        //        ingredientItem = ingredientItem.components(separatedBy: .whitespacesAndNewlines).joined() //remove special characters AND spaces
        
        if self.barcodeLbl.isSelected == false {
            
            for key in self.allIngredients {
                var modifiedKey = key.lowercased()
                let oldKey = modifiedKey
                modifiedKey = modifiedKey.components(separatedBy: .whitespacesAndNewlines).joined()
                
                if ingredientItem.range(of: modifiedKey) != nil {
                    if textView2.text.range(of: oldKey) == nil {
                        self.scannedWords.append(oldKey)
                        self.textView2.text = "ingredients: \(scannedWords.joined(separator: ", "))"
                        ViewController.newIngredient.list = scannedWords.joined(separator: ", ")
                    }
                }
            }
        }
    }
    
    @IBOutlet weak var resetBtn: UIButton!
    
    
    @IBAction func resetBtnPressed(_ sender: Any) {
        self.scannedWords = []
        self.textView2.text = ""
        ViewController.newIngredient.list = ""
    }
    
    struct ingredientScanned {
        var list: String
        init() {
            list = ""
        }
    }
    
    static var newIngredient = ingredientScanned()
    
    
    
    override func viewDidLayoutSubviews() {
        imageView.layer.sublayers?[0].frame = imageView.bounds
    }
    
    func startTextDetection() {
        let textRequest = VNDetectTextRectanglesRequest(completionHandler: self.detectTextHandler)
        textRequest.reportCharacterBoxes = true
        self.requests = [textRequest]
    }
    
    func detectTextHandler(request: VNRequest, error: Error?) {
        guard let observations = request.results else {
            print("no result")
            return
        }
        
        let result = observations.map({$0 as? VNTextObservation})
        
        DispatchQueue.main.async() {
            self.imageView.layer.sublayers?.removeSubrange(1...)
            for region in result {
                guard let rg = region else {
                    continue
                }
                
                self.highlightWord(box: rg)
                
                if let boxes = region?.characterBoxes {
                    for characterBox in boxes {
                        self.highlightLetters(box: characterBox)
                    }
                }
            }
        }
    }
    
    
    func highlightWord(box: VNTextObservation) {
        guard let boxes = box.characterBoxes else {
            return
        }
        
        var maxX: CGFloat = 9999.0
        var minX: CGFloat = 0.0
        var maxY: CGFloat = 9999.0
        var minY: CGFloat = 0.0
        
        for char in boxes {
            if char.bottomLeft.x < maxX {
                maxX = char.bottomLeft.x
            }
            if char.bottomRight.x > minX {
                minX = char.bottomRight.x
            }
            if char.bottomRight.y < maxY {
                maxY = char.bottomRight.y
            }
            if char.topRight.y > minY {
                minY = char.topRight.y
            }
        }
        
        let xCord = maxX * imageView.frame.size.width
        let yCord = (1 - minY) * imageView.frame.size.height
        let width = (minX - maxX) * imageView.frame.size.width
        let height = (minY - maxY) * imageView.frame.size.height
        
        let outline = CALayer()
        outline.frame = CGRect(x: xCord, y: yCord, width: width, height: height)
        outline.borderWidth = 2.0
        outline.borderColor = #colorLiteral(red: 0.7137254902, green: 0.9215686275, blue: 0.7411764706, alpha: 0.66)
        outline.backgroundColor = #colorLiteral(red: 0.7137254902, green: 0.9215686275, blue: 0.7411764706, alpha: 0.4335402397)
        
        if barcodeLbl.isSelected == false {
            imageView.layer.addSublayer(outline)
        }
        
    }
    
    func highlightLetters(box: VNRectangleObservation) {
        let xCord = box.topLeft.x * imageView.frame.size.width
        let yCord = (1 - box.topLeft.y) * imageView.frame.size.height
        let width = (box.topRight.x - box.bottomLeft.x) * imageView.frame.size.width
        let height = (box.topLeft.y - box.bottomLeft.y) * imageView.frame.size.height
        
        let outline = CALayer()
        outline.frame = CGRect(x: xCord, y: yCord, width: width, height: height)
        outline.borderWidth = 0.0
        
        imageView.layer.addSublayer(outline)
    }
    
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
