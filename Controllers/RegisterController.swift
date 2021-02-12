//
//  RegisterController.swift
//  Chat
//
//  Created by Ivan Ivanov on 2/11/21.
//

import UIKit
import Firebase

class RegisterController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func registerPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let pass = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: pass) { (authResult, error) in
                if let e = error{
                    let someError = e.localizedDescription
                    print (e)
                    self.errorLabel.text = someError
                }else{
                    //Navigate to the ChatViewController
                    self.performSegue(withIdentifier: K.loginSegue, sender: self)
                }
            }
        }
        }
        
       
}
