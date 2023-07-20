//
//  Trip.swift
//  FBLoginTest
//
//  Created by Lucy on 2018/6/7.
//  Copyright © 2018年 iDEA. All rights reserved.
//

import Foundation
import UIKit
class Trip {
    var name = "TestKirk"
    var place = "TestPlaceKirk"
    var context = "Hi, let's Kirk"
    var startDate = "20180611140000"//YMDhms
    var endDate = "20180612140000"
    var attendable = false
    var isDraft = false
    var plimit = 5
    var tag = ""//array
    var photo = ""
    var explore_delegate: Trips_Explore_ReturnDelegate?
    var adventure_delegate: Trips_Adventure_ReturnDelegate?
    
        func createTrip() {
            print("===createTrip===")
            let serviceUrl = "http://paperlz.net/api/"
            let request = NSMutableURLRequest(url: NSURL(string : serviceUrl)! as URL)
            request.httpMethod = "POST"
            
            //add request
            var postData = "{\"token\":\"\(Token.originToken)\",\"dataset\":{\"name\":\"\(name)\",\"place\":\"\(place)\",\"context\":\"\(context)\",\"startDate\":\"\(startDate)\",\"endDate\":\"\(endDate)\",\"attendable\":\(attendable),\"isDraft\":\(isDraft),\"plimit\":\(plimit)}}"
            postData = postData.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            let postParameters = "api=0200&data=\(postData)"
            print(postParameters)
            
            request.httpBody = postParameters.data(using: String.Encoding.utf8)
            
            _ = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                if error != nil{
                    print("error in createTrip : \(String(describing: error))")
                    return
                }
                
                //return request status
                let responseString = NSString(data:data!, encoding: String.Encoding.utf8.rawValue)
                print(responseString)
                
            }.resume()
        }//end func createTrip
    
    func getUserTrip() { //get user's own trip => Adventure
        print("===getUserTrip===")
        let serviceUrl = "http://paperlz.net/api/"
        let request = NSMutableURLRequest(url: NSURL(string : serviceUrl)! as URL)
        request.httpMethod = "POST"
        
        //add request
        var postData = "{\"token\":\"\(Token.originToken)\"}"
        postData = postData.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let postParameters = "api=0201"+"&data=\(postData)"
        request.httpBody = postParameters.data(using: String.Encoding.utf8)
        
        //send request
        
        _ = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error != nil{
                print("error in getUserTrip : \(String(describing: error))")
                return
            }
            //parse json data
            let decoder = JSONDecoder()
            guard let jsondata = data else{
                print("Error: did not receive data")
                return
            }
            do {
                let tripData = try decoder.decode(Trips_Adventure_Return.self, from: jsondata)
                print("Adventure tripData.status: \(tripData.status)")
                
                DispatchQueue.main.sync {
                    
                    self.adventure_delegate?.didFinishDownloading(_sender: tripData)
                }
//                if (tripData.status == "000") {
//                    globalAdventureTripData = tripData.trip
//
//
//                } else {
//                    print("status: \(tripData.status)")
//                }
            } catch {
                print("Error in getUserTrip:  \(error.localizedDescription)")
                //return
            }
            let responseString = NSString(data:data!, encoding: String.Encoding.utf8.rawValue)
            print("getUserTrip responseString: \(responseString)")
           
        }.resume()
            
        
    }
    
    func getExploreTrip() { //post:option:{}
        print("===getExploreData===")
        let serviceUrl = "http://paperlz.net/api/"
        let request = NSMutableURLRequest(url: NSURL(string : serviceUrl)! as URL)
        request.httpMethod = "POST"
        
        //add request
        var postData = "{\"token\":\"\(Token.originToken)\",\"scope\":[10,1],\"option\":{}}"
        postData = postData.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let postParameters = "api=0201&data=\(postData)"
        request.httpBody = postParameters.data(using: String.Encoding.utf8)
        
        //send request
        
        _ = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
                if error != nil {
                    print("error in getExploreTrip : \(String(describing: error))")
                    return
                }
                //parse json data
                let decoder = JSONDecoder()
                guard let jsondata = data else {
                    print("Error: did not receive data")
                    return
                }
                do {
                    let tripData = try decoder.decode(Trips_Explore_Return.self, from: jsondata)
                    DispatchQueue.main.sync {
                        self.explore_delegate?.didFinishDownloading(_sender: tripData)
                    }
                } catch {
                    print("Error in getExploreData:  \(error.localizedDescription)")
                    return
                }
        }.resume()
        
    } //end func getExploreTrip

}

//    func retriveTrip() {
//
//    }
    

