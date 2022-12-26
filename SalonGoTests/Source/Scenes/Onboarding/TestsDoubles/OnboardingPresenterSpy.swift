//
//  RegisterPresenterMock.swift
//  SalonGoTests
//
//  Created by Yago Marques on 06/12/22.
//

import Foundation
@testable import SalonGo

final class OnboardingPresenterSpy: OnboardingPresenting {
    enum Message: Equatable {
        case showOnboardingIfNeeded
        case verifyCapturedAction(direction: OnboardingDirection)
        case getCellViewModel(row: Int)
    }

    var router: OnboardingRouting
    var controller: OnboardingControllerDelegate?

    private(set) var receivedMessages = [Message]()

    init(router: OnboardingRouting, controller: OnboardingControllerDelegate? = nil) {
        self.router = router
        self.controller = controller
    }

    func showOnboardingIfNeeded() {
        receivedMessages.append(.showOnboardingIfNeeded)
    }

    func verifyCapturedAction(direction: OnboardingDirection) {
        receivedMessages.append(.verifyCapturedAction(direction: direction))
    }

    func getCellViewModel(row: Int) -> OnboardingViewModel {
        receivedMessages.append(.getCellViewModel(row: row))

        return .init(animation: "", title: "", subtitle: "")
    }

}
