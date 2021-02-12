//
//  ViewController.swift
//  Chat
//
//  Created by Ivan Ivanov on 2/10/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    var timer = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = ""
        title = K.appName
        let titleText = K.appName
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.1 * timer, repeats: false) { (time) in

                self.titleLabel.text?.append(letter)
            }
            timer += 1
        }
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
   

    @IBAction func registerPressed(_ sender: UIButton) {
    }
    @IBAction func logInPressed(_ sender: UIButton) {
    }
    
}

