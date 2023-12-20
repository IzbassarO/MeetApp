//
//  WelcomeViewController.swift
//  MeetApp
//
//  Created by Izbassar on 17.12.2023.
//

import UIKit
import ProgressHUD

class WelcomeViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .dark
        setupBackgroundTouch()
    }
    
    // MARK: - Actions
    @IBAction func forgotPasswordButtonPressed(_ sender: Any) {
        
        if emailTextField.text != ""  {
            FUser.resetPassword(email: emailTextField.text!) { (error) in
                if error != nil {
                    ProgressHUD.failed(error?.localizedDescription, interaction: true, delay: 1)
                } else {
                    ProgressHUD.succeed("Please check your email!", interaction: true, delay: 1)
                }
            }
        } else {
            // show error
            ProgressHUD.failed("Please insert your email address.", interaction: true, delay: 0.8)
            
        }
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        if emailTextField.text != "" && passwordTextField.text != "" {
            
            ProgressHUD.animate()
            
            FUser.loginUserWith(email: emailTextField.text!, password: passwordTextField.text!) { error, isEmailVerified in
                if error != nil {
                    
                    ProgressHUD.failed(error!.localizedDescription)
                } else if isEmailVerified {
                    //enter the application
                    
                    ProgressHUD.dismiss()
                    self.goToApp()
                } else {
                    ProgressHUD.failed("Please verify your email", interaction: true, delay: 1)
                }
            }
            
        } else {
            // show error
            DispatchQueue.main.async(execute: {
                ProgressHUD.failed("All fields are required!", interaction: true, delay: 0.8)
            })
        }
    }
    
    // MARK: - Setup
    private func setupBackgroundTouch() {
        backgroundImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTab))
        backgroundImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc func backgroundTab() {
        dismissKeyboard()
    }
    
    // MARK: - Helpers
    private func dismissKeyboard() {
        self.view.endEditing(false)
    }
    
    // MARK: - Navigation
    private func goToApp() {
        let mainView = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainView") as! UITabBarController
        
        mainView.modalPresentationStyle = .fullScreen
        self.present(mainView, animated: true, completion: nil)
    }
}
