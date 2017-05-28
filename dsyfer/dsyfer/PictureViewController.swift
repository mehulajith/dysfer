//
//  PictureViewController.swift
//  dsyfer
//
//  Created by Mehul Ajith on 5/27/17.
//  Copyright © 2017 Mehul Ajith. All rights reserved.
//
import UIKit



class PictureViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var done: UIButton!
    
    @IBOutlet weak var myImageView: UIImageView!
    let picker = UIImagePickerController()
    
    var photo = UIImage()
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self // delegate added
        // Do any additional setup after loading the view.
        
        done.frame = CGRect(x: 160, y: 100, width: 50, height: 50)
        done.layer.cornerRadius = 0.5 * done.bounds.size.width
        done.clipsToBounds = true
        
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
        
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
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
        
        self.photo = info[UIImagePickerControllerOriginalImage] as! UIImage
        
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
        
        secondVC.image = self.photo
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
