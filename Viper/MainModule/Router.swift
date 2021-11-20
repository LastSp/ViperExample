//
//  Router.swift
//  Viper
//
//  Created by Андрей Колесников on 20.11.2021.
//

import Foundation
import UIKit


//Obj
//Entry Point

typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter {
    var entry: EntryPoint? {get}
    static func start() -> AnyRouter
}

class UserRouter: AnyRouter {
    
    var entry: EntryPoint?
    
    static func start() -> AnyRouter {
        let router = UserRouter()
        
        //assign other VIP
        var view: AnyView = UsersViewController()
        var presenter: AnyPresenter = MainPresenter()
        var interactor: AnyInteractor = MainInteractor()
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        view.presenter = presenter
        
        router.entry = view as? EntryPoint
        
        return router
    }

}
