//
//  CapitalOnePostRequest.swift
//  SpareChange
//
//  Created by Timothy Horng on 9/20/15.
//  Copyright © 2015 Timothy Horng. All rights reserved.
//

import Foundation
import UIKit

class CapitalOnePostRequest {
    // MARK: POST REQUEST
    
    func application(application: UIApplication!, didFinishLaunchingWithOptions launchOptions: NSDictionary!) -> Bool {
        
        // Correct url and username/password
//        self.post(["_id": "string",
//            "type": "merchant",
//            "merchant_id": "string",
//            "payer_id": "string",
//            "purchase_date": "string",
//            "amount": 0,
//            "status": "pending",
//            "medium": "balance",
//            "description": "string"], url: "http://api.reimaginebanking.com/accounts/55e94a6cf8d8770528e61926/purchases?key=a8a1261b4e485d7b3bd743ecfc118843")
        
        // Correct url, incorrect password
        self.post(["username":"jameson", "password":"wrong_password"], url: "http://localhost:4567/login")
        
        // Incorrect url
        self.post(["username":"jameson", "password":"password"], url: "http://badurl.com/nonexistent")
        
        return true
    }
    
    func post(params : Dictionary<String, String>, url : String) {
        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        
        var err: NSError?
        do {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: NSJSONWritingOptions())
            
        } catch {
            print("Caught dataWithJSONObject error")
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            print("Response: \(response)")
            var strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
            var json: NSDictionary?
            print("Body: \(strData)")
            var err: NSError?
            do {
                json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSDictionary
            } catch {
                print("thx jsonobjectwithdata")
            }
            
            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
            if(err != nil) {
                print(err!.localizedDescription)
                let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("Error could not parse JSON: '\(jsonStr)'")
            }
            else {
                // The JSONObjectWithData constructor didn't return an error. But, we should still
                // check and make sure that json has a value using optional binding.
                if let parseJSON = json {
                    // Okay, the parsedJSON is here, let's get the value for 'success' out of it
                    var success = parseJSON["success"] as? Int
                    print("Succes: \(success)")
                }
                else {
                    // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
                    let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    print("Error could not parse JSON: \(jsonStr)")
                }
            }
        })
        
        task.resume()
    }

}