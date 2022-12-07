//
//  MyAppointmentsViewController.swift
//  SalonGo
//
//  Created by Milena Maia Araújo on 29/11/22.
//

import UIKit

class ServiceTableViewHeader: UITableViewHeaderFooterView {
    static let identifier = "ServiceTableViewHeader"

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}

class ServiceTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // salva o mock com as informações do serviço
    let serviceData = serviceDataMock
    let nailService = serviceNailMock
    var sectionNumber = 0
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableViewConfigConstraints()

        tableView.register(ServiceTableViewCell.self, forCellReuseIdentifier: ServiceTableViewCell.identifier)
        tableView.register(ServiceTableViewHeader.self, forHeaderFooterViewReuseIdentifier: "ServiceTableViewHeader")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return serviceData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: ServiceTableViewCell.identifier, for: indexPath) as? ServiceTableViewCell {
                cell.myServices = serviceData[indexPath.row]
                return cell
            }
        }

        if indexPath.section == 1 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: ServiceTableViewCell.identifier, for: indexPath) as? ServiceTableViewCell {
                cell.myServices = nailService[indexPath.row]
                return cell
            }
        }

        return UITableViewCell()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    // alterar título da section pelo número
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        self.sectionNumber = section
        if section == 0 {
            return "CABELO"
        }
        return "MANICURE"
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ServiceTableViewHeader")
        return header
    }

    func tableViewConfigConstraints() {
//        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10)])
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("cell \(indexPath.row + 1) tapped.")
    }
}
