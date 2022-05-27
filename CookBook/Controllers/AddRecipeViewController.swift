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
    
    @IBOutlet weak var addrecipe_TE_name: UITextField!
    @IBOutlet weak var addrecipe_IMG_image: UIImageView!
    
    @IBOutlet weak var addrecipe_TE_save: UIButton!
    @IBOutlet weak var addrecipe_TE_instructions: UITextField!
    @IBOutlet weak var addrecipe_TE_ingrediencies: UITextField!
    @IBOutlet weak var addrecipe_TE_description: UITextField!
    //var storage = Storage.storage()
    var addRecipeBrain = AddRecipeBrain()
    let user = User.user
    let db = Firestore.firestore()
    var storage = Storage.storage()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Get a non-default Cloud Storage bucket
       // storage = Storage.storage(url:"gs://cookbook-e4cd0.appspot.com")
        
        // Get a non-default Cloud Storage bucket
        storage = Storage.storage(url:"gs://cookbook-e4cd0.appspot.com")
            
        // Do any additional setup after loading the view.
    }
    
    
    
    func uploadImageToStorage(){
        // File located on disk
        let localFile = addRecipeBrain.getRecipe().image!
        let storageRef = storage.reference()
        // Create a reference to the file you want to upload
        let userPhone = user.getUserPhone()
        let recipeName = addRecipeBrain.getRecipe().name
        let riversRef = storageRef.child("\(userPhone)/\(recipeName!).jpg")
        
        // Upload the file to the path "images/rivers.jpg"
        let uploadTask = riversRef.putFile(from: localFile, metadata: nil) { metadata, error in
          guard let metadata = metadata else {
            // Uh-oh, an error occurred!
            return
          }
          // Metadata contains file metadata such as size, content-type.
          let size = metadata.size
          // You can also access to download URL after upload.
          riversRef.downloadURL { (url, error) in
            guard let downloadURL = url else {
              // Uh-oh, an error occurred!
              return
            }
          }
        }
            
    }
    
    @IBAction func SaveRecipe(_ sender: UIButton) {
        var saveRercipe = true
        
        if let recipeName = addrecipe_TE_name.text{
            addRecipeBrain.setUserRecipeName(name: recipeName)
        }else{
            saveRercipe = false
            print("Please enter recipe name")
        }
        if let recipeInstructions = addrecipe_TE_instructions.text{
            addRecipeBrain.setUserRecipeInstructions(instructions: recipeInstructions)
        }else{
            saveRercipe = false
            print("Please enter recipe instructions")
        }
        if let recipeDescription = addrecipe_TE_description.text{
            addRecipeBrain.setUserRecipeDescription(description: recipeDescription)
        }else{
            saveRercipe = false
            print("Please enter recipe description")
        }
        if let recipeIngrediencies = addrecipe_TE_ingrediencies.text{
            addRecipeBrain.setUserRecipeIngrediencies(ingrediencies: recipeIngrediencies)
        }else{
            saveRercipe = false
            print("Please enter recipe ingrediencies")
        }
        
        if saveRercipe{
            addRecipeBrain.setUserRecipeUserId(userId: user.getUserPhone())
            saveRecipeInFirestore()
            uploadImageToStorage()
            performSegue(withIdentifier: "goToHome", sender: self)
        }
        
    }
    
    func saveRecipeInFirestore(){
        print("-------> save in firebase")
        //generate uid
        let ref = db.collection("recipes")
        let recipeId = ref.document().documentID
        // add recipe to user recipies list
        do {
            try db.collection("recipes").document(recipeId).setData(from: addRecipeBrain.getRecipe())
            user.addRecipeIdToList(recipeId: recipeId)
            updateUserRecipeListFirestore()
        } catch let error {
            print("Error writing city to Firestore: \(error)")
        }
    }
    func updateUserRecipeListFirestore(){
        let washingtonRef = db.collection("users").document(user.getUserPhone())
        
    
        // Set the "capital" field of the city 'DC'
        washingtonRef.updateData([
            "recipes": user.getRecipeList()
        ]) { err in
            if let err = err {
               // self.addNewUser()
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }

    }
    
//    func addNewUser(){
//        print("-------> save user in firebase")
//
//        do {
//            try db.collection("users").document(user.getUserPhone()).setData(["recipes":user.getRecipeList()])
//        } catch let error {
//            print("Error writing city to Firestore: \(error)")
//        }
//    }
    
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
            print("--------------->uploaded")
            
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

