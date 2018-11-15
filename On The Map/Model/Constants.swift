//
//  Constants.swift
//  On The Map
//
//  Created by Lyn Almasri on 11/15/18.
//  Copyright © 2018 lynmasri. All rights reserved.
//

import Foundation

struct Constants{
    static let ApiScheme = "https"
    // MARK: Parse
    static let ParseApiHost = "parse.udacity.com"
    static let ParseApiPath = "/parse/classes"
    static let ParseApplicationId = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
    static let RESTAPIKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
    // MARK: Udacity
    static let UdacityApiHost = "www.udacity.com"
    static let UdacityApiPath = "/api"
//    static let AuthorizationURL = "https://www.themoviedb.org/authenticate/"
//    static let AccountURL = "https://www.themoviedb.org/account/"
}

struct APIMethods {
    // MARK: Parse
    static let StudentLocation = "/StudentLocation"  //GET & POST & PUT Student/s Location/s
    // MARK: Udacity
    static let Session = "/session" //POST get session id DELETE to logout
    static let User = "/users" //GET public user data (user_id)
}

 struct JSONResponseKeys {
    // MARK: Parse
    static let ObjectId = "objectId"
    static let UniqueKey = "uniqueKey"
    static let FirstName = "firstName"
    static let LastName = "lastName"
    static let MapString = "mapString"
    static let MediaURL = "mediaURL"
    static let Latitude = "latitude"
    static let Longitude = "longitude"
}

struct ParameterKeys{
    // MARK: Parse
    static let Limit = "limit"
    static let Skip = "skip"
    static let Order = "order"
    static let Where = "where"
    // MARK: Udacity
    static let Udacity = "udacity"
    static let UserName = "username"
    static let Password = "password"
    static let TokenCookie = "XSRF-TOKEN"
}

struct HTTPHeaderFieldParameterKeys{
    // MARK: Parse
    static let ApplicationID = "X-Parse-Application-Id"
    static let RESTAPIKey = "X-Parse-REST-API-Key"
    // MARK: Udacity
    static let Cookie = "X-XSRF-TOKEN"
}
