//
//  SignUpFormViewController.swift
//  WeMates
//
//  Created by Senuda Ratnayake on 6/9/21.
//

import UIKit
import Parse
import AlamofireImage

class SignUpFormViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var profilePhoto: UIImageView!
    
    @IBOutlet weak var fNameTextField: UITextField!
    @IBOutlet weak var lNameTextField: UITextField!
    @IBOutlet weak var dobTextField: UITextField!
    @IBOutlet weak var teleTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confimPasswordTextField: UITextField!
    
    @IBOutlet weak var readyButton: UIButton!
    @IBOutlet weak var showNewPasswordButton: UIButton!
    @IBOutlet weak var showConfirmPasswordButton: UIButton!
    
    var btnLogic = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //txtField delegates
        self.fNameTextField.delegate = self
        self.lNameTextField.delegate = self
        self.dobTextField.delegate = self
        self.emailTextField.delegate = self
        self.teleTextField.delegate = self
        self.usernameTextField.delegate = self
        self.newPasswordTextField.delegate = self
        self.confimPasswordTextField.delegate = self
        
        
        //readyButton modify
        readyButton.layer.cornerRadius = readyButton.frame.size.width / 15
        readyButton.layer.borderWidth = 3
        readyButton.layer.borderColor = UIColor.systemBlue.cgColor
        
        //keyboard: look fo the extension below.
        self.addKeyboardObserver()
    }
    
    // calling to switch the fields
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.switchBasedNextTextField(textField)
        return true
    }
    
    // for the textfields to switch on return keys
    private func switchBasedNextTextField(_ textField: UITextField) {
        switch textField {
        case self.fNameTextField:
            self.lNameTextField.becomeFirstResponder()
        case self.lNameTextField:
            self.dobTextField.becomeFirstResponder()
        case self.dobTextField:
            self.emailTextField.becomeFirstResponder()
        case self.emailTextField:
            self.teleTextField.becomeFirstResponder()
        case self.teleTextField:
            self.usernameTextField.becomeFirstResponder()
        case self.usernameTextField:
            self.newPasswordTextField.becomeFirstResponder()
        case self.newPasswordTextField:
            self.confimPasswordTextField.becomeFirstResponder()
        default:
            self.confimPasswordTextField.resignFirstResponder()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Dismiss the keyboard
        fNameTextField.resignFirstResponder()
        lNameTextField.resignFirstResponder()
        usernameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        newPasswordTextField.resignFirstResponder()
        confimPasswordTextField.resignFirstResponder()
        dobTextField.resignFirstResponder()
    }
    
    
    
    
    @IBAction func onNewPasswordShow(_ sender: UIButton) {
        if btnLogic == false {
            btnLogic = true
            newPasswordTextField.isSecureTextEntry = false
            showNewPasswordButton.tintColor = UIColor.systemBlue
            
            
        }else{
            btnLogic = false
            newPasswordTextField.isSecureTextEntry = true
            showNewPasswordButton.tintColor = UIColor.lightGray
        }
    }
    
    
    @IBAction func onConfirmPasswordShow(_ sender: UIButton) {
        if btnLogic == false {
            btnLogic = true
            confimPasswordTextField.isSecureTextEntry = false
            showConfirmPasswordButton.tintColor = UIColor.systemBlue
            
            
        }else{
            btnLogic = false
            confimPasswordTextField.isSecureTextEntry = true
            showConfirmPasswordButton.tintColor = UIColor.lightGray
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
    
    @IBAction func onCameraButton(_ sender: UITapGestureRecognizer) {
        let picker = UIImagePickerController()
            picker.delegate = self
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.view.tintColor = UIColor.systemGreen
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {
            action in picker.sourceType = UIImagePickerController.SourceType.camera
            picker.allowsEditing = true
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
            
        }))
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {action in picker.sourceType = .photoLibrary
            picker.allowsEditing = true
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageAspectScaled(toFill: size)
        
        profilePhoto.image = scaledImage
        profilePhoto.layer.cornerRadius = profilePhoto.frame.size.width / 2
        profilePhoto.layer.borderWidth = 5
        profilePhoto.layer.borderColor = UIColor.systemBlue.cgColor
        
        picker.isNavigationBarHidden = false
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    @IBAction func onReady(_ sender: UIButton) {
        let myUser = PFUser()
        
        let userName = usernameTextField.text
        let userPassword = newPasswordTextField.text
        let userPasswordConfirm = confimPasswordTextField.text
        let userFirstName = fNameTextField.text
        let userLastName = lNameTextField.text
        let userDOF = dobTextField.text
        let userEmail = emailTextField.text
        let userContact = teleTextField.text
        
        if (userName!.isEmpty || userPassword!.isEmpty || userPasswordConfirm!.isEmpty || userFirstName!.isEmpty || userLastName!.isEmpty){
            var myAlert = UIAlertController(title: "Alert", message: "Please fill in the required fields.", preferredStyle: UIAlertController.Style.alert)
            
            let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
            
            myAlert.addAction(okAction)
            
            self.present(myAlert, animated: true, completion: nil)
            
            return
        }
        
        else if (userPassword != userPasswordConfirm){
            var myAlert = UIAlertController(title: "Alert", message: "Passwords do not match, Please try again.", preferredStyle: UIAlertController.Style.alert)
            
            let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
            
            myAlert.addAction(okAction)
            
            self.present(myAlert, animated: true, completion: nil)
            
            return
        }
        
        else {
            
            myUser.username = userName
            myUser.password = userPassword
            myUser.email = userEmail
            myUser.setObject(userFirstName as Any, forKey: "first_name")
            myUser.setObject(userLastName as Any, forKey: "last_name")
            myUser.setObject(userDOF as Any, forKey: "Date_of_Birth")
            myUser.setObject(userContact as Any, forKey: "Mobile_Number")
            
            let profileImageData = profilePhoto.image!.pngData()
            
            if (profileImageData != nil){
                let file = PFFileObject(name: "profileImage.png", data: profileImageData!)
                myUser.setObject(file as Any, forKey: "profileImage")
            }
            
            myUser.signUpInBackground { (success, error) in
                if success{
                    print("SAVED!")
                    self.performSegue(withIdentifier: "completedSegue", sender: nil)
                } else{
                    print("Error: \(error?.localizedDescription)")
                }
            }
        }
        
        
    }
    
    
}

extension UIResponder {
    
    static weak var responder: UIResponder?
    
    static func currentFirst() -> UIResponder? {
        responder = nil
        UIApplication.shared.sendAction(#selector(trap), to: nil, from: nil, for: nil)
        return responder
    }
    
    @objc private func trap() {
        UIResponder.responder = self
    }
}

extension UIViewController {
    func addKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardNotifications(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    func removeKeyboardObserver(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    // This method will notify when keyboard appears/ dissapears
    @objc func keyboardNotifications(notification: NSNotification) {
        
        var txtFieldY : CGFloat = 0.0  //Using this we will calculate the selected textFields Y Position
        let spaceBetweenTxtFieldAndKeyboard : CGFloat = 5.0 //Specify the space between textfield and keyboard
       
        
        var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        if let activeTextField = UIResponder.currentFirst() as? UITextField ?? UIResponder.currentFirst() as? UITextView {
            // Here we will get accurate frame of textField which is selected if there are multiple textfields
            frame = self.view.convert(activeTextField.frame, from:activeTextField.superview)
            txtFieldY = frame.origin.y + frame.size.height
        }
        
        if let userInfo = notification.userInfo {
            // here we will get frame of keyBoard (i.e. x, y, width, height)
            let keyBoardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let keyBoardFrameY = keyBoardFrame!.origin.y
            let keyBoardFrameHeight = keyBoardFrame!.size.height
            
            var viewOriginY: CGFloat = 0.0
            //Check keyboards Y position and according to that move view up and down
            if keyBoardFrameY >= UIScreen.main.bounds.size.height {
                viewOriginY = 0.0
            } else {
                // if textfields y is greater than keyboards y then only move View to up
                if txtFieldY >= keyBoardFrameY {
                    
                    viewOriginY = (txtFieldY - keyBoardFrameY) + spaceBetweenTxtFieldAndKeyboard
                    
                    //This condition is just to check viewOriginY should not be greator than keyboard height
                    // if its more than keyboard height then there will be black space on the top of keyboard.
                    if viewOriginY > keyBoardFrameHeight { viewOriginY = keyBoardFrameHeight }
                }
            }
            
            //set the Y position of view
            self.view.frame.origin.y = -viewOriginY
        }
    }
}
