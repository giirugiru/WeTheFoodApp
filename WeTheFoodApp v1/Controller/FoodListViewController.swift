//
//  FoodListViewController.swift
//  WeTheFoodApp v1
//
//  Created by Gilang Sinawang on 14/01/21.
//

import UIKit
import Alamofire
import Kingfisher

class FoodListViewController: UIViewController {
    
    @IBOutlet weak var foodListTableView: UITableView!
    
    // API Variables
    var baseURL = "https://www.themealdb.com/"
    var endpoint1 = "api/json/v1/1/filter.php?a="
    var key = ""
    
    // Main Variables
    var foodList = [FoodListMeal]()
    var areaFilter = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTable()
        fetchData(ep: endpoint1)
    }
    


    func setupView(){
        self.navigationItem.title = "Food List"
        self.navigationItem.backButtonTitle = ""
        
        let profileButton = UIBarButtonItem(image: UIImage(named: "profile-icon"), style: .plain, target: self, action: #selector(profileButtonTapped(_:)))
        self.navigationItem.rightBarButtonItem  = profileButton
    }
    
    func setupTable(){
        foodListTableView.register(UINib.init(nibName: "FoodListTableViewCell", bundle: nil), forCellReuseIdentifier: "FoodListTableViewCell")
        foodListTableView.dataSource = self
        foodListTableView.delegate = self
    }
    
    func fetchData(ep: String){
        let url = baseURL + ep + areaFilter
        print(url)
        // Alamofire
        AF.request(url, method: .get).responseJSON { (response) in
            let data = response.data
            do{
                let APIData = try JSONDecoder().decode(FoodListWelcome.self, from: data!)
                let fetchedData = APIData.meals
                self.foodList.append(contentsOf: fetchedData)
                print("Fetching success")
                self.foodListTableView.reloadData()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    @objc func profileButtonTapped(_ sender:UIBarButtonItem!){
        let vc = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }



}

extension FoodListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodListTableViewCell", for: indexPath) as! FoodListTableViewCell
        
        cell.foodNameLabel.text = foodList[indexPath.row].strMeal
        let imageURL = URL(string: foodList[indexPath.row].strMealThumb)
        cell.foodImage.kf.setImage(with: imageURL)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let foodIDSent = foodList[indexPath.row].idMeal
        let vc = FoodDetailViewController(nibName: "FoodDetailViewController", bundle: nil)
        vc.foodID = foodIDSent
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
