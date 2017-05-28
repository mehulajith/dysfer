//
//  OCRViewController.swift
//  dsyfer
//
//  Created by Mehul Ajith on 5/27/17.
//  Copyright © 2017 Mehul Ajith. All rights reserved.
//

import UIKit

class OCRViewController: UIViewController {
    
    let image = UIImage()
    
    override func viewDidAppear(_ animated: Bool) {
        
        let imageData = UserDefaults.standard.object(forKey: "imageData")
        
        let yourImage = UIImage(data:imageData as! Data)
        
        let img = UIImage(cgImage: (yourImage?.cgImage!)!, scale: CGFloat(1.0), orientation: .right)
        
        imageView.image = img
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

extension UIImage {
    func fixOrientation() -> UIImage {
        if self.imageOrientation == UIImageOrientation.up {
            return self
        }
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        if let normalizedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            return normalizedImage
        } else {
            return self
        }
    }
}
