//
//  ViewController.swift
//  MrPicProject
//
//  Created by 박소현 on 2023/10/01.
//

import UIKit

class UserListViewController: UIViewController {
    
    @IBOutlet weak var userListTableView: UITableView!
    
    private var userListViewModel: UserListViewModel!

    private var isBottom = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userListTableView.delegate = self
        userListTableView.dataSource = self
        
        userListTableView.separatorStyle = .none
        
        userListViewModel = UserListViewModel()
        userListViewModel.bindToController = {
            print("reload ::")
            self.userListTableView.reloadData()
        }
        
        userListViewModel.refreshControl = UIRefreshControl()
        userListViewModel.refreshControl?.addTarget(self, action: #selector(pullToRefresh(_:)), for: .valueChanged)
        userListTableView.refreshControl = userListViewModel.refreshControl
        
    }
    
    @objc func pullToRefresh(_ sender: Any) {
        userListViewModel.getUserListData()
        userListViewModel.refreshControl?.endRefreshing()
    }
}

extension UserListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userListViewModel.userList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "UserListTableViewCell") as? UserListTableViewCell, let user = userListViewModel.userList?[indexPath.row] {
            
            cell.createUser(user: user)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if isBottom, !userListViewModel.apiService.isLastUser {
            
            if let userListCnt = userListViewModel.userList?.count {
                
                let lastIndex = userListCnt - 1
                
                if indexPath.row == lastIndex {
                    
                    userListViewModel.apiService.isPaging = true
                    
                    print("isBottom :: 추가 데이터 요청")
                    userListViewModel.getUserListData()
                }
            }
            
        }
        
    }
}

extension UserListViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yVelocity = scrollView.panGestureRecognizer.velocity(in: scrollView).y
        
        if yVelocity < 0 {
            isBottom = true
        }
        else if yVelocity > 0 {
            isBottom = false
        }
    }
    
}
