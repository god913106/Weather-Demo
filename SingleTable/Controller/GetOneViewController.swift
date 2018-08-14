//
//  GetOneViewController.swift
//  SingleTable
//
//  Created by 洋蔥胖 on 2018/5/14.
//  Copyright © 2018年 ChrisYoung. All rights reserved.
//

import UIKit


class GetOneViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    
    var selectCity :WeatherModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! GetOneTableViewCell
        
//        cell.fieldLabel?.text = "123"
//        cell.valueLabel?.text = "456"
        
        return cell
    }

}
