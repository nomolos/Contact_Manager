//
//  NewContactController.swift
//  contact_manager
//
//  Created by meagh054 on 9/4/19.
//  Copyright © 2019 solomon. All rights reserved.
//

import UIKit

class NewContactController: UIViewController {

    
    @IBOutlet weak var name: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.borderStyle = UITextField.BorderStyle.none;
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.name.frame.height))
        name.leftView = paddingView
        name.leftViewMode = UITextField.ViewMode.always
        // Do any additional setup after loading the view.
    }
    
    @IBAction func back(_ sender: Any) {
        let transition: CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: nil)
        self.dismiss(animated: false, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
