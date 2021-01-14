//
//  ViewController.swift
//  WeTheFoodApp v1
//
//  Created by Gilang Sinawang on 14/01/21.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController {
    
    var baseURL = "https://www.themealdb.com/"
    var endpoint1 = "api/json/v1/1/list.php?a=list"
    var key = ""
    
    var nationList = [AreaMeal]()
    //var nationList: [String] = []
    
    @IBOutlet weak var homeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTable()
        fetchData(ep: endpoint1)
        // Do any additional setup after loading the view.
        homeTableView.reloadData()
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
                //let fetchedData = APIData.meals
                //self.nationList.append(contentsOf: APIData.meals)
                let fetchedData = APIData.meals
               // for index in 0..<fetchedData.count {
                    //self.nationList.append(fetchedData[index].strArea)
                    self.nationList.append(contentsOf: fetchedData)
                    //print(fetchedData[index].strArea)
                    print(self.nationList)
                //}
                
                print("Fetching success")
                self.homeTableView.reloadData()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        cell.flagImage.image = UIImage(named: "British")
        //cell.areaNameLabel.text = nationList[indexPath.row]
        cell.areaNameLabel.text = nationList[indexPath.row].strArea
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let id = listKunjunganApotekAPI[indexPath.row].idKunjungan
//        let vc = DetailPrbViewController(nibName: "DetailPrbViewController", bundle: nil)
//        vc.idKunjunganApotek = id
//        self.navigationController?.pushViewController(vc, animated: true)
        let areaSent = nationList[indexPath.row].strArea
//        let vc = 
    }
    
}

