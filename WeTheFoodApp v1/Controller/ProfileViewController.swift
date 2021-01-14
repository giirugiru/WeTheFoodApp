//
//  ProfileViewController.swift
//  WeTheFoodApp v1
//
//  Created by Gilang Sinawang on 14/01/21.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profileImage.layer.cornerRadius = 100
    }




}
