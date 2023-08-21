//
//  LoginViewController.swift
//  Zwallet
//
//  Created by DDL13 on 08/08/23.
//

import UIKit



class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailIconImage: UIImageView!
    @IBOutlet weak var emailSeparator: UIView!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordIconImage: UIImageView!
    @IBOutlet weak var passwordSeparator: UIView!
    
    @IBOutlet weak var showPasswordButton: UIButton!
    
    @IBOutlet weak var viewLogin: UIView!
    
    @IBOutlet weak var loginButton: CustomButton!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
//        roundedView()
    }
    
    func setup() {
        setError(message: nil)
        setLoginButton(enabled: false)
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        let text1 = "Don't have an account? Let's"
        let text2 = "Sign Up"
        
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
        signUpButton.setAttributedTitle(attText, for: .normal)
    }

    @IBAction func toogleButtonSecure(_ sender: Any) {
        let isSecureTextEntry  = !passwordTextField.isSecureTextEntry
        passwordTextField.isSecureTextEntry = isSecureTextEntry
        if #available(iOS 13.0, *) {
            showPasswordButton.setImage(isSecureTextEntry ? UIImage(systemName: "eye.slash") : UIImage(systemName: "eye"), for: .normal)
        } else {
            
        }
    }
    
    @IBAction func forgotPasswordButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Forgot")
        navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        view.endEditing(true)
        let email: String = emailTextField.text ?? ""
        let password: String = passwordTextField.text ?? ""
        AuthApiServices().login(email: email, password: password) { data, error in
            if let loginData = data {
                UserDefaults.standard.set(loginData.token, forKey: "AccessToken")
                self.showProfile()
            } else {
                self.showError()
                self.setError(message: "Email or Password Invalid")
            }
        }
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Register")
        
        let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow})
        window?.rootViewController = UINavigationController(rootViewController: viewController)
    }
    
}

extension LoginViewController {
    func setLoginButton(enabled: Bool) {
        loginButton.isEnabled = enabled
    }
    
    func showProfile() {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Tabbar")
        
        let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow})
        window?.rootViewController = UINavigationController(rootViewController: viewController)
    }
    
    func showError() {
        emailIconImage.tintColor = .red
        emailSeparator.backgroundColor = .red
        passwordIconImage.tintColor = .red
        passwordSeparator.backgroundColor = .red
    }
    
    func setError(message: String?) {
        if let message = message {
            errorLabel.text = message
            errorLabel.isHidden = false
        } else {
            errorLabel.isHidden = true
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = NSString(string: textField.text ?? "").replacingCharacters(in: range, with: string)
        
        if textField == emailTextField {
            if text.isEmail && (passwordTextField.text ?? "").count > 3 {
                loginButton.backgroundColor = UIColor(named: "Primary")
                loginButton.tintColor = .white
                loginButton.isEnabled = true
            } else {
                loginButton.backgroundColor = UIColor(named: "SecondaryButton")
                loginButton.tintColor = UIColor(named: "SecondaryText")
                loginButton.isEnabled = false
                }
        } else if textField == passwordTextField {
            if text.count > 3 && (emailTextField.text ?? "").isEmail {
                loginButton.backgroundColor = UIColor(named: "Primary")
                loginButton.tintColor = .white
                loginButton.isEnabled = true
            } else {
                loginButton.backgroundColor = UIColor(named: "SecondaryButton")
                loginButton.tintColor = UIColor(named: "SecondaryText")
                loginButton.isEnabled = false
                }
        }
        return true
    }
   

    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case emailTextField:
            emailIconImage.tintColor = UIColor(named: "Primary")
            emailSeparator.backgroundColor = UIColor(named: "Primary")
            loginButton.isEnabled = false
            
            
        case passwordTextField:
            passwordIconImage.tintColor = UIColor(named: "Primary")
            passwordSeparator.backgroundColor = UIColor(named: "Primary")
            
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        switch textField {
        case emailTextField:
            if !(emailTextField.text ?? "").isEmpty {
                emailIconImage.tintColor = UIColor(named: "Primary")
                emailSeparator.backgroundColor = UIColor(named: "Primary")
    
            } else {
                emailIconImage.tintColor = UIColor(named: "SecondaryButton")
                emailSeparator.backgroundColor = UIColor(named: "SecondaryButton")
                loginButton.isEnabled = false
            }
        case passwordTextField:
            if !(passwordTextField.text ?? "").isEmpty {
                passwordIconImage.tintColor = UIColor(named: "Primary")
                passwordSeparator.backgroundColor = UIColor(named: "Primary")
                
            } else {
                passwordIconImage.tintColor = UIColor(named: "SecondaryButton")
                passwordSeparator.backgroundColor = UIColor(named: "SecondaryButton")
                loginButton.isEnabled = false
            }
        default:
            break
        }
    }
}


