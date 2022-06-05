
import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth


class LoginViewController: UIViewController {
    let db = Firestore.firestore()
    var verifyPhone = false
    var verificationID: String? = nil
    let user = User.user
    let recipeDate = RecipeData.recipeData
    
    @IBOutlet weak var login_TF_phone: UITextField!
    @IBOutlet weak var login_TF_code: UITextField!
    @IBOutlet weak var login_BTN_login: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }
    
    func initView(){
        login_TF_code.isHidden = true
        login_TF_phone.placeholder = "Enter Phone"
        login_TF_code.placeholder = "Enter Code"
    }
    
    // go to HomeViewController
    func goToHomeViewController(){
        performSegue(withIdentifier: "goToHome", sender: self)
    }
    
    
    // get user's liked recipes list from firestore
    func getUserLikedRecipesFromFirestore(){
        let docRef = db.collection("users").document(user.getUserPhone())
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let recipesIdsList = document.data()!["likes"]! as! [String]
                self.user.setLikedRecipeList(recipeLikedIdsList: recipesIdsList)
                
            } else {
                print("Document does not exist")
            }
        }
    }
    
    // get user's recipes list from firestore
    func getUserRecipesFromFirestore(){
        let docRef = db.collection("users").document(user.getUserPhone())
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let recipesIdsList = document.data()!["recipes"]! as! [String]
                self.user.setRecipeList(recipeIdsList: recipesIdsList)
                self.getAllRecipes()
                self.getUserLikedRecipesFromFirestore()
                
                
            } else {
                print("Document does not exist")
                //save new user
                self.addNewUser()
            }
        }
    }
    // get ALL recipes list from firestore
    func getAllRecipes(){
        
        db.collection("recipes").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    do{
                        let recipeId = document.documentID as String
                        let newRecipe = try document.data(as: Recipe.self)
                        //add recipe to Map
                        self.recipeDate.addRecipeToMap(recipeId, newRecipe)
                    }
                    catch let error{
                        print(error)
                    }
                }
                self.goToHomeViewController()
            }
        }
    }
    
    // add new user to firestore
    func addNewUser(){
        do {
            try db.collection("users").document(user.getUserPhone()).setData(["recipes":[]])
            self.getAllRecipes()
            
        } catch let error {
            print("Error writing city to Firestore: \(error)")
        }
    }
    
    @IBAction func Login(_ sender: UIButton) {
        if !verifyPhone{
            if !login_TF_phone.text!.isEmpty{
                Auth.auth().settings?.isAppVerificationDisabledForTesting = false
                //get phone
                let phoneNumber = login_TF_phone.text!
                user.setUserPhone(userPhone: phoneNumber)
                PhoneAuthProvider.provider()
                    .verifyPhoneNumber(phoneNumber, uiDelegate: nil,completion: {verificationID, error in
                        if let error = error {
                            print("phone error: \(error)")
                            return
                        }else{
                            self.verificationID = verificationID
                            self.login_TF_code.isHidden = false
                            self.verifyPhone = true
                            sender.setTitle("Submit SMS", for: .normal)
                        }
                    })
                
                
            }else{
                print("Please enter your mobile number")
            }
        }else{
            if(verificationID != nil){
                //verify code
                let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID!, verificationCode: login_TF_code.text!)
                Auth.auth().signIn(with: credential,completion: {authDate,error in
                    if let error = error {
                        print(error)
                        return
                    }else{
                        self.getUserRecipesFromFirestore()
                        print("Authentication success with- " + (authDate?.user.phoneNumber! ?? "No phone number") )
                    }
                })
            }else{
                print("Error in getting verification id")
            }
        }
    }
    
    
}

