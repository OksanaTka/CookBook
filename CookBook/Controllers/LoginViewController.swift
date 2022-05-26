
import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
      

class LoginViewController: UIViewController {
    let db = Firestore.firestore()
    var verifyPhone = false
    var verificationID: String? = nil
    
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
    
    
    @IBAction func Login(_ sender: UIButton) {
        if !verifyPhone{
            if !login_TF_phone.text!.isEmpty{
                Auth.auth().settings?.isAppVerificationDisabledForTesting = false
                let phoneNumber = login_TF_phone.text!
                print("-----> phone:: \(phoneNumber)")
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
                        self.goToHomeViewController()
                        print("Authentication success with- " + (authDate?.user.phoneNumber! ?? "No phone number") )
                    }
                })
            }else{
                print("Error in getting verification id")
            }
            
        }
    }
    

}

