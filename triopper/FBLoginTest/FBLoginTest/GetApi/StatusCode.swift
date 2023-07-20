/*
 Status Code:
 000    成功
 001    no data
 102    isDraft
 110    使用者不存在
 111    TOKEN過期 或是 不正確
 112    拒絕存取(已成功登入，但權限不足)
 120    呼叫不存在的API
 130    資料庫連線失敗
 131    操作資料庫時發生錯誤
 140    不正確的 Input Data
 150    發生未知的錯誤
 */
import UIKit
class StatusCode: NSObject {
    
    func parsingStatus(code: String) -> String {
        let status: String
        switch code {
        case "{\"status\":\"000\"}":
            print("Success.")
            return "000"
        case "{\"status\":\"110\"}":
            print("User not exist.")
            return "110"
        case "{\"status\":\"111\"}":
            print("Token expired or incorrent.")
            return "111"
        case "{\"status\":\"112\"}":
            print("Can not access.")
            return "112"
        case "{\"status\":\"120\"}":
            print("Call an undefined api.")
            return "120"
        case "{\"status\":\"130\"}":
            print("Failed connect to database.")
            return "130"
        case "{\"status\":\"131\"}":
            print("Failed access to database.")
            return "131"
        case "{\"status\":\"140\"}":
            print("Incorrect input.")
            return "140"
        default:
            print("Unknow error.")
            return "150"
        }
    }
}

