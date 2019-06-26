//
//  ViewController.swift
//  Askery
//
//  Created by Emilio Schepis on 26/06/2019.
//  Copyright © 2019 Vincidevs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var shook = false
    var answers = [String]()
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let path = Bundle.main.path(forResource: "Answers", ofType: "txt") else {
            return
        }
        
        let data = try? String(contentsOfFile: path, encoding: .utf8)
        
        answers = data?.components(separatedBy: .newlines) ?? []
        
        // The last row is always empty
        answers.removeLast()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        resignFirstResponder()
        
        super.viewWillDisappear(animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        super.motionEnded(motion, with: event)
        
        if motion == .motionShake {
            if shook == false {
                shook = true
                textLabel.font = UIFont(name: "TravelingTypewriter", size: 23.0)
                backgroundImageView.image = UIImage(named: "background")
            }
            
            textLabel.alpha = 0.0
            textLabel.text = answers.randomElement()
            fadeAnimation()
        }
    }
    
    func fadeAnimation() {
        UIView.animate(withDuration: 1) {
            self.textLabel.alpha = 1
            self.view.layoutIfNeeded()
        }
    }

}
