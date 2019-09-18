//
//  UpdateContactController.swift
//  contact_manager
//
//  Created by meagh054 on 9/12/19.
//  Copyright © 2019 solomon. All rights reserved.
//

import UIKit

class UpdateContactController: UIViewController, UIPickerViewDelegate, UITextFieldDelegate, UIPickerViewDataSource {
    
    

    let relationship_data = ["Sibling", "Parent", "Grandparent", "Aunt", "Uncle", "Friend", "Cousin", "Family", "Partner"]
    
    let contentment_data = ["Maximum", "No Complaints", "Feeling distant", "Some tension", "Uncomfortable"]
    
    let interaction_data = ["Daily", "Weekly", "Every Two Weeks", "Monthly", "Every Two Months"]
    
    var current_data = [""]
    var current_size = 0
    
    var contacts = [""]
    
    var selected_name = ""
    var selected_relationship = ""
    var selected_contentment = ""
    var selected_interaction = ""
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var contentment_textfield: UITextField!
    @IBOutlet weak var relationship_textfield: UITextField!
    @IBOutlet weak var interaction_textfield: UITextField!
    @IBOutlet weak var picker: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(selected_name)
        contentment_textfield.delegate = self
        relationship_textfield.delegate = self
        interaction_textfield.delegate = self
        self.picker.delegate = self
        self.picker.dataSource = self
        
        name.text = selected_name
        contentment_textfield.text = selected_contentment
        relationship_textfield.text = selected_relationship
        interaction_textfield.text = selected_interaction
        
        
        
        // Indenting the text fields so it ain't ugly
        name.borderStyle = UITextField.BorderStyle.none;
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.name.frame.height))
        name.leftView = paddingView
        name.leftViewMode = UITextField.ViewMode.always
        // Indenting the text fields so it ain't ugly
        relationship_textfield.borderStyle = UITextField.BorderStyle.none;
        let paddingView2 = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.relationship_textfield.frame.height))
        relationship_textfield.leftView = paddingView2
        relationship_textfield.leftViewMode = UITextField.ViewMode.always
        contentment_textfield.borderStyle = UITextField.BorderStyle.none;
        let paddingView3 = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.contentment_textfield.frame.height))
        contentment_textfield.leftView = paddingView3
        contentment_textfield.leftViewMode = UITextField.ViewMode.always
        interaction_textfield.borderStyle = UITextField.BorderStyle.none;
        let paddingView4 = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.interaction_textfield.frame.height))
        interaction_textfield.leftView = paddingView4
        interaction_textfield.leftViewMode = UITextField.ViewMode.always
        
        // Do any additional setup after loading the view.
        
        picker.isHidden = true;
        picker.layer.zPosition = 1
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        print(selected_name)
        contentment_textfield.delegate = self
        relationship_textfield.delegate = self
        interaction_textfield.delegate = self
        self.picker.delegate = self
        self.picker.dataSource = self
        
        
        
        
        // Indenting the text fields so it ain't ugly
        name.borderStyle = UITextField.BorderStyle.none;
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.name.frame.height))
        name.leftView = paddingView
        name.leftViewMode = UITextField.ViewMode.always
        // Indenting the text fields so it ain't ugly
        relationship_textfield.borderStyle = UITextField.BorderStyle.none;
        let paddingView2 = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.relationship_textfield.frame.height))
        relationship_textfield.leftView = paddingView2
        relationship_textfield.leftViewMode = UITextField.ViewMode.always
        contentment_textfield.borderStyle = UITextField.BorderStyle.none;
        let paddingView3 = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.contentment_textfield.frame.height))
        contentment_textfield.leftView = paddingView3
        contentment_textfield.leftViewMode = UITextField.ViewMode.always
        interaction_textfield.borderStyle = UITextField.BorderStyle.none;
        let paddingView4 = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.interaction_textfield.frame.height))
        interaction_textfield.leftView = paddingView4
        interaction_textfield.leftViewMode = UITextField.ViewMode.always
        
        // Do any additional setup after loading the view.
        
        picker.isHidden = true;
        picker.layer.zPosition = 1
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // number of rows in relationship picker view
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        print("number of rows " + String(current_size))
        return current_size
    }
    
    // displays current row's string
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return current_data[row]
    }
    
    // pickerview row is selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(current_data == contentment_data){
            contentment_textfield.text = current_data[row]
        }
        else if(current_data == relationship_data){
            relationship_textfield.text = current_data[row]
        }
        else if(current_data == interaction_data){
            interaction_textfield.text = current_data[row]
        }
        picker.isHidden = true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if(textField == contentment_textfield){
            print("Were editing the contentment textfield")
            current_data = contentment_data
            current_size = contentment_data.count
        }
        else if(textField == relationship_textfield){
            print("Were editing the relationship textfield")
            current_data = relationship_data
            current_size = relationship_data.count
        }
        else if(textField == interaction_textfield){
            current_data = interaction_data
            current_size = interaction_data.count
        }
        picker.reloadAllComponents()
        picker.isHidden = false
        return false
    }

    @IBAction func back(_ sender: Any) {
        let transition: CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: nil)
        
        // Saves to previous view
        //performSegue(withIdentifier: "save_unwind", sender: self)
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
