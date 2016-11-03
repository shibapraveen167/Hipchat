//  Copyright (c) 2016 Shiba Praveen. All rights reserved.

import Foundation

typealias Completion = (String) -> Void

class HTMLService {
    
    private enum Constants {
        static let timeout: NSTimeInterval = 20
    }
    
    func requestHTMLString(forURL URL: NSURL, completion: Completion) {
        var requestURL = URL
        // Append http for URLs without any scheme
        if (requestURL.scheme.length == 0) {
            requestURL = NSURL(string: "http://\(requestURL.absoluteString)") ?? URL
        }
        
        let request = NSMutableURLRequest(URL: requestURL)
        request.HTTPMethod = "GET"
        
        let urlconfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        urlconfig.timeoutIntervalForRequest = Constants.timeout
        urlconfig.timeoutIntervalForResource = Constants.timeout
        let session = NSURLSession(configuration: urlconfig, delegate: nil, delegateQueue: nil)
        
        let task = session.dataTaskWithRequest(request) { (data, response, _) in
            // Check the encoding to parse response data to string since different sites support different encoding formats
            var encoding: NSStringEncoding = NSISOLatin1StringEncoding
            if let encodingName = response?.textEncodingName {
                encoding = CFStringConvertEncodingToNSStringEncoding(
                    CFStringConvertIANACharSetNameToEncoding(encodingName)
                )
            }
            if let data = data,
                let htmlString = String(data: data, encoding: encoding) {
            completion(htmlString)
            } else {
                completion( "")
            }
        }
        task.resume()
    }
}
