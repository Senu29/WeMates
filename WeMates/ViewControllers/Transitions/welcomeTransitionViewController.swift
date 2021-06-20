//
//  welcomeTransitionViewController.swift
//  
//
//  Created by Senuda Ratnayake on 6/9/21.
//

import UIKit
import Lottie

class welcomeTransitionViewController: UIViewController {

    @IBOutlet weak var animationView: AnimationView!
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var msg1Label: UILabel!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topLabel.text = "Great To Have You!"
        msg1Label.text = "Time to make more new memories with your Mates."
        

        // 1. Set animation content mode
        animationView.contentMode = .scaleAspectFit
        // 2. Set animation loop mode
        animationView.loopMode = .loop
        // 3. Adjust animation speed
        animationView.animationSpeed = 0.5
        // 4. Play animation
        animationView.play()
        
        //signUpButton modify
        signUpButton.layer.cornerRadius = signUpButton.frame.size.width / 15
        signUpButton.layer.borderWidth = 3
        signUpButton.layer.borderColor = UIColor.systemBlue.cgColor
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
        performSegue(withIdentifier: "signUpFormSegue", sender: nil)
    }
    
}
