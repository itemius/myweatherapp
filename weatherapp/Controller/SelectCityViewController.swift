//
//  SelectCityViewController.swift
//  weatherapp
//
//  Created by itemius on 25.09.2023.
//

import UIKit

class SelectCityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var cityTableView: UITableView!
    
    var cityList = ["London", "Paris", "Moscow", "Berlin", "Prague", "Roma", "Madrid"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cityTableView.delegate = self
        cityTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = cityList[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(cityList[indexPath.row], forKey: "city")

        self.dismiss(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
