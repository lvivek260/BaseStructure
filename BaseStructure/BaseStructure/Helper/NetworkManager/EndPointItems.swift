//
//  EndPointItems.swift
//  Single_Response_Principle
//
//  Created by PHN MAC 1 on 05/10/23.
//

import Foundation

enum HttpMethod: String{
    case get    = "GET"
    case post   = "POST"
    case delete = "DELETE"
    case put    = "PUT"
}

protocol EndPointType{
    var baseURL   : String { get }
    var path      : String { get }
    var url       : URL? { get }
    var httpMethod: HttpMethod { get }
    var parameter : Data? { get }
    var header    : [String: String]? { get }
}

enum endPointItems{
   case demo
}

extension endPointItems: EndPointType{
    var baseURL: String {  return "https://.com/" }
    
    var path: String {
        switch self{
        case .demo                               : "api/login"
        }
    }
    
    var url: URL? {
        return URL(string: baseURL+path)
    }
    
    var httpMethod: HttpMethod {
        switch self{
        case .demo                : .get
        }
    }
    
    var parameter: Data? {
//        switch self{
//        case .demo: return Data()
//        //case .login(let loginPost) :  EncodeJson.encode(model: loginPost)
//        default :  nil
//        }
        nil
    }
    
    var header: [String : String]? {
//        let authToken = CustomUserDefaults.shared.get(key: .authToken) as? String ?? ""
//        
//        switch self{
//        case .submitSurvey(_,let boundary,_),
//             .submitLabsetupData(_, let boundary, _),
//             .addIssueReport(_,let boundary,_),
//             .submitRecieverConfirmation(_,let boundary, _) :
//            return [
//                "Authorization" : "Bearer \(authToken)",
//                "Content-Type"  : "multipart/form-data; boundary=\(boundary)"
//            ]
//            
//        default :  return [
//             "Authorization" : "Bearer \(authToken)",
//             "Content-Type"  : "application/json"
//           ]
//        }
        
        return [:]
    }
}


struct EncodeJson{
    static func encode<T: Encodable>(model: T) -> Data{
        var data: Data = Data()
        do{
            data = try JSONEncoder().encode(model)
        }
        catch let error{
            print("Error During encode the object:- ",error)
        }
        return data
    }
}
