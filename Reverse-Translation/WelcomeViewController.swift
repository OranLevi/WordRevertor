//
//  WelcomeViewController.swift
//  Reverse-Translation-iPhone
//
//  Created by Oran Levi on 04/11/2022.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var welcomeButton: UIButton!
    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        welcomeButton.layer.cornerRadius = 10
        textLabel.layer.masksToBounds = true
        textLabel.layer.cornerRadius = 20
        textLabel.adjustsFontSizeToFitWidth = true

        if UserDefaults.standard.bool(forKey: "WelcomeScreen") == false {
            print("## it the first time app load")
        } else {
            print("## transfer to Main VC")
            DispatchQueue.main.async {
                self.transferToVc(vcIdentifier: "MainVc", animated: false)
            }
        }
    }
    
    func transferToVc(vcIdentifier: String, animated: Bool) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: vcIdentifier) as! ViewController
        newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: animated, completion: nil)
    }
    
    @IBAction func WelcomeButton(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "WelcomeScreen")
        transferToVc(vcIdentifier: "MainVc", animated: true)
    }
}
