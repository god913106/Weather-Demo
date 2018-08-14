//
//  ViewController.swift
//  WeatherApp
//
//  Created by Angela Yu on 23/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON


class WeatherViewController: UIViewController, CLLocationManagerDelegate{
    
    
    
    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "5dd266f17436cc658b47fb0ec89542d7"
    
    
    //TODO: Declare instance variables here
    let locationManager = CLLocationManager()
    let weatherDataModel = WeatherDataModel()
    
    //Pre-linked IBOutlets
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //TODO:Set up the location manager here.
        locationManager.delegate = self
        //locationManager.desiredAccuracy：定位精準度範圍
        //kCLLocationAccuracyHundredMeters，一次还不错的定位，偏差在百米左右
        //kCLLocationAccuracyBest，可以获取精度很高的一次定位，偏差在十米左右
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        //little pop up that asks you for your permission to give the app your current location and that's what this line of code is going to do
        //請求權限定位服務
        //locationManager.requestAlwaysAuthorization() //永遠：App在背景執行時，仍可取用您的位置。
        locationManager.requestWhenInUseAuthorization()//使用App期間：只有App或其中的功能在螢幕上顯示時，才能取用您的位置。
        //locationManager開始尋找GPS座標，有用Asynchronous Method(異步方法)，它在後台運行抓到GPS座標
        locationManager.startUpdatingLocation()
        
        
        
    }
    
    
    
    //MARK: - Networking
    /***************************************************************/
    
    //Write the getWeatherData method here:
    func getWeatherData(url:String, parameters:[String : String]){
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON{
            //第一個參數url是指去哪個網頁，第二個參數是指要用哪個方法去請求 這裡用get 來get data，第三個參數就是提供url所要的資料
            
            response in
            if response.result.isSuccess {
                print("Success! Got the weather data")
                let weatherJSON : JSON = JSON(response.result.value!)
                print(weatherJSON)
                self.updateWeatherData(json: weatherJSON)
                
            }else{
                print("Error \(response.result.error)")
                self.cityLabel.text = "Connection Issues"
            }
        }
    }
    
    
    
    
    
    
    //MARK: - JSON Parsing
    /***************************************************************/
    
    
    //Write the updateWeatherData method here:
    func updateWeatherData(json : JSON){
        // 如果tempResult有值才會繼續做下去
        if let tempResult = json["main"]["temp"].double { //tempResult 是一個包 要打開要option !!
            weatherDataModel.temperature = Int(tempResult - 273.15)//不用強制打開empResult!臨時結果了，因為我們現在進行檢查
            
            
            
            // let cityResult = json["name"].stringValue
            weatherDataModel.city = json["name"].stringValue
            
            
            
            weatherDataModel.condition = json["weather"][0]["id"].intValue
            
            weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
            
            updateUIWithWeatherData()
        }
        else{
            cityLabel.text = "Weather Unavailable"
        }
    }
    
    
    
    
    //MARK: - UI Updates
    /***************************************************************/
    
    
    //Write the updateUIWithWeatherData method here:
    
    func updateUIWithWeatherData() {
        temperatureLabel.text = "\(weatherDataModel.temperature)°"
        cityLabel.text = weatherDataModel.city
        weatherIcon.image = UIImage(named:weatherDataModel.weatherIconName)
        
    }
    
    
    
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    
    
    //Write the didUpdateLocations method here:
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //最後一個座標是最精確的
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil //只抓一次資料 不要重覆print stop
            //如果是在模擬器 記得要去debug設定location的位置在apple總部
            print("經度longitude = \(location.coordinate.longitude), 緯度latitude = \(location.coordinate.latitude)")
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            let params : [String : String] = ["lat" : latitude, "lon" : longitude, "appid" : APP_ID]
            
            getWeatherData(url: WEATHER_URL, parameters: params)
        }
    }
    
    
    //Write the didFailWithError method here:
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = "Location Unavailable"
    }
    
    
    
    
    //MARK: - Change City Delegate methods
    /***************************************************************/
    
    
    //Write the userEnteredANewCityName Delegate method here:
//    func userEnteredANewCityName(city: String) {
//        print(city) //接收端 當getWeather鈕按下去後 就送cityName過來
//
//        let params:[String : String] = ["q": city, "appid": APP_ID] //API規定q=cityName
//        getWeatherData(url: WEATHER_URL, parameters: params)
//    }


    //Write the PrepareForSegue Method here

  
    
    
    
}


