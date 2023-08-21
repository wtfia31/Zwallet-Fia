//
//  ForgotViewController.swift
//  Zwallet
//
//  Created by DDL13 on 12/08/23.
//

import UIKit

class ForgotViewController: UIViewController {
    
    var email = ""
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailIconImage: UIImageView!
    @IBOutlet weak var emailSeparator: UIView!
    
    @IBOutlet weak var confirmButton: CustomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    
    @IBAction func confirmButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "NewPassword") as? NewPasswordViewController
        
        viewController?.email = self.emailTextField.text!
        navigationController?.pushViewController(viewController!, animated: true)
    }
    
    func setup() {
        confirmButton(enabled: false)
        emailTextField.delegate = self
        
    }
    
    func confirmButton(enabled: Bool) {
        confirmButton.isEnabled = false
    }
    
}

extension ForgotViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = NSString(string: textField.text ?? "").replacingCharacters(in: range, with: string)
        
        if textField == emailTextField {
            if text.isEmail {
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
        case emailTextField:
            emailIconImage.tintColor = UIColor(named: "Primary")
            emailSeparator.backgroundColor = UIColor(named: "Primary")

        default:
            break
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case emailTextField:
            if !(emailTextField.text ?? "").isEmpty {
                emailIconImage.tintColor = UIColor(named: "Primary")
                emailSeparator.backgroundColor = UIColor(named: "Primary")

            } else {
                emailIconImage.tintColor = UIColor(named: "SecondaryButton")
                emailSeparator.backgroundColor = UIColor(named: "SecondaryButton")

            }
        default:
            break
        }
    }
}

