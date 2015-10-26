//
//  ViewController.swift
//  WhatsTheWeather
//
//  Created by Sachin Virdy on 10/25/15.
//  Copyright (c) 2015 Sachin Virdy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet var userCity: UITextField!
    
    @IBAction func findWeather(sender: AnyObject) {
    }

    @IBOutlet var resultLabel: UILabel!
    
    func showError() {
        resultLabel.text = "Was not able to find weather for " + userCity.text + ". Please try again."
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var url = NSURL(string: "http://www.weather-forecast.com/locations/London/forecasts/latest")
        if url != nil {
            
            let task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: {(data, response, error) -> Void in
                
                var urlError = false
                var weather = ""
                
                if error == nil {
                    var urlContent = NSString(data: data, encoding: NSUTF8StringEncoding) as NSString!
                    var urlContentArray = urlContent.componentsSeparatedByString("<span class=\"phrase\">")
                    
                    if urlContentArray.count > 0 {
                        var weatherArray = urlContentArray[1].componentsSeparatedByString("</span>")
                        weather = weatherArray[0] as! String
                        
                    } else {
                        urlError = true
                    }
                    
                } else {
                    urlError = true
                }
                
                dispatch_async(dispatch_get_main_queue()) {
                
                    if urlError == true {
                        self.showError()
                    } else {
                        self.resultLabel.text = weather
                    }
                }
            })
            
            task.resume()
            
        } else {
            showError()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

