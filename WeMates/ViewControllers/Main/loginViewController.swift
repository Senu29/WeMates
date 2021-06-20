//
//  loginViewController.swift
//  WeMates
//
//  Created by Senuda Ratnayake on 6/9/21.
//

import UIKit
import Parse

class loginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var SignUpButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //textField Delegates
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self
        
        // Modifying the Login button
        loginButton.layer.cornerRadius = loginButton.frame.size.width / 15
        // Modifying the SignUp button
        SignUpButton.layer.cornerRadius = SignUpButton.frame.size.width / 10
    }
    
    // for the textfields to switch on return keys
    private func switchBasedNextTextField(_ textField: UITextField) {
        switch textField {
        case self.usernameTextField:
            self.passwordTextField.becomeFirstResponder()
        default:
            self.passwordTextField.resignFirstResponder()
        }
    }
    
    // calling to switch the fields
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.switchBasedNextTextField(textField)
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Dismiss the keyboard
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    @IBAction func onLogin(_ sender: Any) {
        PFUser.logInWithUsername(inBackground: self.usernameTextField.text!, password: self.passwordTextField.text!) { (user, error) in
            if user != nil{
                print("found user and succuessfully logged in")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)

            } else {
                self.errorLabel.text = " Please try again, \(error!.localizedDescription)"
                print("user not found")
            }
        
        }
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onSignUp(_ sender: UIButton) {
        performSegue(withIdentifier: "welcomeSegue", sender: nil)
    }
    
    
}
