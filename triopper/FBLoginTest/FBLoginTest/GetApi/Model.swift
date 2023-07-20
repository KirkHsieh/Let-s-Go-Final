struct Users_return: Codable { //解析user結構
    init(status: String, user:[User]) {
        self.status = status
        self.user = user
    }
    
    var status: String
    var user: [User]?
    
    struct User: Codable {
        init(user_id: String ,name: String ,location: String, email: String, personality: String, hobby: String, introduction: String, privacy: Int, level: Int, picture: String, date: String) {
            self.user_id = user_id
            self.name = name //can be edited
            self.location = location //can be edited
            self.email = email //can be edited
            self.personality = personality //can be edited
            self.hobby = hobby //can be edited
            self.introduction = introduction //can be edited
            self.privacy = privacy //can be edited
            self.level = level
            self.picture = picture
            self.date = date
            }
        var user_id : String?
        var name : String?
        var location : String?
        var email : String?
        var personality : String?
        var hobby : String?
        var introduction : String?
        var privacy : Int?
        var level : Int?
        var picture : String?
        var date : String?
    }
}


var globalUserData: Users_return.User? //解析完的資料會塞在這裡

struct Trips_Adventure_Return: Codable {
    init( status:String, trip:[Trip]) {
        self.status = status
        self.trip = trip

    }
    var trip: [Trip]?
    var status: String
    
    struct Trip: Codable {
        init(trip_id: Int, name: String, photo: String, place: String, tag: [String], context: String, startDate: String, endDate: String, attendable: Bool, rank: Int, isDraft: Bool, plimit: Int) {
            self.trip_id = trip_id
            self.name = name
            self.photo = photo
            self.place = place
            self.tag = tag
            self.context = context
            self.startDate = startDate
            self.endDate = endDate
            self.attendable = attendable
            self.rank = rank
            self.isDraft = isDraft
            self.plimit = plimit
        }
        var trip_id: Int?
        var name: String?
        var photo: String?
        var place: String?
        var tag: [String]? //return [String]
        var context: String?
        var startDate: String?
        var endDate: String?
        var attendable: Bool?
        var rank: Int?
        var isDraft: Bool?
        var plimit: Int?
    }
}
var globalAdventureTripData: [Trips_Adventure_Return.Trip]?

struct Trips_Explore_Return: Codable {
//    init(status: String, trip:[Trip]) {
//        self.status = status
//        self.trip = trip
//
//    }
    var trip: [Trip]?
    var status: String
    
    struct Trip: Codable {
        init(trip_id: Int, name: String, photo: String, place: String, tag: [String], context: String, startDate: String, endDate: String, attendable: Bool, rank: Int, isDraft: Bool, plimit: Int) {
            self.trip_id = trip_id
            self.name = name
            self.photo = photo
            self.place = place
            self.tag = tag
            self.context = context
            self.startDate = startDate
            self.endDate = endDate
            self.attendable = attendable
            self.rank = rank
            self.isDraft = isDraft
            self.plimit = plimit
        }
        var trip_id: Int?
        var name: String?
        var photo: String?
        var place: String?
        var tag: [String]? //return [String]
        var context: String?
        var startDate: String?
        var endDate: String?
        var attendable: Bool?
        var rank: Int?
        var isDraft: Bool?
        var plimit: Int?
    }
}
var globalExploreTripData: [Trips_Explore_Return.Trip]?

protocol Trips_Explore_ReturnDelegate {
    
    func didFinishDownloading(_sender: Trips_Explore_Return)
}

protocol Trips_Adventure_ReturnDelegate {
    
    func didFinishDownloading(_sender: Trips_Adventure_Return)
}

struct Token {
    static var token: String = ""
    static var originToken: String = ""
}



