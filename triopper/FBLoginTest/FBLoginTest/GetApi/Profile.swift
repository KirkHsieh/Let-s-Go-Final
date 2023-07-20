//
//  Profile.swift
//  FBLoginTest
//
//  Created by Lucy on 2018/4/24.
//  Copyright © 2018年 iDEA. All rights reserved.
//

import UIKit

class Profile {
    
    func getUserData() {
        print("----getUserData----")
        //connect to api
        let serviceUrl = "http://paperlz.net/api/"
        let request = NSMutableURLRequest(url: NSURL(string : serviceUrl)! as URL)
        request.httpMethod = "POST"
        
        //add request
        let postParameters = "api=0101"+"&data={"+Token.token+"}"
        request.httpBody = postParameters.data(using: String.Encoding.utf8)
        
        //send request
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error != nil{
                print("error in getUserData : \(error)")
                return
            }
            //parse json data
            let decoder = JSONDecoder()
            guard let jsondata = data else{
                print("Error: did not receive data")
                return
            }
            do {
                let userData = try decoder.decode(Users_return.self, from: jsondata)
                
                if (userData.status == "000") {
                    globalUserData = userData.user?[0] //抓取使用者資料成功後，將資料塞入全域globalUserData
                    
                } else {
                    print("status: \(userData.status)")
                }
            } catch {
                print("Error:  \(error.localizedDescription)")
                //return
            }
        }.resume()
        
    }//end func getUserData
    
    func updateUserData(name: String, location: String, email: String, introduction: String) {
        print("----updateUserData----")
        //{"dataset":{"name":"冠玗"},"token":"xxxxxx"}
        /*
            todo:hobby, personality, privacy
            "personality":\"\(globalUserData?.personality)\",
            "hobby":\"\(globalUserData?.hobby)\",
            * 將Users_return包裝 (ok)
            * 傳給後端 (ok)
        */
        let serviceUrl = "http://paperlz.net/api/"
        let request = NSMutableURLRequest(url: NSURL(string : serviceUrl)! as URL)
        request.httpMethod = "POST"
        
        //add request
        let postParameters = "api=0102"+"&data={"+Token.token+",\"dataset\":{\"name\":\"\(name)\",\"email\":\"\(email)\",\"location\":\"\(location)\",\"introduction\":\"\(introduction)\"}}"//todo: encode
        
        print("test==")
        print(postParameters)
        
        request.httpBody = postParameters.data(using: String.Encoding.utf8)
            
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error != nil{
                print("error in updateUserData : \(error)")
                return
            }
                
            //return request status
            let responseString = NSString(data:data!, encoding: String.Encoding.utf8.rawValue)
            let statusCode = StatusCode()
            _ = statusCode.parsingStatus(code: responseString as! String)
            
            
        }.resume()
    }//end func updateUserData
}//end class Profile
