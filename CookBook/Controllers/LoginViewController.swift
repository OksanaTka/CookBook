
import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
      

class LoginViewController: UIViewController {
    let db = Firestore.firestore()
    var verifyPhone = false
    var verificationID: String? = nil
    let user = User.user
    
    @IBOutlet weak var login_TF_phone: UITextField!
    @IBOutlet weak var login_TF_code: UITextField!
    @IBOutlet weak var login_BTN_login: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        login_TF_code.isHidden = true
        login_TF_phone.placeholder = "Enter Phone"
        login_TF_code.placeholder = "Enter Code"
       
        
        // Do any additional setup after loading the view.
    }
    
    func goToHomeViewController(){
        
        performSegue(withIdentifier: "goToHome", sender: self)
    }
    
    func getUserRecipesFromFirestore(){
        let docRef = db.collection("users").document(user.getUserPhone())

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let recipesIdsList = document.data()!["recipes"]! as! [String]
                self.user.setRecipeList(recipeIdsList: recipesIdsList)
                self.goToHomeViewController()
            } else {
                print("Document does not exist")
                //save new user
                self.addNewUser()
            }
        }
    }
    
    func addNewUser(){
        print("-------> save user in firebase")
        
        do {
            try db.collection("users").document(user.getUserPhone()).setData(["recipes":[]])
            self.goToHomeViewController()
        } catch let error {
            print("Error writing city to Firestore: \(error)")
        }
    }
    
    @IBAction func Login(_ sender: UIButton) {
        if !verifyPhone{
            if !login_TF_phone.text!.isEmpty{
                Auth.auth().settings?.isAppVerificationDisabledForTesting = false
                let phoneNumber = login_TF_phone.text!
                print("-----> phone:: \(phoneNumber)")
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
                let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID!, verificationCode: login_TF_code.text!)
                Auth.auth().signIn(with: credential,completion: {authDate,error in
                    if let error = error {
                        print(error)
                        return
                    }else{
                        self.getUserRecipesFromFirestore()
                        //self.goToHomeViewController()
                        print("Authentication success with- " + (authDate?.user.phoneNumber! ?? "No phone number") )
                    }
                })
            }else{
                print("Error in getting verification id")
            }
            
        }
    }
    

}

