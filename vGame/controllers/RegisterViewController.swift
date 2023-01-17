//
//  RegisterViewController.swift
//  vGame
//
//  Created by Alexander Imanuel on 13/01/23.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var tf_username: UITextField!
    @IBOutlet weak var tf_email: UITextField!
    @IBOutlet weak var tf_password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        
        view.addGestureRecognizer(tap)
    }
    
    func toastMsg(_ msg: String) {
        let alertDisapperTimeInSeconds = 0.5
        let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        self.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + alertDisapperTimeInSeconds) {
          alert.dismiss(animated: true)
        }
    }
    
    @IBAction func btn_registerOnClick(_ sender: Any) {
        if tf_username.text!.isEmpty {
            toastMsg("Name must be filled!")
            // TODO : request focus
        } else if tf_email.text!.isEmpty {
            toastMsg("Email must be filled!")
        } else if tf_password.text!.isEmpty {
            toastMsg("Password must be filled!")
        } else {
            UserService.createUser(tfName: tf_username.text!, tfEmail: tf_email.text!, tfPassword: tf_password.text!)
            navigationController?.popViewController(animated: true)
        }
    }

}
