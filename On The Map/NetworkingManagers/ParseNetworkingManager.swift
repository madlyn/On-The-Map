//
//  ParseNetworkingManager.swift
//  On The Map
//
//  Created by Lyn Almasri on 11/16/18.
//  Copyright © 2018 lynmasri. All rights reserved.
//

import Foundation

class ParseNetworkingManager {
    func getLocations(completionHandler: @escaping ( _ studentLocation: [StudentLocation]?, _ error: String?) -> Void){
        let manager = NetworkManager()
        let parameters = [
            Constants.ParameterKeys.Limit : 100
        ] as [String:AnyObject]
        manager.getMethod(url: URLFromParameters(parameters, withPathExtension: Constants.APIMethods.StudentLocation)) { (object, error) in
            guard error == nil else{
                completionHandler(nil, error)
                return
            }
            guard let object = object else {
                print("No Object Retrieved")
                completionHandler(nil, "No Object Retrieved")
                return
            }
            guard let results = object[Constants.JSONResponseKeys.Results] as? [[String:AnyObject]] else {
                print("Could Not Retrieve Results")
                completionHandler(nil,"Could Not Retrieve Results")
                return
            }
            var studentLocations = [StudentLocation]()
            for result in results{
                var location = StudentLocation()
                if let firstName = result[Constants.JSONResponseKeys.FirstName] as? String{
                    location.firstName = firstName
                } else{
                    print("Could Not Retrieve FirstName")
                    location.firstName = ""
                }
                if let lastName = result[Constants.JSONResponseKeys.LastName] as? String{
                    location.lastName = lastName
                } else{
                    print("Could Not Retrieve LastName")
                    location.lastName = ""
                }
                if let objectId = result[Constants.JSONResponseKeys.ObjectId] as? String{
                    location.objectId = objectId
                } else{
                    print("Could Not Retrieve ObjectId")
                    location.objectId = ""
                }
                if let uniqueKey = result[Constants.JSONResponseKeys.UniqueKey] as? String{
                    location.uniqueKey = uniqueKey
                } else{
                    print("Could Not Retrieve UniqueKey")
                    location.uniqueKey = ""
                }
                if let mapString = result[Constants.JSONResponseKeys.MapString] as? String{
                    location.mapString = mapString
                } else{
                    print("Could Not Retrieve MapString")
                    location.mapString = ""
                }
                if let mediaUrl = result[Constants.JSONResponseKeys.MediaURL] as? String{
                    location.mediaURL = mediaUrl
                } else{
                    print("Could Not Retrieve MediaURL")
                    location.mediaURL = ""
                }
                if let latitude = result[Constants.JSONResponseKeys.Latitude] as? Double{
                    location.latitude = latitude
                } else{
                    print("Could Not Retrieve Latitude")
                    location.latitude = 0
                }
                if let longitude = result[Constants.JSONResponseKeys.Longitude] as? Double{
                    location.longitude = longitude
                } else{
                    print("Could Not Retrieve Longitude")
                    location.longitude = 0
                }
                studentLocations.append(location)
            }
            completionHandler(studentLocations,nil)
        }
    }
    func URLFromParameters(_ parameters: [String:AnyObject], withPathExtension: String? = nil) -> URL {
        var components = URLComponents()
        components.scheme = Constants.ApiScheme
        components.host = Constants.ParseApiHost
        components.path = Constants.ParseApiPath + (withPathExtension ?? "")
        components.queryItems = [URLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
        }
        return components.url!
    }
}
