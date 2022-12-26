//
//  OnboardingViewSpy.swift
//  SalonGoTests
//
//  Created by Yago Marques on 06/12/22.
//

import Foundation
@testable import SalonGo

final class OnboardingViewMock: OnboardingViewDelegate {
    enum Message: Equatable {
        case showOnboarding, showPrevButton, hidePrevButton
        case getPage(Int)
        case setup(buttonTitle: String)
        case displayScreen(index: Int)
    }

    private var currentyPage = 0

    private(set) var receivedMessages = [Message]()

    func showOnboarding() {
        receivedMessages.append(.showOnboarding)
    }

    func setup(buttonTitle: String) {
        receivedMessages.append(.setup(buttonTitle: buttonTitle))
    }

    func getPage() -> Int {
        receivedMessages.append(.getPage(currentyPage))

        return currentyPage
    }

    func displayScreen(at index: Int) {
        receivedMessages.append(.displayScreen(index: index))
        self.currentyPage = index + 1
    }

    func showPrevButton() {
        receivedMessages.append(.showPrevButton)
    }

    func hidePrevButton() {
        receivedMessages.append(.hidePrevButton)
    }
}
