import UIKit
import FacebookCore
import FacebookLogin

class LoginRequestViewController: UIViewController {
    let profile = Profile()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func loginCheck(token: String) { //檢查登入狀態
        print("----loginCheck----")
        
        let serviceUrl = "http://paperlz.net/api/"
        let request = NSMutableURLRequest(url: NSURL(string : serviceUrl)! as URL)
        request.httpMethod = "POST"
        encodeToken(token: token) //處理要傳送的token，並存入Token.token
        let postParameters = "api=0104"+"&data={"+Token.token+"}"
        print("test==")
        print(postParameters)
        
        request.httpBody = postParameters.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error != nil{
                print("error is \(error)")
                return
            }
            
            let responseString = NSString(data:data!, encoding: String.Encoding.utf8.rawValue)
            let statusCode = StatusCode()
            let status = statusCode.parsingStatus(code: responseString as! String)
            if( status == "000") {
                self.profile.getUserData()
            } else if ( status == "110") {
                self.createUser()
            } else {
                return
            }
            
        }.resume()
    }
    
    func createUser() {
        print("create User")
        let serviceUrl = "http://paperlz.net/api/"
        let request = NSMutableURLRequest(url: NSURL(string : serviceUrl)! as URL)
        request.httpMethod = "POST"
        let postParameters = "api=0100"+"&data={"+Token.token+"}"
        
        request.httpBody = postParameters.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error != nil {
                print("error is \(error)")
                return
            }
            
            let responseString = NSString(data:data!, encoding: String.Encoding.utf8.rawValue)
            let statusCode = StatusCode()
            let status = statusCode.parsingStatus(code: responseString as! String)
            if( status == "000") {
                self.profile.getUserData()
            } else {
                return
            }
        }.resume()
    }
    
    func encodeToken(token: String) {
        let tokenOriginalString = "\"token\":\"\(token)\"" //"token":"xxxxxxx"
        //print(tokenOriginalString)
        let tokenEscapedString = tokenOriginalString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        Token.token = tokenEscapedString!
    }
}

