//
//  ServicesMock.swift
//  SalonGo
//
//  Created by Milena Maia Araújo on 30/11/22.
//

import Foundation

struct ServiceAppointment {
    let serviceName: String
    let price: String
    let serviceDay: String?
    let serviceTime: String?
}

let services = [
ServiceAppointment(serviceName: "Corte de cabelo", price: "R$ 80,00", serviceDay: "12/11", serviceTime: "10:00"),
ServiceAppointment(serviceName: "Depilação", price: "R$ 45,00", serviceDay: "21/11", serviceTime: "12:00"),
ServiceAppointment(serviceName: "Escova orgânica", price: "R$ 60,00", serviceDay: "22/11", serviceTime: "16:00")]
