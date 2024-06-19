//
//  UpdateApplication.swift
//  LMS
//
//  Created by PHN MAC 1 on 24/04/24.
//

import UIKit

final class UpdateApplication{
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func checkForUpdate(){
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        
        getLatestVersion { (latestVersion, appUrlStr) in
            DispatchQueue.main.async{ [self] in
                if let latestVersion, !isAppUpToDate(currentVersion: appVersion, latestVersion: latestVersion) {
                    self.showAlertMessage(appUrlStr: appUrlStr)
                }
            }
        }
    }
    
    private func showAlertMessage(appUrlStr: String?){
        let alertMessage = UIAlertController(title: "Update Required", message: "A new version of the app is available. You must update to continue using the app", preferredStyle: .alert)
        let updateAction = UIAlertAction(title: "Update Now", style: .default) { (action) in
            if let appUrl = URL(string: appUrlStr ?? ""){
                   UIApplication.shared.open(appUrl, options: [:], completionHandler: nil)
            }
        }
        alertMessage.addAction(updateAction)
        
        window.rootViewController?.present(alertMessage, animated: true)
    }
    

    private func getLatestVersion(onSuccess: @escaping (_ version: String?,_ appUrlStr: String?) -> Void) {
        let identifier = Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String ?? ""
        guard let url = URL(string: "http://itunes.apple.com/lookup?bundleId=\(identifier)&country=in") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data else { return }
            
            if let responseString = String(data: data, encoding: .utf8) {
                print("Response: \(responseString)")
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any],
                   let results = json["results"] as? [[String: Any]],
                   let firstResult = results.first{
                    let version = firstResult["version"] as? String
                    let appUrlStr = firstResult["trackViewUrl"] as? String
                    onSuccess(version, appUrlStr)
                }
            } catch {}
        }.resume()
    }
    
    
    func isAppUpToDate(currentVersion: String, latestVersion: String) -> Bool {
        let components1 = currentVersion.components(separatedBy: ".")
        let components2 = latestVersion.components(separatedBy: ".")
        
        for (index, component) in components1.enumerated() {
            if index < components2.count {
                if let number1 = Int(component), let number2 = Int(components2[index]) {
                    if number1 < number2 {
                        return false
                    } else if number1 > number2 {
                        return true
                    }
                } else {
                    let result = component.compare(components2[index])
                    if result == .orderedDescending {
                        return true
                    } else if result == .orderedAscending {
                        return false
                    }
                }
            } else {
                return true
            }
        }
        
        return components1.count >= components2.count
    }
}


