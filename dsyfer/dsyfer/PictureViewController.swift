//
//  PictureViewController.swift
//  dsyfer
//
//  Created by Mehul Ajith on 5/27/17.
//  Copyright © 2017 Mehul Ajith. All rights reserved.
//

import UIKit

class PictureViewController: UIViewController,UIImagePickerControllerDelegate,UINavigatiovarntrollerDelegate {

    @IBOutlet weak var myImageView: UIImageView!
    let picker = UIImagePickerController()
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self // delegate added

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func takePicture(_ sender: UIButton) {
        
        print("pressed")
        
        let alert = UIAlertController(title: "i am use your camera", message: "i need", preferredStyle:.alert)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Photo Libarary", style: .default, handler: { (action:UIAlertAction) in
            let imagePickerController = UIImagePickerController()
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil))
        self.present(alert, animated: true, completion: nil)

        
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            myImageView.image = image
            
            let imageData = UIImagePNGRepresentation(image)
            
            UserDefaults.standard.set(imageData, forKey: "imageData")
            
            picker.dismiss(animated: true, completion: nil)
        } else{
            print("Something went wrong")
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondVC: OCRViewController = segue.destination as! OCRViewController
        
        secondVC.image = myImageView.image!
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
