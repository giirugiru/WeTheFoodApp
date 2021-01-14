//
//  ViewController.swift
//  WeTheFoodApp v1
//
//  Created by Gilang Sinawang on 14/01/21.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController {

    @IBOutlet weak var homeTableView: UITableView!
    
    // API Variables
    var baseURL = "https://www.themealdb.com/"
    var endpoint1 = "api/json/v1/1/list.php?a=list"
    var key = ""
    
    // Main Variables
    var nationList = [AreaMeal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTable()
        fetchData(ep: endpoint1)
        homeTableView.reloadData()
    }
    
    func setupView(){
        self.navigationItem.title = "Home"
        let profileButton = UIBarButtonItem(image: UIImage(named: "profile-icon"), style: .plain, target: self, action: #selector(profileButtonTapped(_:)))
        self.navigationItem.rightBarButtonItem  = profileButton
    }
    
    func setupTable(){
        homeTableView.register(UINib.init(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        homeTableView.dataSource = self
        homeTableView.delegate = self
        homeTableView.reloadData()
    }
    
    func fetchData(ep: String){
        nationList.removeAll()
        let url = baseURL + ep
        //Alamofire
        AF.request(url, method: .get).responseJSON { (response) in
            let data = response.data
            do{
                let APIData = try JSONDecoder().decode(AreaWelcome.self, from: data!)
                let fetchedData = APIData.meals
                self.nationList.append(contentsOf: fetchedData)            
                print("Fetching success")
                self.homeTableView.reloadData()
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

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        cell.flagImage.image = UIImage(named: nationList[indexPath.row].strArea)
        cell.areaNameLabel.text = nationList[indexPath.row].strArea
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let areaSent = nationList[indexPath.row].strArea
        let vc = FoodListViewController(nibName: "FoodListViewController", bundle: nil)
        vc.areaFilter = areaSent
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

