//
//  Interactor.swift
//  Viper
//
//  Created by Андрей Колесников on 20.11.2021.
//

import Foundation

//to get data or perform interaction
//Obj
//Protocol
//ref to presenter

// "https://jsonplaceholder.typicode.com/users"

enum FetchError: Error {
    case failedToFetch
}

protocol AnyInteractor {
    var presenter: AnyPresenter? {get set}
    
    func getUsers()
}

class MainInteractor: AnyInteractor {
    var presenter: AnyPresenter?
    
    func getUsers() {
        let task = URLSession.shared.dataTask(with: URL(string: "https://jsonplaceholder.typicode.com/users")!) {[weak self] data, _, error in
            guard let data = data, error == nil else {
                self?.presenter?.interactorDidFetchUsers(with: .failure(FetchError.failedToFetch))
                return
            }
            
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                self?.presenter?.interactorDidFetchUsers(with: .success(users))
            } catch let error {
                print(error.localizedDescription)
                self?.presenter?.interactorDidFetchUsers(with: .failure(error))
            }
        }
        task.resume()
    }

}
