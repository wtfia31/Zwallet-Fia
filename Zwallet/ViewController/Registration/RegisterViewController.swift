//
//  RegisterViewController.swift
//  Zwallet
//
//  Created by DDL13 on 08/08/23.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameIconImage: UIImageView!
    @IBOutlet weak var nameSeparator: UIView!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailIconImage: UIImageView!
    @IBOutlet weak var emailSeparator: UIView!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordIconImage: UIImageView!
    @IBOutlet weak var passwordSeparator: UIView!
    
    @IBOutlet weak var signUpButton: CustomButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var toogleButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }

    @IBAction func loginButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Login")
        
        let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow})
        window?.rootViewController = UINavigationController(rootViewController: viewController)
    }
    
    @IBAction func toogleButtonSecured(_ sender: Any) {
        let isSecureTextEntry  = !passwordTextField.isSecureTextEntry
        passwordTextField.isSecureTextEntry = isSecureTextEntry
        if #available(iOS 13.0, *) {
            toogleButton.setImage(isSecureTextEntry ? UIImage(systemName: "eye.slash") : UIImage(systemName: "eye"), for: .normal)
        } else {
            
        }
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        let name: String = nameTextField.text ?? ""
        let email: String = emailTextField.text ?? ""
        let password: String = passwordTextField.text ?? ""
        AuthApiServices().signUp(username: name, email: email, password: password) { data, error in
            if data != nil {
                self.showOTP()
            } else {
                print("Gagal")
            }
        }
        
    }
    
    func setup() {
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        signUpButton(enabled: false)
        
        let text1 = "Already have an account? Let's"
        let text2 = "Login"
        
        let attText = NSMutableAttributedString(string: "\(text1) \(text2)")
        attText.addAttributes(
            [
            .foregroundColor: UIColor(named: "SecondaryText")!,
            .font: UIFont.systemFont(ofSize: 14, weight: .regular)
        ],
        range: NSString(string: attText.string).range(of: text1)
        )
        
        attText.addAttributes(
            [
            .foregroundColor: UIColor(named: "Primary")!,
            .font: UIFont.systemFont(ofSize: 14, weight: .bold),
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ],
        range: NSString(string: attText.string).range(of: text2)
        )
        loginButton.setAttributedTitle(attText, for: .normal)
    }
}

extension RegisterViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = NSString(string: textField.text ?? "").replacingCharacters(in: range, with: string)
        
        if textField == emailTextField {
            if text.isEmail && (passwordTextField.text ?? "").count > 3 {
                signUpButton.backgroundColor = UIColor(named: "Primary")
                signUpButton.tintColor = .white
                signUpButton.isEnabled = true
            } else {
                signUpButton.backgroundColor = UIColor(named: "SecondaryButton")
                signUpButton.tintColor = UIColor(named: "SecondaryText")
                signUpButton.isEnabled = false
                }
        } else if textField == passwordTextField {
            if text.count > 3 && (emailTextField.text ?? "").isEmail {
                signUpButton.backgroundColor = UIColor(named: "Primary")
                signUpButton.tintColor = .white
                signUpButton.isEnabled = true
            } else {
                signUpButton.backgroundColor = UIColor(named: "SecondaryButton")
                signUpButton.tintColor = UIColor(named: "SecondaryText")
                signUpButton.isEnabled = false
                }
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case nameTextField:
            nameIconImage.tintColor = UIColor(named: "Primary")
            nameSeparator.backgroundColor = UIColor(named: "Primary")
        case emailTextField:
            emailIconImage.tintColor = UIColor(named: "Primary")
            emailSeparator.backgroundColor = UIColor(named: "Primary")
        case passwordTextField:
            passwordIconImage.tintColor = UIColor(named: "Primary")
            passwordSeparator.backgroundColor = UIColor(named: "Primary")
        default:
            break
        }
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        switch textField {
        case nameTextField:
            if !(nameTextField.text ?? "").isEmpty {
                nameIconImage.tintColor = UIColor(named: "Primary")
                nameSeparator.backgroundColor = UIColor(named: "Primary")
            } else {
                nameIconImage.tintColor = UIColor(named: "SecondaryButton")
                nameSeparator.backgroundColor = UIColor(named: "SecondaryButton")

            }
            
        case emailTextField:
            if !(nameTextField.text ?? "").isEmpty {
                emailIconImage.tintColor = UIColor(named: "Primary")
                emailSeparator.backgroundColor = UIColor(named: "Primary")

            } else {
                emailIconImage.tintColor = UIColor(named: "SecondaryButton")
                emailSeparator.backgroundColor = UIColor(named: "SecondaryButton")
            }
            
        case passwordTextField:
            if !(nameTextField.text ?? "").isEmpty {
                passwordIconImage.tintColor = UIColor(named: "Primary")
                passwordSeparator.backgroundColor = UIColor(named: "Primary")

            } else {
                passwordIconImage.tintColor = UIColor(named: "SecondaryButton")
                passwordSeparator.backgroundColor = UIColor(named: "SecondaryButton")
            }
        default:
            break
        }
    }
}

extension RegisterViewController {
    func showOTP() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "OTP")
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func signUpButton(enabled: Bool) {
        signUpButton.isEnabled = enabled
    }
}


