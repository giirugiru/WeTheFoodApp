//
//  FoodDetailViewController.swift
//  WeTheFoodApp v1
//
//  Created by Gilang Sinawang on 14/01/21.
//

import UIKit
import Alamofire
import Kingfisher

class FoodDetailViewController: UIViewController {
    
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var ingredientsTableView: UITableView!
    @IBOutlet weak var instructionsTextView: UITextView!
    @IBOutlet weak var instructionBgView: UIView!
    
    
    // API Variables
    var baseURL = "https://www.themealdb.com/"
    var endpoint1 = "api/json/v1/1/lookup.php?i="
    var key = ""
    
    // Main Variables
    var foodID = ""
    var foodDetail = [FoodDetailMeal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTable()
        fetchData(ep: endpoint1)
    }
    
    func setupView(){
        self.navigationItem.title = "Recipe"
        self.navigationItem.backButtonTitle = ""
        instructionBgView.layer.cornerRadius = 15
        foodImage.layer.cornerRadius = 30
        
        let profileButton = UIBarButtonItem(image: UIImage(named: "profile-icon"), style: .plain, target: self, action: #selector(profileButtonTapped(_:)))
        self.navigationItem.rightBarButtonItem  = profileButton
    }
    
    func fetchData(ep: String){
        let url = baseURL + ep + foodID
        print(url)
        // Alamofire
        AF.request(url, method: .get).responseJSON { (response) in
            let data = response.data
            do{
                let APIData = try JSONDecoder().decode(FoodDetailWelcome.self, from: data!)
                let fetchedData = APIData.meals
//                fetchedData
                self.foodDetail.append(contentsOf: fetchedData)
                print(self.foodDetail)
                self.setupData()
            } catch {
                print(error.localizedDescription)
            }
            
        }
    }
    
    func setupTable(){
        //ingredientsTableView.register(UINib.init(nibName: "FoodListTableViewCell", bundle: nil), forCellReuseIdentifier: "FoodListTableViewCell")
//        ingredientsTableView.dataSource = self
//        ingredientsTableView.delegate = self
    }
    
    func setupData(){
        let imageURL = URL(string: foodDetail[0].strMealThumb)
        foodImage.kf.setImage(with: imageURL)

        foodNameLabel.text = foodDetail[0].strMeal

        instructionsTextView.text = foodDetail[0].strInstructions
        //print(foodDetail.count)
    }
    
    @objc func profileButtonTapped(_ sender:UIBarButtonItem!){
        let vc = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }


}

//extension FoodDetailViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 0
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "basicStyle", for: indexPath)
//        return cell
//    }
//    
//    
//}
