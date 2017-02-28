//
//  AppDelegate.swift
//  LicenseIOSAppByNamedUser_Swift
//
//  Created by maklMac on 2/14/17.
//  Copyright © 2017 esrichina.com. All rights reserved.
//

import UIKit

protocol LoginVCDelegate:class {
    
    func loginViewController(_ loginViewController:LoginViewController, didInitiateLoginWithName name:String, key:String)
    
    func loginViewControllerDidCancel(_ saveAsViewController:LoginViewController)
    
    
    
}

class LoginViewController: UIViewController {
    
    @IBOutlet  weak var nameTextField:UITextField!
    @IBOutlet weak var keyTextField:UITextField!
    
    
    weak var delegate:LoginVCDelegate?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.resetInputFields()
        
        self.keyTextField.isSecureTextEntry = true
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    //reset input fields
    func resetInputFields() {
        
        self.nameTextField.text = ""
        self.keyTextField.text = ""
        
    }
    
    
    
    //MARK: - Actions
    
    @IBAction private func cancelAction() {
        
        self.resetInputFields()
        self.delegate?.loginViewControllerDidCancel(self)
        
    }
    
    @IBAction private func saveAction() {
        
        //Validations
        guard let name = self.nameTextField.text, let key = self.keyTextField.text else {
            //show error message
            print("Name and key are required fields")
            
            return
        }
        
        
        delegate?.loginViewController(self, didInitiateLoginWithName: name, key: key)
        
        self.resetInputFields()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
