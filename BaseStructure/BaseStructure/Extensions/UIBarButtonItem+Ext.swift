//
//  UIBarButtonItem+Ext.swift
//  LMS
//
//  Created by PHN Tech 2 on 24/01/24.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    var isHidden: Bool {
        get {
            return tintColor == .clear
        }
        set {
            tintColor = newValue ? .clear : .white //or whatever color you want
            isEnabled = !newValue
            isAccessibilityElement = !newValue
        }
    }

}

//MARK: Extension of URLRequest to generate the CURL request from URLRequest
extension URLRequest {
    var curlCommand: String {
        guard let url = self.url else {
            return "Unable to generate cURL command without URL."
        }

        var curlCommand = "curl -X \(self.httpMethod ?? "GET") '\(url.absoluteString)'"

        if let headers = self.allHTTPHeaderFields {
            for (key, value) in headers {
                curlCommand += " -H '\(key): \(value)'"
            }
        }

        if let bodyData = self.httpBody, let bodyString = String(data: bodyData, encoding: .utf8) {
            curlCommand += " -d '\(bodyString)'"
        }

        return curlCommand
    }
}
