//
//  WeatherModel.swift
//  SingleTable
//
//  Created by 洋蔥胖 on 2018/5/11.
//  Copyright © 2018年 ChrisYoung. All rights reserved.
//

import Foundation

class WeatherModel{
    var city :String = ""
    var temp :Int = 0
    var description :String = ""
    
    init(){
        
    }
    
    init(city:String, temp: Int) {
        self.city = city
        self.temp = temp
    }
}
