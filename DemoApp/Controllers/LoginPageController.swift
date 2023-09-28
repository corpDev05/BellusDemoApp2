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
        
        let value = UserDefaults.standard.string(forKey: "Email")
          if value != nil
          {
            navigation()
             
          }
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
           createAlert("Error", "Enter a valid Email", "else")
        }
        
        if passwordTextField.text?.count == 0 {
            createAlert("Error", "Password cannot be empty", "else")
        }
        else{
        createAlert("Saving","Do you want to Save Login Details", "Saving")
    }
        
    }
    
    func  createAlert(_ title: String,_ message: String,_ sender: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
          if(sender == "Saving")
          {
            let yesButton = UIAlertAction(title: "Yes", style: .default) { (action) in
                
                let defaults = UserDefaults.standard
                defaults.set(self.emailTextField.text!,forKey: "Email")
                defaults.set(self.passwordTextField.text!,forKey: "Password")
                print(defaults.object(forKey: "Email"))
                print(defaults.object(forKey: "Password"))
                self.navigation()
            }
            
            let noButton = UIAlertAction(title: "No", style: .default) { (action) in
                 print("You have not saved login details")
                self.navigation()
            }
            alert.addAction(yesButton)
            alert.addAction(noButton)
          }
          else{
            let okayButton = UIAlertAction(title: "okay", style: .default) { (action) in
                alert.dismiss(animated: true) {
                }
        }
            alert.addAction(okayButton)
          }
        self.present(alert, animated: true, completion: nil)
    }
    
    func navigation(){
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "dashboardVC") as? DashboardViewController
        self.navigationController?.pushViewController(vc!, animated: true)
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
