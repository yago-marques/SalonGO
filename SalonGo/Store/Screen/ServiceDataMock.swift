//
//  ServicesMock.swift
//  SalonGo
//
//  Created by Milena Maia Araújo on 07/12/22.
//

import Foundation

struct ServiceData {
    let serviceName: String
    let price: String
    let serviceDuration: String?

}

let serviceDataMock = [
    ServiceData(serviceName: "Escova Simples", price: "R$ 90,00", serviceDuration: "Duração: 1:30h"),
    ServiceData(serviceName: "Escova Orgânica", price: "R$ 90,00", serviceDuration: "Duração: 1:30h"),
    ServiceData(serviceName: "Escova Vegana", price: "R$ 90,00", serviceDuration: "Duração: 1:30h"),
]


let serviceNailMock = [
    ServiceData(serviceName: "Unha de acrílico", price: "R$ 90,00", serviceDuration: "Duração: 1:30h"),
    ServiceData(serviceName: "Unha tal", price: "R$ 90,00", serviceDuration: "Duração: 1:30h"),
    ServiceData(serviceName: "Unha do outro tal", price: "R$ 90,00", serviceDuration: "Duração: 1:30h"),
]
