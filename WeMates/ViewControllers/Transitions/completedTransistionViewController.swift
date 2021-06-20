//
//  completedTransistionViewController.swift
//  WeMates
//
//  Created by Senuda Ratnayake on 6/10/21.
//

import UIKit
import Parse
import Lottie

class completedTransistionViewController: UIViewController {

    @IBOutlet weak var topAnimationView: AnimationView!
    @IBOutlet weak var bottomAnimationView: AnimationView!
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    var timer:Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topLabel.text = "You Are All Set!"
        bottomLabel.text = "Please wait, you are being redirected..."
        
        bluetickAnimation()
        firstBumpAnimation()

        // Do any additional setup after loading the view.
        
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(timeaction), userInfo: nil, repeats: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func bluetickAnimation() {
        topAnimationView.contentMode = .scaleAspectFit
        topAnimationView.loopMode = .playOnce
        topAnimationView.animationSpeed = 0.5
        topAnimationView.play()
    }
    
    func firstBumpAnimation() {
        bottomAnimationView.contentMode = .scaleAspectFit
        bottomAnimationView.loopMode = .loop
        bottomAnimationView.animationSpeed = 1
        bottomAnimationView.play()
        
    }
    
    @objc func timeaction(){
        self.performSegue(withIdentifier: "signupSegue", sender: nil)
        timer.invalidate()//after that timer invalid

        }

}
