//
//  LoginViewController.swift
//  vGame
//
//  Created by Alexander Imanuel on 13/01/23.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var tf_email: UITextField!
    @IBOutlet weak var tf_password: UITextField!
    
    public static var iscurrentUserAdmin:Bool?
    override func viewDidLoad() {
        super.viewDidLoad()
        AdminService.generateAdmin()
        GameService.generateCategory()
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        
        view.addGestureRecognizer(tap)
    }
    
    func showErrorAlert(msg: String) {
        let dialogMessage = UIAlertController(title: "Unmatch", message: msg, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "Understand", style: .default, handler: { (action) -> Void in
             print("Understand button tapped")
          })
         
         //Add OK button to a dialog message
         dialogMessage.addAction(ok)
         // Present Alert to
         self.present(dialogMessage, animated: true, completion: nil)
    }

    @IBAction func btn_loginClicked(_ sender: Any) {
        let validAdmin = AdminService.getAdmin(username: tf_email.text ?? "", password: tf_password.text ?? "")
        let validUser = UserService.getUser(email: tf_email.text ?? "", password: tf_password.text ?? "")
        
        if validAdmin{
            performSegue(withIdentifier: "toHome", sender: self)
            LoginViewController.iscurrentUserAdmin = true
            print("currentUser is admin:\(AdminService.currentAdmin.username!)")
            return
        }
        else if validUser{
            performSegue(withIdentifier: "toHome", sender: self)
            LoginViewController.iscurrentUserAdmin = false
            print("ciurrent user is not admin: \(UserService.currentUser.username!)")
            return
        }
        else {
            showErrorAlert(msg: "Wrong Email / Password, Please Try Again!")
        }
        
    }
    
}

