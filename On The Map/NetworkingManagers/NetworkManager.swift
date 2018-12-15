//
//  NetworkManager.swift
//  On The Map
//
//  Created by Lyn Almasri on 11/15/18.
//  Copyright © 2018 lynmasri. All rights reserved.
//

import Foundation

class NetworkManager{
    let session = URLSession.shared
    func udacityPostMethod(url : URL, parameters: [String:AnyObject], completionHandler: @escaping (_ result: [String:AnyObject]?, _ error: String?) -> Void){
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue(Constants.ParamterValues.ApplicationJSON, forHTTPHeaderField: Constants.ParameterKeys.Accept)
        request.addValue(Constants.ParamterValues.ApplicationJSON, forHTTPHeaderField: Constants.ParameterKeys.ContentType)
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        }catch{
            print("Could Not Serialize Data")
            completionHandler(nil, "Could Not Serialize Data")
            return
        }
        let task = session.dataTask(with: request) { (data, response, error) in
//            print(response)
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                completionHandler(nil, error?.localizedDescription)
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                print("Request returned a status code other than 2xx!")
                completionHandler(nil, "Request returned a status code other than 2xx!")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                print("No Data Retrieved")
                completionHandler(nil, "No Data Retrieved")
                return
            }
            let range = Range(5..<data.count)
            let newData = data.subdata(in: range) /* subset response data! */
            do{
                let object = try JSONSerialization.jsonObject(with: newData, options: .allowFragments) as! [String : AnyObject]
                completionHandler(object,nil)
                
            } catch{
                print("Could not parse data")
                completionHandler(nil, "Could not parse data")
                return
            }
        }
        task.resume()
    }
    
    func getMethod(url : URL, completionHandler: @escaping (_ result: [String:AnyObject]?, _ error: String?) -> Void){
        var request = URLRequest(url: url)
        request.setValue(Constants.ParseApplicationId, forHTTPHeaderField: Constants.HTTPHeaderFieldParameterKeys.ApplicationID)
        request.setValue(Constants.RESTAPIKey, forHTTPHeaderField: Constants.HTTPHeaderFieldParameterKeys.RESTAPIKey)
        let task = session.dataTask(with: request) { (data, response, error) in
//            print(response)
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                completionHandler(nil, error?.localizedDescription)
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                print("Request returned a status code other than 2xx!")
                completionHandler(nil, "Request returned a status code other than 2xx!")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                print("No Data Retrieved")
                completionHandler(nil, "No Data Retrieved")
                return
            }
            do{
                let object = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String : AnyObject]
                completionHandler(object,nil)
                
            } catch{
                print("Could not parse data")
                completionHandler(nil, "Could not parse data")
                return
            }
            
        }
        task.resume()
    }
    
    func udacityGetMethod(url : URL, completionHandler: @escaping (_ result: [String:AnyObject]?, _ error: String?) -> Void){
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = session.dataTask(with: request) { (data, response, error) in
//            print(response)
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                completionHandler(nil, error?.localizedDescription)
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                print("Request returned a status code other than 2xx!")
                completionHandler(nil, "Request returned a status code other than 2xx!")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                print("No Data Retrieved")
                completionHandler(nil, "No Data Retrieved")
                return
            }
            let range = Range(5..<data.count)
            let newData = data.subdata(in: range)
            print(String(data: newData, encoding: .utf8)!)
            do{
                let object = try JSONSerialization.jsonObject(with: newData, options: .allowFragments) as! [String : AnyObject]
                completionHandler(object,nil)
                
            } catch{
                print("Could not parse data")
                completionHandler(nil, "Could not parse data")
                return
            }
            
        }
        task.resume()
    }
    
    func postMethod(url : URL, parameters: [String:AnyObject], completionHandler: @escaping (_ result: [String:AnyObject]?, _ error: String?) -> Void){
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue(Constants.ParamterValues.ApplicationJSON, forHTTPHeaderField: Constants.ParameterKeys.Accept)
        request.addValue(Constants.ParamterValues.ApplicationJSON, forHTTPHeaderField: Constants.ParameterKeys.ContentType)
        request.setValue(Constants.ParseApplicationId, forHTTPHeaderField: Constants.HTTPHeaderFieldParameterKeys.ApplicationID)
        request.setValue(Constants.RESTAPIKey, forHTTPHeaderField: Constants.HTTPHeaderFieldParameterKeys.RESTAPIKey)
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        }catch{
            print("Could Not Serialize Data")
            completionHandler(nil, "Could Not Serialize Data")
            return
        }
        let task = session.dataTask(with: request) { (data, response, error) in
                        print(response)
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                completionHandler(nil, error?.localizedDescription)
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                print("Request returned a status code other than 2xx!")
                completionHandler(nil, "Request returned a status code other than 2xx!")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                print("No Data Retrieved")
                completionHandler(nil, "No Data Retrieved")
                return
            }
            do{
                let object = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String : AnyObject]
                completionHandler(object,nil)
                
            } catch{
                print("Could not parse data")
                completionHandler(nil, "Could not parse data")
                return
            }
        }
        task.resume()
    }
    
   
}
