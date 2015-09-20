//
//  CapitalOneNetwork.swift
//  SpareChange
//
//  Created by Timothy Horng on 9/20/15.
//  Copyright © 2015 Timothy Horng. All rights reserved.
//

import Foundation
import UIKit

class CapitalOneNetwork {

    // MARK: API REQUESTS
    
    class func callAPI(){
        let urlString = "http://api.reimaginebanking.com/enterprise/customers?key=a8a1261b4e485d7b3bd743ecfc118843"
        get(urlString, completionHandler: { (json) -> Void in
            print(json)
            }) { () -> Void in
            print("Err")
        }
    }

    class func get(urlString:String, completionHandler: ((NSDictionary?) -> Void)?, errorHandler:(() -> Void)?) {
        if let url = NSURL(string: urlString) {
            let request = NSMutableURLRequest(URL: url)
            let session = NSURLSession.sharedSession()
            request.HTTPMethod = "GET"
            let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSDictionary
                    completionHandler?(json)
                } catch {
                    errorHandler?()
                }
            })
            task.resume()
        }
    }
    

}
