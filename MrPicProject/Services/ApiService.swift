//
//  ApiService.swift
//  MrPicProject
//
//  Created by 박소현 on 2023/10/02.
//

import Alamofire
import SwiftyJSON

class ApiService {
    
    var isLastUser = false
    
    var isPaging = false
    
    func getUserList(completion: @escaping(UserGenerator?) -> ()) {
        
        AF.request(Constants.baseUrl, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil, interceptor: nil).responseDecodable(of: UserGenerator.self) { response in
            
            let statusCode = response.response?.statusCode ?? -1
            print("statusCode :: \(statusCode)")
            
            print("response :: \(JSON(response.data as Any))")
            if let userGenerator = response.value {
                
                let userListCnt = userGenerator.userList.count
                if userListCnt == 0 || userListCnt < Constants.userCnt {
                    self.isLastUser = true
                }
                
                completion(userGenerator)
            }
            else if let error = response.error {
                print("error :: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
    
    
}
