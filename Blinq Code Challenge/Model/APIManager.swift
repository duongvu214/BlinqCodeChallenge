//
//  backendManager.swift
//  Blinq Code Challenge
//
//  Created by Duong Vu on 13/8/21.
//

import Foundation

protocol APIManagerDelegate {
    //pass data to requested page depend on success or fail
    func didUpdateData(result: String)
    func didFailWithError(error: String)
}

struct APIManager {
    
    var delegate:  APIManagerDelegate?
    
    func getData(for name: String, email: String) {
        
        let parameters = ["name": name, "email": email]
        let url = URL(string: "https://us-central1-blinkapp-684c1.cloudfunctions.net/fakeAuth")!
        //create the session object
        let session = URLSession.shared
        
        //create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            print(error.localizedDescription)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                delegate?.didFailWithError(error: error?.localizedDescription ?? "Something wrong, try again!")
                return
            }
            
            guard let data = data else {
                delegate?.didFailWithError(error: error?.localizedDescription ?? "Something wrong, try again!")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse{
                print("httpStatus.statusCode: \(httpStatus.statusCode)")
                if httpStatus.statusCode == 200 {
                    if let responseString = String(data: data, encoding: .utf8)
                    {
                        //pass data to requested page if success
                        delegate?.didUpdateData(result: responseString)
                    }  else {
                        delegate?.didFailWithError(error: "Something wrong, try again!")
                    }
                    
                } else {
                    do {
                        //data return in json, so must decode in json
                        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as! [String: String]
                        if let responseString = jsonResponse["errorMessage"] {
                            delegate?.didFailWithError(error: responseString)
                        } else {
                            delegate?.didFailWithError(error: "Something wrong, try again!")
                        }
                    } catch _ {
                        print ("OOps not good JSON formatted response")
                        delegate?.didFailWithError(error: "Something wrong, try again!")
                    }
                }
            } else {
                delegate?.didFailWithError(error: "Something wrong, try again!")
            }
            
            
        })
        task.resume()
    }
    
}
