//
//  ProfileViewController.swift
//  Zwallet
//
//  Created by DDL13 on 13/08/23.
//

import UIKit
import Kingfisher

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var notifButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    
    
    
    func setup() {
//        profileImage.kf.setImage(with: URL(string: "\(Constant.baseURL) \(Constant.image ?? "")"))
//        nameLabel.text = "\(Constant.firsName ?? "") \(Constant.lastName ?? "")"
//        phoneLabel.text = "\(Constant.phone ?? "")"
        
    }
    
    
    @IBAction func logOutButtonTapped(_ sender: Any) {
        AuthApiServices().logout { data in
            if data != nil {
                let alert = UIAlertController(title: "Logout", message: "Do you want to Logout?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Logout", style: .destructive) { action in
                    self.logout()
                })
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            } else {
                print("Error")
            }
        }
        
    }
    
    
    
    @IBAction func notifButtonTapped(_ sender: Any) {
        let isSelected = !notifButton.isSelected
        notifButton.isSelected = isSelected
    }
}

extension ProfileViewController {
    func logout() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "Login")
            
            let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow})
            window?.rootViewController = UINavigationController(rootViewController: viewController)
        }
    }

