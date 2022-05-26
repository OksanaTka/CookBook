//
//  AddRecipeViewController.swift
//  CookBook
//
//  Created by user216397 on 5/26/22.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

class AddRecipeViewController: UIViewController {
    
    @IBOutlet weak var addrecipe_BTN_addimage: UIButton!
    
    @IBOutlet weak var addrecipe_IMG_image: UIImageView!
    
    //var storage = Storage.storage()
    var addRecipeBrain = AddRecipeBrain()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Get a non-default Cloud Storage bucket
       // storage = Storage.storage(url:"gs://cookbook-e4cd0.appspot.com")
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func UploadPicture(_ sender: UIButton) {
        showImagePickerController()
    }
    
    func saveInFirestore(){
        
    }
    
    
    
}

extension AddRecipeViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func showImagePickerController(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController,animated: true,completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imageUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL{
            self.addrecipe_BTN_addimage.isHidden = true
            self.addrecipe_IMG_image.isHidden = false
            self.addrecipe_IMG_image.imageFrom(url: imageUrl)
            self.addRecipeBrain.setUserRecipeImage(image: imageUrl)
            
            
        }
        dismiss(animated: true,completion: nil)
        
    }
}

// display image by url
extension UIImageView{
    func imageFrom(url:URL){
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url){
                if let image = UIImage(data:data){
                    DispatchQueue.main.async{
                        self?.image = image
                    }
                }
            }
        }
    }
}

