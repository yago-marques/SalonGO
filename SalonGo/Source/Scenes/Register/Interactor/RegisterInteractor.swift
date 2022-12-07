//
//  RegisterInteractor.swift
//  SalonGo
//
//  Created by Yago Marques on 06/12/22.
//

import Foundation

protocol RegisterInteracting: AnyObject {
    func saveUser(with user: User) throws
}

final class RegisterInteractor {
    var coreData: UserDBManager

    init(coreData: UserDBManager) {
        self.coreData = coreData
    }
}

extension RegisterInteractor: RegisterInteracting {
    func saveUser(with user: User) throws {
        do {
            try coreData.createUser(with: user)
        } catch {
            throw error
        }
    }
}