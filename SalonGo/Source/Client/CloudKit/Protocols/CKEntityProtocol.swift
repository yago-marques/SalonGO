//
//  EntitiesProtocols.swift
//  SalonGo
//
//  Created by Yago Marques on 08/11/22.
//

import Foundation

enum CloudKitEntityTypes {
    case account, user, company, rating, service, appoimtment
}

protocol CKEntityProtocol {
    var type: CloudKitEntityTypes { get set }
    var body: Data { get set }
}

extension CKEntityProtocol {
    func getKeys() -> [String] {
        let keys: [String]

        switch self.type {
        case .account:
            keys = EntityFields().account
        case .user:
            keys = EntityFields().user
        case .company:
            keys = EntityFields().company
        case .rating:
            keys = EntityFields().rating
        case .service:
            keys = EntityFields().service
        case .appoimtment:
            keys = EntityFields().appointment
        }

        return keys
    }

    func getValues() -> [Any] {
        guard let object = self.decodeEntity() else { return [] }
        var values = [Any]()

        switch self.type {
        case .account:
            values = readObjectValues(at: object)
        case .user:
            values = readObjectValues(at: object)
        case .company:
            values = readObjectValues(at: object)
        case .rating:
            values = readObjectValues(at: object)
        case .service:
            values = readObjectValues(at: object)
        case .appoimtment:
            values = readObjectValues(at: object)
        }

        return values
    }
}

private extension CKEntityProtocol {
    private func decodeEntity() -> Any? {
        let object: Any?

        switch self.type {
        case .account:
            object = try? JSONDecoder().decode(CKAccount.self, from: self.body)
        case .user:
            object = try? JSONDecoder().decode(CKUser.self, from: self.body)
        case .company:
            object = try? JSONDecoder().decode(CKCompany.self, from: self.body)
        case .rating:
            object = try? JSONDecoder().decode(CKRating.self, from: self.body)
        case .service:
            object = try? JSONDecoder().decode(CKService.self, from: self.body)
        case .appoimtment:
            object = try? JSONDecoder().decode(CKAppointment.self, from: self.body)
        }

        return object
    }

    private func readObjectValues(at object: Any) -> [Any] {
        let myObject = object as? CKStructProtocol

        if let myObject {
            return myObject.makeValues()
        } else {
            return []
        }
    }
}