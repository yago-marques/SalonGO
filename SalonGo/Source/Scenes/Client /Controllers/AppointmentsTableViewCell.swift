//
//  AppointmentsTableViewCell.swift
//  SalonGo
//
//  Created by Milena Maia Araújo on 29/11/22.
//

import UIKit

class AppointmentsTableViewCell: UITableViewCell {

    static let identifier = "AppointmentsTableViewCell"

    var myServices: ServiceAppointment! {
        didSet {
            DispatchQueue.main.async {
                self.serviceLabel.text = self.myServices.serviceName
                self.priceLabel.text = self.myServices.price
            }
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let identifier = "AppointmentsTableViewCell"

        addSubview(serviceLabel)
        labelConfigConstraints()

        addSubview(priceLabel)
        priceLabelConfigConstraints()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var serviceLabel: UILabel = {
        let serviceLabel = UILabel()
        serviceLabel.translatesAutoresizingMaskIntoConstraints = false
        serviceLabel.numberOfLines = 0
        serviceLabel.text = "Service Label"
        return serviceLabel
    }()

   lazy var priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.text = "R$80,00"
        priceLabel.numberOfLines = 0
        priceLabel.textColor = UIColor(named: "PlaceholderGray")
        return priceLabel
    }()

    func labelConfigConstraints() {
        NSLayoutConstraint.activate([
            serviceLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            serviceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            serviceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }

    func priceLabelConfigConstraints() {
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
//            priceLabel.leadingAnchor.constraint(equalTo: serviceLabel.trailingAnchor, constant: 10),
            priceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30)
        ])
    }

}
