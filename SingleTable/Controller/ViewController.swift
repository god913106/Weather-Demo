//
//  ViewController.swift
//  SingleTable
//
//  Created by 洋蔥胖 on 2018/5/11.
//  Copyright © 2018年 ChrisYoung. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    let weatherModel = WeatherModel()
    var weatherArray : [WeatherModel] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        SVProgressHUD.show()
        alamoFire()
        
        
        tableView.backgroundView = UIImageView(image: UIImage(named: "cityBackground"))
        
        tableView.backgroundView?.alpha = 1
        tableView.contentMode = .scaleAspectFill
    }
    func alamoFire(){
        Alamofire.request("https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-D0047-091?Authorization=rdec-key-123-45678-011121314").responseJSON(completionHandler: { response in
            if response.result.isSuccess {
                print("Success! Got the weather data")
                let weatherJSON : JSON = JSON(response.result.value!)
                let weatherLocation = weatherJSON["records"]["locations"][0]["location"]
                
                let result = weatherLocation.array
                for data in result!{
                    
                    self.weatherModel.city = data["locationName"].stringValue
                    self.weatherModel.temp = data["weatherElement"][1]["time"][0]["elementValue"][0]["value"].intValue
                    
                    let newValue = WeatherModel()
                    newValue.city = self.weatherModel.city
                    newValue.temp = self.weatherModel.temp
                    
                    self.weatherArray.append(newValue)
                    self.tableView.reloadData()
                    SVProgressHUD.dismiss()
                }

            } else {
                print("Error \(String(describing: response.result.error))")
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //每一列TablViewCell 要顯示的資料
        //先產出Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.textColor = UIColor.white
        cell.detailTextLabel?.textColor = UIColor.white
        cell.textLabel?.text = weatherArray[indexPath.row].city
        cell.detailTextLabel?.text = "\(weatherArray[indexPath.row].temp)°"
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // performSegue(withIdentifier: "showGetOne", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //        if segue.identifier == "showGetOne"{
        //            if let indexPath = tableView.indexPathForSelectedRow{
        //                let destinationVC = segue.destination as! GetOneViewController
        //                destinationVC.selectCity = weatherArray[indexPath.row]
        //            }
        //        }
        
    }
    
    
}

