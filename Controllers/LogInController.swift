//
//  LogInController.swift
//  Chat
//
//  Created by Ivan Ivanov on 2/11/21.
//

import UIKit
import Firebase



class LogInController: UIViewController {

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func logInPressed(_ sender: Any) {
        
         if let user = emailTextField.text, let pass = passTextField.text {
            Auth.auth().signIn(withEmail: user, password: pass) { (dataResult, error) in
                if let e = error{
                    print (e)
                    self.errorLabel.text = e.localizedDescription
                    
                }else{
                    self.performSegue(withIdentifier: K.loginSegue, sender: self)
                }
            }
        }
       
    }
 

}
