//
//  AppoitmentsScreenViewController.swift
//  SalonGo
//
//  Created by Milena Maia Araújo on 05/12/22.
//

import UIKit

class AppointmentsScreenViewController: UIViewController {
    var screen: StoreScreenView?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.screen = StoreScreenView()
        self.view = self.screen
    }
}
