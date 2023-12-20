//
//  RegisterViewController.swift
//  MeetApp
//
//  Created by Izbassar on 17.12.2023.
//

import UIKit
import ProgressHUD

class RegisterViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var dateOfBirthTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var genderSegmentOutlet: UISegmentedControl!
    @IBOutlet weak var backgroundImageView: UIImageView! 
    
    // MARK: - Vars
    var isMale = true
    var datePicker = UIDatePicker()
    
    // MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .dark
        setupBackgroundTouch()
        setupDatePicker()
    }
    
    // MARK: - Actions
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        if isTextDataImputed() {
            //register the user
            
            if passwordTextField.text! == confirmPasswordTextField.text! {
                registerUser()
            } else {
                ProgressHUD.failed("Passwords don't match!", interaction: true, delay: 0.8)
            }
        } else {
            ProgressHUD.failed("All fields are required!", interaction: true, delay: 0.8)
        }
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func genderSegmentValueChanged(_ sender: UISegmentedControl) {
        isMale = sender.selectedSegmentIndex == 0
    }
    
    // MARK: - Setup
    private func setupDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(handleDatePicker), for: .valueChanged)
        dateOfBirthTextField.inputView = datePicker
        
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor().primary()
        toolBar.sizeToFit()
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dismissKeyboard))
        
        let spacerButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissKeyboard))
        
        toolBar.setItems([cancelButton, spacerButton, doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        
        dateOfBirthTextField.inputAccessoryView = toolBar
    }
    
    private func setupBackgroundTouch() {
        backgroundImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTab))
        backgroundImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc func backgroundTab() {
        dismissKeyboard()
    }
    
    // MARK: - Helpers
    @objc func dismissKeyboard() {
        self.view.endEditing(false)
    }
    
    @objc func handleDatePicker() {
        dateOfBirthTextField.text = datePicker.date.longDate()
    }
    
    private func isTextDataImputed() -> Bool {
        return usernameTextField.text != "" && emailTextField.text != "" &&
        cityTextField.text != "" && dateOfBirthTextField.text != "" &&
        passwordTextField.text != "" && confirmPasswordTextField.text != ""
    }
    
    // MARK: - RegisterUser
    private func registerUser() {
        
        ProgressHUD.animate()
        
        FUser.registerUserWith(email: emailTextField.text!, password: passwordTextField.text!, userName: usernameTextField.text!, city: cityTextField.text!, isMale: isMale, dateOfBirth: Date()) { error in
            
            ProgressHUD.dismiss()
            
            if error == nil {
                ProgressHUD.succeed("Verification email sent!")
                self.dismiss(animated: true, completion: nil)
            } else {
                ProgressHUD.error(error!.localizedDescription)
            }
            
        }
    }
    
}
