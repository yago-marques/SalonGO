//
//  ViewController.swift
//  SalonGo
//
//  Created by Milena Lima de Alcântara on 07/11/22.
//

import UIKit
import CloudKit

struct AccountEntity: CKEntityProtocol {
    var type: CloudKitEntityTypes = .account

    var body: Data = Data()

    init(account: CKAccount) {
        let data = try? JSONEncoder().encode(account)
        if let data { self.body = data }
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

//        // code to test start
//        let cloudKit = CloudKitClient(
//            container: CKContainerHelper(database: CKContainer.default().publicCloudDatabase)
//        )
//
//        let account: CKAccount = .init(
//            userId: "abc",
//            email: "yago@yago.com",
//            password: "yago123",
//            isCompany: false,
//            createdAt: Date(),
//            updatedAt: Date()
//        )
//
//        cloudKit.create(AccountEntity(account: account)) { error in
//            print(error)
//        }
//        // code to test end

    }

}