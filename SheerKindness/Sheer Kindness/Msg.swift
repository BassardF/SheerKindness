import Foundation

class Msg: NSObject {
    
    var type : String = ""
    var content : String = ""
    var id : String = ""
    var date : NSDate = NSDate()
    var read : Bool = false
    
    init(t : String, c : String, id : String) {
        super.init()
        self.type = t
        self.content = c
        self.id = id
    }
    
}