import Foundation

class Thanks: NSObject {
    
    var type : String = ""
    var content : String = ""
    var fromName : String = ""
    var fromId : String = ""
    var toName : String = ""
    var toId : String = ""
    var date : NSDate = NSDate()
    
    init(type : String, content : String, fromName : String, fromId : String, toName : String, toId : String) {
        super.init()
        self.type = type
        self.content = content
        self.fromName = fromName
        self.fromId = fromId
        self.toName = toName
        self.toId = toId
    }
    
    func paramsAsDictionnary() -> Dictionary<String, String>{
        return ["type":"\(type)", "content":"\(content)", "fromName":"\(fromName)", "fromId":"\(fromId)", "toName":"\(toName)", "toId": "\(toId)", "date": "\(date)"] as Dictionary
    }
    
}