import Foundation

class FirebaseServices : NSObject{
    
    static let baseUrl = "https://sheerkindness.firebaseio.com/"

    static func readPost(type : String, callback : (NSDictionary) -> Void){
        
        let query = "messages.json?orderBy=%22type%22&equalTo=%22\(type)%22&limitToFirst=1"
        let relative = NSURL(string : baseUrl)
        let urlQuery = NSURL(string : query, relativeToURL: relative)
        let request = NSMutableURLRequest(URL: urlQuery!)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler :
            {
                data, response, error in
                if error != nil {
                    print(error)
                } else {
                    do{
                        let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves) as? NSDictionary
                        dispatch_async(dispatch_get_main_queue(), {
                            callback(json!)
                        })
                    } catch _{}
                }
        })
        task.resume()
    }
    
    static func readThanks(id : String, callback : (NSDictionary) -> Void){
        
        let query = "thanks.json?orderBy=%22fromId%22&equalTo=%22\(id)%22"
        let relative = NSURL(string : baseUrl)
        let urlQuery = NSURL(string : query, relativeToURL: relative)
        let request = NSMutableURLRequest(URL: urlQuery!)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler :
            {
                data, response, error in
                if error != nil {
                    print(error)
                } else {
                    do{
                        let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves) as? NSDictionary
                        dispatch_async(dispatch_get_main_queue(), {
                            callback(json!)
                        })
                    } catch _{}
                }
        })
        task.resume()
    }
    
    
    static func writePost(message : Msg, name : String, callback : (Bool) -> Void){
        
        let query = "messages.json"
        let relative = NSURL(string : baseUrl)
        let urlQuery = NSURL(string : query, relativeToURL: relative)
        let request = NSMutableURLRequest(URL: urlQuery!)
        let session = NSURLSession.sharedSession()
        
        request.HTTPMethod = "POST"
        let params = ["type":"\(message.type)", "content":"\(message.content)", "date":"\(message.date)", "id":"\(message.id)", "name":"\(name)", "read": "\(message.read)"] as Dictionary
        
        do {
            request.HTTPBody =  try NSJSONSerialization.dataWithJSONObject(params, options: NSJSONWritingOptions(rawValue: 0))
        } catch _{}

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            var code = 400
            if let httpResponse = response as? NSHTTPURLResponse {
                code = httpResponse.statusCode
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                callback(code == 200)
            })
        })
        task.resume()
    }
    
    static func deletePost(id : String, callback : (Bool) -> Void){
        
        let query = baseUrl + "messages/" + id + ".json"
        let urlQuery = NSURL(string : query)
        let request = NSMutableURLRequest(URL: urlQuery!)
        let session = NSURLSession.sharedSession()
        
        request.HTTPMethod = "DELETE"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            var code = 400
            if let httpResponse = response as? NSHTTPURLResponse {
                code = httpResponse.statusCode
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                callback(code == 200)
            })
        })
        task.resume()
    }
    
    static func writeThanks(thanks : Thanks, callback : (Bool) -> Void){
        
        let query = "thanks.json"
        let relative = NSURL(string : baseUrl)
        let urlQuery = NSURL(string : query, relativeToURL: relative)
        let request = NSMutableURLRequest(URL: urlQuery!)
        let session = NSURLSession.sharedSession()
        
        request.HTTPMethod = "POST"
        
        do {
            request.HTTPBody =  try NSJSONSerialization.dataWithJSONObject(thanks.paramsAsDictionnary(), options: NSJSONWritingOptions(rawValue: 0))
        } catch _{}
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            var code = 400
            if let httpResponse = response as? NSHTTPURLResponse {
                code = httpResponse.statusCode
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                callback(code == 200)
            })
        })
        task.resume()
    }
    
    static func writeThankLess(thanks : Thanks, callback : (Bool) -> Void){
        
        let query = "thankless.json"
        let relative = NSURL(string : baseUrl)
        let urlQuery = NSURL(string : query, relativeToURL: relative)
        let request = NSMutableURLRequest(URL: urlQuery!)
        let session = NSURLSession.sharedSession()
        
        request.HTTPMethod = "POST"
        
        do {
            request.HTTPBody =  try NSJSONSerialization.dataWithJSONObject(thanks.paramsAsDictionnary(), options: NSJSONWritingOptions(rawValue: 0))
        } catch _{}
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            var code = 400
            if let httpResponse = response as? NSHTTPURLResponse {
                code = httpResponse.statusCode
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                callback(code == 200)
            })
        })
        task.resume()
    }
    
    static func writeReport(thanks : Thanks, callback : (Bool) -> Void){
        
        let query = "report.json"
        let relative = NSURL(string : baseUrl)
        let urlQuery = NSURL(string : query, relativeToURL: relative)
        let request = NSMutableURLRequest(URL: urlQuery!)
        let session = NSURLSession.sharedSession()
        
        request.HTTPMethod = "POST"
        
        do {
            request.HTTPBody =  try NSJSONSerialization.dataWithJSONObject(thanks.paramsAsDictionnary(), options: NSJSONWritingOptions(rawValue: 0))
        } catch _{}
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            var code = 400
            if let httpResponse = response as? NSHTTPURLResponse {
                code = httpResponse.statusCode
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                callback(code == 200)
            })
        })
        task.resume()
    }
    
}