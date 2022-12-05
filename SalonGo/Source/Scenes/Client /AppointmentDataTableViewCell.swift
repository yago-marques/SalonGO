//
//  AppointmentsTableViewCell.swift
//  SalonGo
//
//  Created by Milena Maia Araújo on 30/11/22.
//

import UIKit

class AppointmentDataTableViewCell: UITableViewCell {

    static let identifier = "AppointmentDataTableViewCell"

    var myServices: ServiceAppointment! {
        didSet {
            DispatchQueue.main.async {
                self.serviceDay.text = self.myServices.serviceDay
                self.serviceTime.text = self.myServices.serviceTime
            }
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let identifier = "AppointmentsTableViewCell"

        addSubview(serviceDay)
        labelConfigConstraints()

        addSubview(serviceTime)
        priceLabelConfigConstraints()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var serviceDay: UILabel = {
        let serviceLabel = UILabel()
        serviceLabel.translatesAutoresizingMaskIntoConstraints = false
        serviceLabel.numberOfLines = 0
        serviceLabel.text = "Service day"
        return serviceLabel
    }()

   lazy var serviceTime: UILabel = {
        let priceLabel = UILabel()
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.text = "Service Time"
        priceLabel.numberOfLines = 0
        priceLabel.textColor = UIColor(named: "PlaceholderGray")
        return priceLabel
    }()

    func labelConfigConstraints() {
        NSLayoutConstraint.activate([
            serviceDay.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            serviceDay.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            serviceDay.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }

    func priceLabelConfigConstraints() {
        NSLayoutConstraint.activate([
            serviceTime.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
//            priceLabel.leadingAnchor.constraint(equalTo: serviceLabel.trailingAnchor, constant: 10),
            serviceTime.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30)
        ])
    }

}
