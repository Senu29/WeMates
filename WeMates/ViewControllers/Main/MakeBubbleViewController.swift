//
//  MakeBubbleViewController.swift
//  WeMates
//
//  Created by Senuda Ratnayake on 6/20/21.
//

import UIKit
import AlamofireImage
import Parse

class MakeBubbleViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var bubbleNameTextField: UITextField!
    @IBOutlet weak var bubbleDescriptionTextView: UITextView!
    @IBOutlet weak var bubblePictureImage: UIImageView!
    @IBOutlet weak var doneButton: UIButton!
    
    let user = PFUser.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designController()

        // Do any additional setup after loading the view.
        
        //keyboard: look fo the extension below.
        self.addKeyboardObserver()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Dismiss the keyboard
        bubbleNameTextField.resignFirstResponder()
        bubbleDescriptionTextView.resignFirstResponder()
    }

    @IBAction func onTapBubbleImage(_ sender: UITapGestureRecognizer) {
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
        
        let size = CGSize(width: 800, height: 800)
        let scaledImage = image.af_imageAspectScaled(toFill: size)
        
        bubblePictureImage.image = scaledImage
        
        picker.isNavigationBarHidden = false
        self.dismiss(animated: true, completion: nil)
    }
    
    func designController() {
        // design for the imageView
        bubblePictureImage.layer.cornerRadius = bubblePictureImage.frame.size.width / 2
        bubblePictureImage.layer.borderWidth = 4
        bubblePictureImage.layer.borderColor = UIColor.systemBlue.cgColor
        
        //design for the doneButton
        doneButton.layer.cornerRadius = bubblePictureImage.frame.size.width / 9
        doneButton.layer.borderWidth = 1
        doneButton.layer.borderColor = UIColor.systemBlue.cgColor
        
        //design for the descriptionTextView
        bubbleDescriptionTextView.layer.cornerRadius = bubblePictureImage.frame.size.width / 15
        if bubbleDescriptionTextView.text.isEmpty {
            bubbleDescriptionTextView.text = "Tell Us About Your Bubble"
            bubbleDescriptionTextView.textColor = UIColor.lightGray
            }
        
    }
    @IBAction func onDone(_ sender: UIButton) {
        let bubble = PFObject(className: "Bubbles")
        
        bubble["admin"] = self.user
        bubble["bubbleName"] = bubbleNameTextField.text
        bubble["bubbleDescription"] = bubbleDescriptionTextView.text
        
        //saving the bubble image
        let imageData = bubblePictureImage.image!.pngData()
        let file = PFFileObject(name: "image.png", data: imageData!)
        
        bubble["bubbleImage"] = file
        
        bubble.saveInBackground { (success, error) in
            if success{
                self.dismiss(animated: true, completion: nil)
                print("saved!")
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
    @IBAction func returnButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}
