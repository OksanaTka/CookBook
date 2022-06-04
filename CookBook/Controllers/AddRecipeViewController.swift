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
    
    @IBOutlet weak var addrecipe_LBL_description: UITextView!
    @IBOutlet weak var addrecipe_TE_ingrediencies: UITextView!
    @IBOutlet weak var addrecipe_LBL_instructions: UITextView!
    @IBOutlet weak var addrecipe_BTN_addimage: UIButton!
    @IBOutlet weak var addrecipe_TE_name: UITextField!
    @IBOutlet weak var addrecipe_IMG_image: UIImageView!
    @IBOutlet weak var addrecipe_TE_save: UIButton!

    
    //var storage = Storage.storage()
    var addRecipeBrain = AddRecipeBrain()
    let user = User.user
    let db = Firestore.firestore()
    var storage = Storage.storage()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("dmfndskjfjkdshfjkdshfkjsdhfjkdsfkhdskfhjk")
        initLBLView()
        
        // Get a non-default Cloud Storage bucket
        // storage = Storage.storage(url:"gs://cookbook-e4cd0.appspot.com")
        
        // Get a non-default Cloud Storage bucket
        storage = Storage.storage(url:"gs://cookbook-e4cd0.appspot.com")
        
        // Do any additional setup after loading the view.
    }
    
    func initLBLView(){
        addrecipe_TE_name.layer.borderWidth = 0.5
        addrecipe_TE_name.layer.cornerRadius = 5.0
        
        addrecipe_LBL_description.layer.borderWidth = 0.5
        addrecipe_LBL_description.layer.borderColor = UIColor.lightGray.cgColor
        addrecipe_LBL_description.layer.cornerRadius = 5.0
        
        addrecipe_TE_ingrediencies.layer.borderWidth = 0.5
         addrecipe_TE_ingrediencies.layer.borderColor = UIColor.lightGray.cgColor
        
        addrecipe_TE_ingrediencies.layer.cornerRadius = 5.0
        addrecipe_LBL_instructions.layer.borderWidth = 0.5
          addrecipe_LBL_instructions.layer.borderColor = UIColor.lightGray.cgColor
        addrecipe_LBL_instructions.layer.cornerRadius = 5.0
        
    }
    
    func uploadImageToStorage(){
        // File located on disk
        let localFile = addRecipeBrain.getImagePathUserPhone()
        let storageRef = storage.reference()
        
        // Create a reference to the file you want to upload
        let riversRef = storageRef.child(addRecipeBrain.getRecipe().imageName!)
        
        // Upload the file to the path "images/___.jpg"
        let uploadTask = riversRef.putFile(from: localFile, metadata: nil) { metadata, error in
            guard let metadata = metadata else {
                // Uh-oh, an error occurred!
                return
            }
            // Metadata contains file metadata such as size, content-type.
            let size = metadata.size
            // You can also access to download URL after upload.
            riversRef.downloadURL { (url, error) in
                self.addRecipeBrain.setImageURL(imageURL: url!)
                print("----> image URL ADD")
                self.saveRecipeInFirestore()
                self.clearView()
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
        if let recipeInstructions = addrecipe_LBL_instructions.text{
            addRecipeBrain.setUserRecipeInstructions(instructions: recipeInstructions)
        }else{
            saveRercipe = false
            print("Please enter recipe instructions")
        }
        if let recipeDescription = addrecipe_LBL_description.text{
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
            let imageName = "\(addRecipeBrain.getRecipe().imageName!)"
            self.addRecipeBrain.setUserRecipeImage(image: imageName)
            addRecipeBrain.setUserRecipeUserId(userId: user.getUserPhone())
            
            uploadImageToStorage()
        }
    }
    
    func clearView(){
        addrecipe_TE_name.text = nil
        addrecipe_LBL_description.text = nil
        addrecipe_TE_ingrediencies.text = nil
        addrecipe_LBL_instructions.text = nil
        
        addrecipe_BTN_addimage.isHidden = false
        addrecipe_IMG_image.isHidden = true
    }
    func saveRecipeInFirestore(){
        //generate uid
        let ref = db.collection("recipes")
        let recipeId = ref.document().documentID
        let newRecipe = addRecipeBrain.getRecipe()
        // add recipe to user recipies list
        do {
            try db.collection("recipes").document(recipeId).setData(from: newRecipe)
            let recipeData = RecipeData.recipeData
            user.addRecipeIdToList(recipeId: recipeId)
            recipeData.addRecipeToMap(recipeId, newRecipe)
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
            self.addRecipeBrain.setImagePathUserPhone(path: imageUrl)
            print("--------------->uploaded")
            
        }
        dismiss(animated: true,completion: nil)
        
    }
    
    func downloadImageURLFirestore(imageName: String){
        let storageRef = storage.reference()
        let starsRef = storageRef.child("\(imageName)")
        // Fetch the download URL
        starsRef.downloadURL { url, error in
            if let error = error {
                // Handle any errors
                print("--------->Storage ERROR: \(error)")
            } else {
                // Get the download URL for 'images/stars.jpg'
                print("----> image URL: \(url!)")
                self.addRecipeBrain.setImageURL(imageURL: url!)
            }
        }
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

