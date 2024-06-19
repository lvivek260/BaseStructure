//
//  Data+Extension.swift
//  Field Executive
//
//  Created by PHN MAC 1 on 30/11/23.
//

import Foundation

extension Data {
   mutating func append(_ string: String) {
      if let data = string.data(using: .utf8) {
         append(data)
      }
   }
}
