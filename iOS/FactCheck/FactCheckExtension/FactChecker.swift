//
//  FactChecker.swift
//  FactCheck
//
//  Created by Daniel Devesa Derksen-Staats on 29/03/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

import Foundation
import Firebase
import CryptoSwift

struct FactChecker {
    
    var ref: FIRDatabaseReference!
    
    init() {
        if FIRApp.defaultApp() == nil {
            FIRApp.configure()
        }
        
        ref = FIRDatabase.database().reference()
    }

    func factCheck(forUrl url: URL) -> () {
        //let url = "http://www.bbc.co.uk/news/uk-politics-39422353"
        print("Getting fact checks from url: \(url.absoluteString)")
        let urlString = url.absoluteString
        let dataEncodedUrl = urlString.data(using: .utf8)
        if let urlBase64 = dataEncodedUrl?.base64EncodedString() {
            ref.child("pages").child(urlBase64).observe(FIRDataEventType.value, with: { snapshot in
                print("Snapshot: \(snapshot)")
            })
        }
        
        let md5 = "Giving official notice under Article 50 of the Lisbon Treaty, it will be delivered to European Council president Donald Tusk later.".md5()
        print("MD5: \(md5)")
    }
}
