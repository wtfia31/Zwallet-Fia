//
//  OTPViewController.swift
//  Zwallet
//
//  Created by DDL13 on 13/08/23.
//

import UIKit

class OTPViewController: UIViewController {
    
    @IBOutlet weak var pin1: UITextField!
    @IBOutlet weak var pin2: UITextField!
    @IBOutlet weak var pin3: UITextField!
    @IBOutlet weak var pin4: UITextField!
    @IBOutlet weak var pin5: UITextField!
    @IBOutlet weak var pin6: UITextField!
    
    @IBOutlet weak var confirmButton: CustomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pin1.becomeFirstResponder()
    }
    
    func setup() {
        resetButton(enabled: false)
        pin1.delegate = self
        pin2.delegate = self
        pin3.delegate = self
        pin4.delegate = self
        pin5.delegate = self
        pin6.delegate = self
    }
    
    @IBAction func confirmButtonTapped(_ sender: Any) {
            self.showLogin()
        }
}

extension OTPViewController {
    
    func resetButton(enabled: Bool) {
        confirmButton.isEnabled = enabled
    }
    
    func showLogin() {
        let alert = UIAlertController(
            title: "Success",
            message: "Your account was succesfully created. \nLogin to your new account and start exploring!",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Login", style: .cancel, handler: { action in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "Login")
            
            let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow})
            window?.rootViewController = UINavigationController(rootViewController: viewController)
        }))
        self.present(alert, animated: true)
    }
}

extension OTPViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if ((textField.text?.count)! <= 1) && (string.count > 0) {
            switch textField {
            case pin1:
                pin2.becomeFirstResponder()
                break
            case pin2:
                pin3.becomeFirstResponder()
                break
            case pin3:
                pin4.becomeFirstResponder()
                break
            case pin4:
                pin5.becomeFirstResponder()
                break
            case pin5:
                pin6.becomeFirstResponder()
                break
            case pin6:
                pin6.resignFirstResponder()
                confirmButton.isEnabled = true
                break
            default:
                break
            }
            
            textField.text = string
            return false
            
        } else if ((textField.text?.count)! >= 1) && (string.count == 0) {
            switch textField {
            case pin2:
                pin1.becomeFirstResponder()
                confirmButton.isEnabled = false
                break
            case pin3:
                pin2.becomeFirstResponder()
                confirmButton.isEnabled = false
                break
            case pin4:
                pin3.becomeFirstResponder()
                confirmButton.isEnabled = false
                break
            case pin5:
                pin4.becomeFirstResponder()
                confirmButton.isEnabled = false
                break
            case pin6:
                pin5.becomeFirstResponder()
                confirmButton.isEnabled = false
                break
            case pin1:
                pin1.becomeFirstResponder()
                confirmButton.isEnabled = false
                break
            default:
                break
            }
            
            textField.text = ""
            return false
        } else if (textField.text?.count)! >= 1 {
            
            textField.text = string
            return false
        } else {
            
            return true
        }
        
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let color = UIColor(named: "Primary")
            switch textField {
            case pin1:
                pin1.layer.borderWidth = 1
                pin1.layer.borderColor = color?.cgColor
                pin1.layer.cornerRadius = 5
            case pin2:
                pin2.layer.borderWidth = 1
                pin2.layer.borderColor = color?.cgColor
                pin2.layer.cornerRadius = 5
            case pin3:
                pin3.layer.borderWidth = 1
                pin3.layer.borderColor = color?.cgColor
                pin3.layer.cornerRadius = 5
            case pin4:
                pin4.layer.borderWidth = 1
                pin4.layer.borderColor = color?.cgColor
                pin4.layer.cornerRadius = 5
            case pin5:
                pin5.layer.borderWidth = 1
                pin5.layer.borderColor = color?.cgColor
                pin5.layer.cornerRadius = 5
            case pin6:
                pin6.layer.borderWidth = 1
                pin6.layer.borderColor = color?.cgColor
                pin6.layer.cornerRadius = 5
            default:
                break
            }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        let color1 = UIColor(named: "Primary")
        let color2 = UIColor(named: "SecondaryText60")
        switch textField {
        case pin1:
            if  !(pin1.text ?? "").isEmpty {
                pin1.layer.borderWidth = 1
                pin1.layer.borderColor = color2?.cgColor
                pin1.layer.cornerRadius = 5
            } else {
                pin1.layer.borderWidth = 1
                pin1.layer.borderColor = color1?.cgColor
                pin1.layer.cornerRadius = 5
            }
        case pin2:
            if !(pin2.text ?? "").isEmpty {
                pin2.layer.borderWidth = 1
                pin2.layer.borderColor = color2?.cgColor
                pin2.layer.cornerRadius = 5
            } else {
                pin2.layer.borderWidth = 1
                pin2.layer.borderColor = color1?.cgColor
                pin2.layer.cornerRadius = 5
            }
        case pin3:
            if !(pin3.text ?? "").isEmpty {
                pin3.layer.borderWidth = 1
                pin3.layer.borderColor = color2?.cgColor
                pin3.layer.cornerRadius = 5
            } else {
                pin3.layer.borderWidth = 1
                pin3.layer.borderColor = color1?.cgColor
                pin3.layer.cornerRadius = 5
            }
        case pin4:
            if !(pin4.text ?? "").isEmpty {
                pin4.layer.borderWidth = 1
                pin4.layer.borderColor = color2?.cgColor
                pin4.layer.cornerRadius = 5
            } else {
                pin4.layer.borderWidth = 1
                pin4.layer.borderColor = color1?.cgColor
                pin4.layer.cornerRadius = 5
            }
        case pin5:
            if !(pin5.text ?? "").isEmpty {
                pin5.layer.borderWidth = 1
                pin5.layer.borderColor = color2?.cgColor
                pin5.layer.cornerRadius = 5
            } else {
                pin5.layer.borderWidth = 1
                pin5.layer.borderColor = color1?.cgColor
                pin5.layer.cornerRadius = 5
            }
        case pin6:
            if !(pin6.text ?? "").isEmpty {
                pin6.layer.borderWidth = 1
                pin6.layer.borderColor = color2?.cgColor
                pin6.layer.cornerRadius = 5
                confirmButton.backgroundColor = UIColor(named: "SecondaryButton")
                confirmButton.tintColor = UIColor(named: "SecondaryText")
            } else {
                pin6.layer.borderWidth = 1
                pin6.layer.borderColor = color1?.cgColor
                pin6.layer.cornerRadius = 5
                confirmButton.backgroundColor = UIColor(named: "Primary")
                confirmButton.tintColor = .white
            }
       
        default:
            break
            
        }
    }
}
