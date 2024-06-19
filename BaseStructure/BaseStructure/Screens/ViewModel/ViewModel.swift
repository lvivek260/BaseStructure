//
//  ViewModel.swift
//  BaseStructure
//
//  Created by PHN MAC 1 on 19/06/24.
//

import Foundation

final class ViewModel{
    let apiManager = APIManager()
    
    func getSurveyData(
        ordId: Int?,
        onSuccess: @escaping()->Void,
        onFailure: @escaping(_ title: String, _ message: String)->Void
    ){
        apiManager.request(modelType: CommonResponse.self, type: .demo) { result in
            DispatchQueue.main.async{
                switch result{
                case .success(let response) :
                    onSuccess()
                    
                case .failure(let error)    :
                    let errorMessage = MessageManager(error: error).getMessage()
                    onFailure(errorMessage.title, errorMessage.message)
                }
            }
        }
    }
    
    func addSurvey(
        ordId: Int?,
        images: [Data?],
        measurement: String?,
        onSuccess:  @escaping(_ title: String?, _ message: String?)->Void,
        onFailure: @escaping(_ title: String?, _ message: String?)->Void
    ){
        let boundary = UUID().uuidString
        let lineBreak = "\r\n"
        var body = Data()
        
        bindData(key: "ord_surv_measurements", value: measurement)
    
        //for add Image
        for image in images {
            body.append("--\(boundary + lineBreak)" .data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"ord_surv_images[]\"; filename=\"sch_logo.png\" \(lineBreak + lineBreak)" .data(using: .utf8)!)
            //  body.append("Content-Type: image/jpeg\( lineBreak + lineBreak)" .data(using: .utf8)!)
            body.append(image ?? Data())
            body.append(lineBreak .data(using: .utf8)!)
        }
        
        body.append("--\(boundary)--\(lineBreak)")
        
        func bindData(key: String, value: Any?){
            body.append("--\(boundary + lineBreak)")
            body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
            body.append("\((value as? String ?? "") + lineBreak)")
        }
        
        apiManager.request(
            modelType: CommonResponse.self,
            type: .demo
        ) { result in
            DispatchQueue.main.async{
                switch result{
                case .success(let response) :
                    onSuccess(response.status, response.message)
                    
                case .failure(let error)    :
                    let errorMessage = MessageManager(error: error).getMessage()
                    onFailure(errorMessage.title, errorMessage.message)
                }
            }
        }
    }
}
