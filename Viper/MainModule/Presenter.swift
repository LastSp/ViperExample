//
//  Presenter.swift
//  Viper
//
//  Created by Андрей Колесников on 20.11.2021.
//

import Foundation

//Obj
//protocol
// ref to interactor, router, view

protocol AnyPresenter {
    var router: AnyRouter? {get set}
    var interactor: AnyInteractor? {get set}
    var view: AnyView? {get set}
    
    func interactorDidFetchUsers(with result: Result<[User], Error>)
}

class MainPresenter: AnyPresenter {

    var router: AnyRouter?
    
    var interactor: AnyInteractor? {
        didSet {
            interactor?.getUsers()
        }
    }
    
    var view: AnyView?

     
    func interactorDidFetchUsers(with result: Result<[User], Error>) {
        switch result{
        case.success(let users):
            view?.updateWithUsers(with: users)
        case.failure:
            view?.updateWithError(with: "Failed")
        }
    }
    
    
}
