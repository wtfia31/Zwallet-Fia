//
//  NewPasswordViewController.swift
//  Zwallet
//
//  Created by DDL13 on 12/08/23.
//

import UIKit

class NewPasswordViewController: UIViewController {

    
    @IBOutlet weak var newPasswordIconImage: UIImageView!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordSeparator: UIView!
    
    
    @IBOutlet weak var confirmIconImage: UIImageView!
    @IBOutlet weak var confirmTextField: UITextField!
    @IBOutlet weak var confirmSeparator: UIView!
    
    
    @IBOutlet weak var showPasswordButton: UIButton!
    
    @IBOutlet weak var showConfirmPasswordButton: UIButton!
    
    
    @IBOutlet weak var confirmButton: CustomButton!
    
    var email: String = ""
    
    override func viewDidLoad() {
            super.viewDidLoad()

            // Do any additional setup after loading the view.
            setup()
        }
        
        func setup() {
            newPasswordTextField.delegate = self
            confirmTextField.delegate = self
            resetPasswordButton(enabled: false)
        }
    
    @IBAction func newPasswordToogle(_ sender: Any) {
        let isSecureTextEntry  = !newPasswordTextField.isSecureTextEntry
        newPasswordTextField.isSecureTextEntry = isSecureTextEntry
        if #available(iOS 13.0, *) {
            showPasswordButton.setImage(isSecureTextEntry ? UIImage(systemName: "eye.slash") : UIImage(systemName: "eye"), for: .normal)
        } else {
            
        }
    }
    
    @IBAction func confirmPasswordToogle(_ sender: Any) {
        let isSecureTextEntry  = !confirmTextField.isSecureTextEntry
        confirmTextField.isSecureTextEntry = isSecureTextEntry
        if #available(iOS 13.0, *) {
            showConfirmPasswordButton.setImage(isSecureTextEntry ? UIImage(systemName: "eye.slash") : UIImage(systemName: "eye"), for: .normal)
        } else {
            
        }
    }
    
    
    
    @IBAction func confirmPasswordButtonTapped(_ sender: Any) {
        let email: String = email 
        let password: String = newPasswordTextField.text ?? ""
        AuthApiServices().forgotPassword(email: email, password: password) { data, error in
            if data != nil {
                    self.showLogin()
                }
             else {
                print("Gagal")
            }
        }
    }
}
    

extension NewPasswordViewController {
    func showLogin() {
        let alert = UIAlertController(
            title: "Success",
            message: "Password anda telah diperbarui \nSilahkan login",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Login", style: .cancel, handler: { action in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "Login")
            
            let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow})
            window?.rootViewController = UINavigationController(rootViewController: viewController)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func resetPasswordButton(enabled: Bool) {
        confirmButton.isEnabled = enabled
    }
}
 

extension NewPasswordViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = NSString(string: textField.text ?? "").replacingCharacters(in: range, with: string)
        
        if textField == newPasswordTextField {
            if text.count > 3 && text == (confirmTextField.text ?? "") {
                confirmButton.backgroundColor = UIColor(named: "Primary")
                confirmButton.tintColor = .white
                confirmButton.isEnabled = true
            } else {
                confirmButton.backgroundColor = UIColor(named: "SecondaryButton")
                confirmButton.tintColor = UIColor(named: "SecondaryText")
                confirmButton.isEnabled = false
                }
        } else if textField == confirmTextField {
            if text == (newPasswordTextField.text ?? "") {
                confirmButton.backgroundColor = UIColor(named: "Primary")
                confirmButton.tintColor = .white
                confirmButton.isEnabled = true
            } else {
                confirmButton.backgroundColor = UIColor(named: "SecondaryButton")
                confirmButton.tintColor = UIColor(named: "SecondaryText")
                confirmButton.isEnabled = false
            }
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case newPasswordTextField:
            newPasswordIconImage.tintColor = UIColor(named: "Primary")
            newPasswordSeparator.backgroundColor = UIColor(named: "Primary")
        case confirmTextField:
            confirmIconImage.tintColor = UIColor(named: "Primary")
            confirmSeparator.backgroundColor = UIColor(named: "Primary")
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case newPasswordTextField:
            if !(newPasswordTextField.text ?? "").isEmpty {
                newPasswordIconImage.tintColor = UIColor(named: "Primary")
                newPasswordSeparator.backgroundColor = UIColor(named: "Primary")
            } else {
                newPasswordIconImage.tintColor = UIColor(named: "SecondaryButton")
                newPasswordSeparator.backgroundColor = UIColor(named: "SecondaryButton")
            }
            
        case confirmTextField:
            if !(confirmTextField.text ?? "").isEmpty {
                confirmIconImage.tintColor = UIColor(named: "Primary")
                confirmSeparator.backgroundColor = UIColor(named: "Primary")
            } else {
                confirmIconImage.tintColor = UIColor(named: "SecondaryButton")
                confirmSeparator.backgroundColor = UIColor(named: "SecondaryButton")
            }
            
        default:
            break
        }
    }
}
