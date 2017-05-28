//
//  OCRViewController.swift
//  dsyfer
//
//  Created by Mehul Ajith on 5/27/17.
//  Copyright © 2017 Mehul Ajith. All rights reserved.
//

import UIKit
import TesseractOCR

class OCRViewController: UIViewController {
    
    
    let image = UIImage()
    
    @IBOutlet weak var textView: UITextView!
    override func viewDidAppear(_ animated: Bool) {
        
        let imageData = UserDefaults.standard.object(forKey: "imageData")
        
        let yourImage = UIImage(data:imageData as! Data)
        
        let img = UIImage(cgImage: (yourImage?.cgImage!)!, scale: CGFloat(1.0), orientation: .right)
        
    }

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

}
