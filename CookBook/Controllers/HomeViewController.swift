//
//  HomeViewController.swift
//  CookBook
//
//  Created by user216397 on 5/26/22.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

class HomeViewController: UIViewController {

    let db = Firestore.firestore()
    var homeBrain = HomeBrain()
    var recipeData = RecipeData.recipeData
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllRecipies()
        // Do any additional setup after loading the view.
    }
    
    
    func getAllRecipies(){
       // let docRef = db.collection("recipes").document("AS8C04dLV3SdEP47L7Oc")
        

//        docRef.getDocument(as: Recipe.self) { result in
//            // The Result type encapsulates deserialization errors or
//            // successful deserialization, and can be handled as follows:
//            //
//            //      Result
//            //        /\
//            //   Error  City
//            switch result {
//            case .success(let city):
//                // A `City` value was successfully initialized from the DocumentSnapshot.
//                print("City: \(city)")
//            case .failure(let error):
//                // A `City` value could not be initialized from the DocumentSnapshot.
//                print("Error decoding city: \(error)")
//            }
//        }
        db.collection("recipes").getDocuments() { (querySnapshot, err) in

            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    do{
                    print("\(document.documentID) => \(try document.data(as: Recipe.self))   )")
                        let newRecipe = try document.data(as: Recipe.self)
                        self.homeBrain.addRecipeToList(newRecipe: newRecipe)
                    }
                    catch var error{
                        print(error)
                    }
                }
            }
        }
    }

}
