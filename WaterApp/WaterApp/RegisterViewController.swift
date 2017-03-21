//
//  RegisterViewController.swift
//  WaterApp
//
//  Created by Corey Caskey on 3/19/17.
//  Copyright © 2017 Corey Caskey. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    // references for labels from profile
    
    
    
    @IBOutlet weak var userText: UITextField!
    @IBOutlet weak var passText: UITextField!
    @IBOutlet weak var userTypeText: UITextField!
    
    let pickerData = [AccountType.user.get(), AccountType.worker.get(), AccountType.manager.get(),
                      AccountType.admin.get()]
    
    let userPicker = UIPickerView()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        userPicker.showsSelectionIndicator = true
        userPicker.delegate = self
        userPicker.dataSource = self
        
        let toolbar = UIToolbar()
        toolbar.barStyle = UIBarStyle.default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(cancelPicker))
    
        toolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        userTypeText.inputView = userPicker
        userTypeText.inputAccessoryView = toolbar
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        userTypeText.text = pickerData[row]
    }
    
    func donePicker(sender: UIBarButtonItem) {
        self.view.endEditing(true)
    }
    
    func cancelPicker(sender: UIBarButtonItem) {
        userTypeText.text = ""
        self.view.endEditing(true)
    }
    
    @IBAction func registerButton(_ sender: Any) {
        if (userText.text == "" || passText.text == "" || userTypeText.text == "") {
            showMissedTextAlert()
        }
        else if (UserList.addUser(u: User(username: userText.text!, password: passText.text!, accountType: AccountType(rawValue: userTypeText.text!)!)) == false) {
            showAlreadyTakenAlert()
        }
        else {
            passText.text = ""
            userText.text = ""
            userTypeText.text = ""
            self.performSegue(withIdentifier: "showLoginFromRegister", sender: self)
        }
    }
    
    func showMissedTextAlert() {
        let alert = UIAlertController(title: "One required item not filled", message: "Please complete all text boxes", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func showAlreadyTakenAlert() {
        let alert = UIAlertController(title: "Sorry, username already taken", message: "Please try again", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
