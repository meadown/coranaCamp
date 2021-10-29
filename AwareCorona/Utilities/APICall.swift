//
//  APICall.swift
//  AwareCorona
//
//  Created by Meadown on 1/5/20.
//  Copyright © 2020 Meadown. All rights reserved.
//

import Foundation
class APICall {
    
    
    static func getData(surl: String) -> NSURLRequest
    {
        let headers = [
            "x-rapidapi-host": "covid-193.p.rapidapi.com",
            "x-rapidapi-key": "e89c7a39ccmshe617a87d1694a60p1a13ccjsn360632443f34"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: surl)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        return request
    }
    
}
