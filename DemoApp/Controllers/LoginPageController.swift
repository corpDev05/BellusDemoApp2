//
//  ViewController.swift
//  DemoApp
//
//  Created by Bellubis-WS29 on 25/09/23.
//  Copyright © 2023 Bellubis-WS29. All rights reserved.
//

import UIKit

class LoginPageController: UIViewController ,UITextFieldDelegate {
    @IBOutlet var loginBtn: UIButton!
    
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var emailView: UIView!
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var imageView: UIImageView!
 
    @IBOutlet var imageHeight: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
       // emailTextField.layer.cornerRadius = 4.0
       
        loginBtn.layer.cornerRadius = 4.0
        emailTextField.layer.cornerRadius = 24.0
        passwordTextField.layer.cornerRadius = 24.0
         self.hideKeyboardWhenTappedAround()
         setHeightOfImageView(imageView)
          debugPrint(" the height of the logo image is \(imageHeight)")
        //setHeightOfImageView(imageView)
        
        //emailView.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        true
    }
    
    func setHeightOfImageView(_ view : UIImageView){
        let screenSize: CGRect = UIScreen.main.bounds
        let multiplier = 0.133
        print("Screen size  = \(screenSize)")
        imageHeight.constant = screenSize.height * CGFloat(multiplier)
        print(" the height of the logo image is \(imageHeight)")
        
        
        
        
    }
    
  
   @IBAction func emailTextCheck(_ sender: Any) {
      
       /* if let email = emailTextField.text
        {
            if let errorMessage = invalidEmail(email)
            {
                
                emailTextField.placeholder = "Please enter a valid Email"
            }
            else{
                emailTextField.placeholder = "Enter your Email address"
            }
        }*/
    
    }
    
    func invalidEmail(_ value:String) -> String?
    {
        let regularExpression =  "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        if !predicate.evaluate(with : value){
            return "Invalid Email address"
        }
        return nil
    }
    
    @IBAction func loginBtnClk(_ sender: Any) {
        
        if let error = invalidEmail(emailTextField.text!)
        {
            let alert1 = UIAlertController(title: "Error", message: "Please Enter a Valid Email address", preferredStyle: .alert)
            let okayButton = UIAlertAction(title: "okay", style: .default) { (action) in
                alert1.dismiss(animated: true) {
                }
        }
            alert1.addAction(okayButton)
            present(alert1, animated: true, completion: nil)
        }
        else{
        let alert = UIAlertController(title: "Saving", message: "Do you want to Save Login Details", preferredStyle: .alert)
        
        let yesButton = UIAlertAction(title: "Yes", style: .default) { (action) in
            
            let defaults = UserDefaults.standard
            defaults.set(self.emailTextField.text!,forKey: "Email")
            defaults.set(self.passwordTextField.text!,forKey: "Password")
            print(defaults.object(forKey: "Email"))
            print(defaults.object(forKey: "Password"))
        }
        
        let noButton = UIAlertAction(title: "No", style: .default) { (action) in
             print("You have not saved login details")
        }
        alert.addAction(yesButton)
        alert.addAction(noButton)
        present(alert, animated: true, completion: nil)
    }
    
    }
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
//Now in every UIViewController, all you have to do is call this function:

//override func viewDidLoad() {
//    super.viewDidLoad()
//    self.hideKeyboardWhenTappedAround()
//}
