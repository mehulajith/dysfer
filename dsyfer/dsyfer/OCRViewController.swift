//
//  OCRViewController.swift
//  dsyfer
//
//  Created by Mehul Ajith on 5/27/17.
//  Copyright © 2017 Mehul Ajith. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class OCRViewController: UIViewController {
    
    
    let image = UIImage()
    var photo: UIImage!
    
    @IBOutlet weak var textView: UITextView!
    var googleApiKey = "AIzaSyC0gA9lgcdKGKa95nSuOIzxgVn1aqpB4vg"
    
    override func viewDidAppear(_ animated: Bool) {
        
        let imageData = UserDefaults.standard.object(forKey: "imageData")
        
        let yourImage = UIImage(data:imageData as! Data)
        
        let img = UIImage(cgImage: (yourImage?.cgImage!)!, scale: CGFloat(1.0), orientation: .right)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        detectText()

        
    }
    
    func  detectText () {
        
        let imageData = UserDefaults.standard.object(forKey: "imageData")
//
        let yourImage = UIImage(data:imageData as! Data)

//        let img = UIImage(cgImage: (yourImage?.cgImage!)!, scale: CGFloat(1.0), orientation: .right)
        
//        let image  = img
        
        let imagedata = UIImagePNGRepresentation(yourImage!)
        
        let  base64image = imagedata!.base64EncodedString(options: .endLineWithCarriageReturn)
        
        let request: Parameters = [
            "requests" :  [
                
                "image": [
                    
                    "content": base64image
                ] ,
                "features" : [
                    
                    "type": "TEXT_DETECTION",
                    "maxResults": 1
                ],
                "imageContext": [
                    
                    "languageHints": ["en"]
                    
                ]
            ]
        ]
        
        
        
        let httpHeader: HTTPHeaders = [
            "Content-Type" :  "application/json",
            "X-Ios-Bundle-Identifier" :  Bundle.main.bundleIdentifier ?? ""
        ]
        
        
        
        Alamofire.request("https://vision.googleapis.com/v1/images:annotate?key=\(googleApiKey)", method: .post , parameters: request, encoding: JSONEncoding.default ,headers: httpHeader).validate(statusCode: 200..<300).responseJSON {response in
            
            
            print("--Request--: ",response.request)
            print("--Response--: ",response.response)
            print("--Data--: ",response.data)
            print("--Result--: ",response.result)
            
<<<<<<< Updated upstream
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
            self.googleResult (response :  response )
            
            }.responseString { response in
                print("Success: \(response.result.isSuccess)")
                print("Response String: \(response.result.value)")
                print("Response Desc: \(response.result.description)")
                
                var statusCode = response.response?.statusCode
                if let error = response.result.error as? AFError {
                    statusCode = error._code // statusCode private
                    switch error {
                    case .invalidURL(let url):
                        print("Invalid URL: \(url) - \(error.localizedDescription)")
                    case .parameterEncodingFailed(let reason):
                        print("Parameter encoding failed: \(error.localizedDescription)")
                        print("Failure Reason: \(reason)")
                    case .multipartEncodingFailed(let reason):
                        print("Multipart encoding failed: \(error.localizedDescription)")
                        print("Failure Reason: \(reason)")
                    case .responseValidationFailed(let reason):
                        print("Response validation failed: \(error.localizedDescription)")
                        print("Failure Reason: \(reason)")
                        
                        switch reason {
                        case .dataFileNil, .dataFileReadFailed:
                            print("Downloaded file could not be read")
                        case .missingContentType(let acceptableContentTypes):
                            print("Content Type Missing: \(acceptableContentTypes)")
                        case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
                            print("Response content type: \(responseContentType) was unacceptable: \(acceptableContentTypes)")
                        case .unacceptableStatusCode(let code):
                            print("Response status code was unacceptable: \(code)")
                            statusCode = code
                        }
                    case .responseSerializationFailed(let reason):
                        print("Response serialization failed: \(error.localizedDescription)")
                        print("Failure Reason: \(reason)")
                        // statusCode = 3840 ???? maybe..
                    }
                    
                    print("Underlying error: \(error.underlyingError)")
                } else if let error = response.result.error as? URLError {
                    print("URLError occurred: \(error)")
                } else {
                    print("Unknown error: \(response.result.error)")
                }
=======
            textView.text = tesseract.recognizedText
        
>>>>>>> Stashed changes
        }
    }
    
    func  googleResult (response :  DataResponse<Any> ) {
        guard  let  result  = response.result.value else {
        
            return
        }
        let  json  = JSON (result)
        let  annotations :  JSON  = json [ "responses" ] [ 0 ] [ "textAnnotations" ]
        var  detectedText :  String  =  ""
        
        
        annotations.forEach { (_, annotation) in
            detectedText += annotation["description"].string!
            print("test: \(annotation["description"].string!)")
            
        }
        
        textView.text = detectedText
        
    }
    
}
