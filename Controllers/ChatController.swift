//
//  ChatController.swift
//  Chat
//
//  Created by Ivan Ivanov on 2/11/21.
//

import UIKit
import Firebase
class ChatController: UIViewController {
    
    let db = Firestore.firestore()
    
    var messages:[Message] = []
    
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
      
        title = K.appName
        navigationItem.hidesBackButton = true
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        // Do any additional setup after loading the view.
        loadMessegaes()
        
    }
    
    
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        do{
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
            print("signing our")
        }catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
        
        if let message = textField.text, let user = Auth.auth().currentUser?.email {
            
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField: user,
                K.FStore.bodyField:message,
                K.FStore.dateField: Date().timeIntervalSince1970
            ])
            { (error) in
                if let e = error {
                    print("cannot save data!\(e)")
                }else{
                    //self.loadMessegaes()
                    print("Succesfully saved data!")
                    DispatchQueue.main.async {
                        self.textField.text = ""
                    }
                    
                }
            }
            
 
        }
        
    }
    func loadMessegaes(){
        
        
        db.collection(K.FStore.collectionName).order(by: K.FStore.dateField, descending: false).addSnapshotListener { (querySnapshot, error) in
            self.messages = []
            if let e =  error{
                print("Error getting documents \(e)")
            }else{
                if let stapShootOfDocs = querySnapshot?.documents{
                    for document in stapShootOfDocs {
                       
                        let data = document.data()
                       
                        if let sender = data[K.FStore.senderField] as? String,
                           let message = data[K.FStore.bodyField] as? String
                        {
                         self.messages.append(Message(sender: sender, body: message))
                           DispatchQueue.main.async {
                                self.tableView.reloadData()
                            let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                            self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                        }
                       
                    }
                    
                }
            }
        }
    }
    
}

extension ChatController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.labelCell.text = message.body
        if message.sender == Auth.auth().currentUser?.email {
            cell.leftImage.isHidden = true
            cell.rightImage.isHidden = false
            cell.messageBuble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.labelCell.textColor = UIColor(named: K.BrandColors.purple)
            
        }else{
            cell.leftImage.isHidden = false
            cell.rightImage.isHidden = true
            cell.messageBuble.backgroundColor = UIColor(named: K.BrandColors.purple)
            cell.labelCell.textColor = UIColor(named: K.BrandColors.lightPurple)
        }
        return cell
    }
}
