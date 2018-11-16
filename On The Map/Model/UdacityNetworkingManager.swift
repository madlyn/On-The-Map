//
//  UdacityNetworkingManager.swift
//  On The Map
//
//  Created by Lyn Almasri on 11/15/18.
//  Copyright © 2018 lynmasri. All rights reserved.
//

import Foundation

class UdacityNetworkingManager{
    func login(email : String, password : String, completionHandler: @escaping ( _ sessionID: String?, _ error: String?) -> Void){
        let manager = NetworkManager()
        let udacityDict = [Constants.ParameterKeys.UserName : email,
                           Constants.ParameterKeys.Password : password] as [String:AnyObject]
        let parameters = [
            Constants.ParameterKeys.Udacity : udacityDict] as [String:AnyObject]
        
        manager.postMethod(url: URLFromParameters( withPathExtension: Constants.APIMethods.Session), parameters: parameters) { (object, error) in
            guard error == nil else{
                completionHandler(nil, error)
                return
            }
            guard let object = object else {
                print("Could Not LOGIN")
                completionHandler(nil, "Could Not LOGIN")
                return
            }
            guard let account = object[Constants.JSONResponseKeys.Account] as? [String:AnyObject] else{
                print("Could Not Retrieve Account Information")
                completionHandler(nil, "Could Not Retrieve Account Information")
                return
            }
            guard let registered = account[Constants.JSONResponseKeys.Registered] as? Bool else{
                print("Could Not Retrieve Account Information")
                completionHandler(nil, "Could Not Retrieve Account Information")
                return
            }
            if !registered{
                print("Account Not Registered")
                completionHandler(nil, "Account Not Registered")
                return
            }
            guard let session = object[Constants.JSONResponseKeys.Session] as? [String:AnyObject] else{
                print("Could Not Retrieve Session Information")
                completionHandler(nil, "Could Not Retrieve Session Information")
                return
            }
            guard let id = session[Constants.JSONResponseKeys.SessionID] as? String else{
                print("Could Not Retrieve Session ID")
                completionHandler(nil, "Could Not Retrieve Session ID")
                return
            }
            AppValues.sessionID = id
            completionHandler(id , nil)
        }
    }
    func URLFromParameters(withPathExtension: String? = nil) -> URL {
        var components = URLComponents()
        components.scheme = Constants.ApiScheme
        components.host = Constants.UdacityApiHost
        components.path = Constants.UdacityApiPath + (withPathExtension ?? "")
        
        return components.url!
    }
}
