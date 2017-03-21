//
//  ProfileViewController.swift
//  WaterApp
//
//  Created by Corey Caskey on 3/19/17.
//  Copyright © 2017 Corey Caskey. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var newUserTypeField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    
    var tempUserTypeField: String = ""
    
    let pickerData = [AccountType.user.get(), AccountType.worker.get(), AccountType.manager.get(),
                      AccountType.admin.get()]
    
    let userPicker = UIPickerView()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.usernameLabel.text = UserList.getCurrentUser()
        self.newUserTypeField.text = UserList.getUser(username: UserList.getCurrentUser()).getAccountType().get()
        // gets the current username key and use that to get the User object of that key to get the AccountType string
        self.passwordLabel.text = UserList.getUser(username: UserList.getCurrentUser()).getPassword()
        
        
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
        
        newUserTypeField.inputView = userPicker
        newUserTypeField.inputAccessoryView = toolbar
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func usernameButton(_ sender: Any) {
        showUsernameAlert()
    }
    
    
    @IBAction func passwordButton(_ sender: Any) {
        showPasswordAlert()
    }
    
    func showUsernameAlert() {
        
        let alert = UIAlertController(title: "Change your username below", message: "", preferredStyle: .alert)
        
        alert.addTextField { (newUsernameField) in
            newUsernameField.placeholder = "Enter new username"
        }

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { (ACTION) in
            let newUsernameField = alert.textFields![0] as UITextField
            if (newUsernameField.text == "") {
                self.usernameLabel.text = self.usernameLabel.text!
            } else if (UserList.getUserListKeys().contains(newUsernameField.text!)) {
                self.showTakenAlert()
            } else {
                self.usernameLabel.text = newUsernameField.text!
            }
        }))
        
        present(alert, animated: true, completion: nil)
    
    }
    
    func showPasswordAlert() {
        
        let alert = UIAlertController(title: "Change your password below", message: "", preferredStyle: .alert)
        
        alert.addTextField { (newPasswordField) in
            newPasswordField.placeholder = "Enter new password"
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { (ACTION) in
            let newPasswordField = alert.textFields![0] as UITextField
            self.passwordLabel.text = newPasswordField.text!
        }))
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func showTakenAlert() {
        
        let alert = UIAlertController(title: "Username already taken", message: "Please try again", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func finishButton(_ sender: Any) {
        
        let user = UserList.getUser(username: UserList.getCurrentUser())
        // get removed user before removing it
        let editedUser = User(username: usernameLabel.text!, password: passwordLabel.text!, accountType: AccountType(rawValue: newUserTypeField.text!)!)
        
        var copyDict = UserList.getUserList()
        copyDict.removeValue(forKey: user.getName())
        // clear dictionary key-value pair
        UserList.setUserList(userDict: copyDict)
        if (UserList.addUser(u: editedUser) == true) {
            UserList.setCurrentUser(name: editedUser.getName())
            self.performSegue(withIdentifier: "showAppFromProfile", sender: self)
        } else {
            showTakenAlert()
        }
        
    }
    
    
    // functions for picker views
    
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
        tempUserTypeField = pickerData[row]
    }
    
    func donePicker(sender: UIBarButtonItem) {
        newUserTypeField.text = tempUserTypeField
        self.view.endEditing(true)
    }
    
    func cancelPicker(sender: UIBarButtonItem) {
        self.view.endEditing(true)
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
