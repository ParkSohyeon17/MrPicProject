//
//  UserListViewModel.swift
//  MrPicProject
//
//  Created by 박소현 on 2023/10/02.
//

import UIKit

class UserListViewModel: NSObject {
    
    var apiService: ApiService!
    var refreshControl: UIRefreshControl?
    
    private(set) var userList: [UserGenerator.User]? {
        didSet {
            bindToController()
        }
    }
    
    var bindToController : (() -> ()) = {}
    
    override init() {
        super.init()
        
        apiService = ApiService()
        getUserListData()
    }
    
    func getUserListData() {
        apiService.getUserList() { userGenerator in
            
            if let userGenerator = userGenerator {
                
                if self.apiService.isPaging == true {
                    print("기존 :: \(self.userList?.count)")
                    self.userList?.append(contentsOf: userGenerator.userList)
                    print("추가 :: \(self.userList?.count)")
                    
                    self.apiService.isPaging = !self.apiService.isPaging
                }
                else {
                    self.userList = userGenerator.userList
                }
                
                
                
            }
            
        }
    }
}
