//
//  HomeViewController.swift
//  Zwallet
//
//  Created by DDL13 on 12/08/23.
//

import UIKit
import Kingfisher

struct History {
    let image: UIImage
    let name: String
    let desc: String
    let price: String
    let tagColor: Int
}

class HomeViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet var tableView: UITableView!
    
    let history: [History] = [
        History(image: UIImage(named: "pic2")!, name: "Samuel Suhi", desc: "Transfer", price: "+Rp50.000", tagColor: 1),
        History(image: UIImage(named: "spotify")!, name: "Spotify", desc: "Subscription", price: "-Rp49.000", tagColor: 0),
        History(image: UIImage(named: "net")!, name: "Netflix", desc: "Subscription", price: "-Rp129.000", tagColor: 0),
        History(image: UIImage(named: "pic3")!, name: "Bobi Sammy", desc: "Transfer", price: "+Rp150.000", tagColor: 1),
    ]
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        AuthApiServices().getProfile { data in
//            if let profileData = data {
//                UserDefaults.standard.set(profileData.image, forKey: "image")
//                UserDefaults.standard.set(profileData.firstName, forKey: "firstName")
//                UserDefaults.standard.set(profileData.lastName, forKey: "lastName")
//                UserDefaults.standard.set(profileData.phone, forKey: "phone")
//                self.profileImage.kf.setImage(with: URL(string: "\(Constant.baseURL) \(Constant.image ?? "")"))
//            } else {
//                print("error")
//            }
//        }
//    }
    
    func setup() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "HistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CELL_ID")
        
//        profileImage.kf.setImage(with: URL(string: "\(Constant.baseURL) \(Constant.image ?? "")"))
//        nameLabel.text = "\(Constant.firsName ?? "") \(Constant.lastName ?? "")"
//        phoneLabel.text = "\(Constant.phone ?? "")"
        
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return history.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    internal func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let cellSpacingHeight: CGFloat = 5

        return cellSpacingHeight
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL_ID", for: indexPath) as! HistoryTableViewCell
        
        let histories = history[indexPath.section]
        cell.imageCell.image = histories.image
        cell.nameLabel.text = histories.name
        cell.descLabel.text = histories.desc
        cell.priceLabel.text = histories.price
        cell.backgroundColor = UIColor.white
        cell.layer.cornerRadius = 15
        cell.clipsToBounds = true
        
        if histories.tagColor == 1 {
            cell.priceLabel.textColor = UIColor(named: "Green")
        } else {
            cell.priceLabel.textColor = .red
        }
        
        return cell
    }
    
}


