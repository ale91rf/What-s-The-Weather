//
//  ViewController.swift
//  Whats The Weather
//
//  Created by Ale Ramírez Fernández on 12/11/15.
//  Copyright © 2015 AleFernandez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var lblResult: UILabel!

    @IBOutlet weak var txtCity: UITextField!
    
    @IBAction func findWeather(sender: AnyObject) {
        
        var mWasSuccessful = false
        
        let mAttemptedUrl = NSURL(string: "http://www.weather-forecast.com/locations/" + txtCity.text!.stringByReplacingOccurrencesOfString(" ", withString: "-")  + "/forecasts/latest")
        
        
        if let mUrl = mAttemptedUrl {
            let mTask = NSURLSession.sharedSession().dataTaskWithURL(mUrl) { (data, response, error) -> Void in
                
                if let mUrlContent = data {
                    
                    let mWebContent = NSString(data: mUrlContent, encoding: NSUTF8StringEncoding)
                    
                    let mWebArray = mWebContent!.componentsSeparatedByString("3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                    
                    
                    if mWebArray.count > 1 {
                        
                        let mWeatherArray = mWebArray[1].componentsSeparatedByString("</span>")
                        
                        if mWeatherArray.count > 1 {
                            
                            mWasSuccessful = true
                            
                            let mWeatherSummary = mWeatherArray[0].stringByReplacingOccurrencesOfString("&deg", withString: "º")
                            
                            print(mWeatherSummary)
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                self.lblResult.text = mWeatherSummary
                            })
                        }
                    }
                    
                }
                
                if mWasSuccessful == false  {
                    
                    self.lblResult.text = "Couldn't find the weather for that City, please try again!"
                }
            }
            mTask.resume()
        } else {
            self.lblResult.text = "Couldn't find the weather for that City, please try again!"
        }
        
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

