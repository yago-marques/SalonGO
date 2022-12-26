//
//  OnboardingControllerTests.swift
//  SalonGoTests
//
//  Created by Yago Marques on 06/12/22.
//

import XCTest
import UIKit
@testable import SalonGo

final class OnboardingControllerTests: XCTestCase {

    func test_setupButtonTitle_withNewTitle_shouldCallViewMethodToModifyTitle() {
        let (sut, doubles) = self.makeSUT()
        let title = "Próximo"

        sut.setup(buttonTitle: title)

        XCTAssertEqual(doubles.viewMock.receivedMessages, [.setup(buttonTitle: title)])
    }

    func test_showOnboarding_shouldCallMethodToShowOnboarding() {
        let (sut, doubles) = self.makeSUT()

        sut.showOnboarding()

        XCTAssertEqual(doubles.viewMock.receivedMessages, [.showOnboarding])
    }

    func test_displayScreen_atIndexTwo_shouldShowCorrectPage() {
        let (sut, doubles) = self.makeSUT()
        let indexToTest = 2

        sut.displayScreen(at: 2)

        XCTAssertEqual(doubles.viewMock.receivedMessages, [.displayScreen(index: indexToTest)])
    }

    func test_getPage_AfterShowPageAtIndexTwo_shouldReturnIntTwo() {
        let (sut, doubles) = self.makeSUT()
        let indexToTest = 2

        sut.displayScreen(at: indexToTest)
        let currentyPage = sut.getPage()

        XCTAssertEqual(doubles.viewMock.receivedMessages, [
            .displayScreen(index: indexToTest),
            .getPage(3)
        ])
        XCTAssertEqual(currentyPage, 3)
    }

    func test_showPrevButton_shouldCallMethodToShowPrevButton() {
        let (sut, doubles) = self.makeSUT()

        sut.showPrevButton()

        XCTAssertEqual(doubles.viewMock.receivedMessages, [.showPrevButton])
    }

    func test_hidePrevButton_shouldCallMethodToHidePrevButton() {
        let (sut, doubles) = self.makeSUT()

        sut.hidePrevButton()

        XCTAssertEqual(doubles.viewMock.receivedMessages, [.hidePrevButton])
    }

}

extension OnboardingControllerTests {
    typealias SutAndDoubles = (
        sut: OnboardingController,
        doubles: (
            presenterSpy: OnboardingPresenterSpy,
            viewMock: OnboardingViewMock
        )
    )

    private func makeSUT() -> SutAndDoubles {
        let presenterSpy = OnboardingPresenterSpy(router: OnboardingRouter())
        let viewMock = OnboardingViewMock()
        let sut = OnboardingController(
            uiView: UIView(frame: .zero),
            viewDelegate: viewMock,
            presenter: presenterSpy
        )

        return (sut, (presenterSpy, viewMock))
    }
}
