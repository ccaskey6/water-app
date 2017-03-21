//
//  LoginViewController.swift
//  WaterApp
//
//  Created by Corey Caskey on 3/19/17.
//  Copyright © 2017 Corey Caskey. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var userText: UITextField!
    @IBOutlet weak var passText: UITextField!
        
//    fileprivate let userCheck: String = "user";
//    fileprivate let passCheck: String = "pass";
//    //declare constants to hold hard-coded login credentials
//    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func loginButton(_ sender: Any) {
        if (Array(UserList.getUserListKeys()).contains(userText.text!) && UserList.getValue(key: userText.text!) == passText.text!) {
            UserList.setCurrentUser(name: userText.text!)
            userText.text = ""
            passText.text = ""
            self.performSegue(withIdentifier: "showAppFromLogin", sender: self)
        } else {
            showAlert()
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Invalid Login Credentials", message: "Try again", preferredStyle: .alert)
        
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
