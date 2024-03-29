//
//  OnboardingView.swift
//  SalonGo
//
//  Created by Yago Marques on 25/11/22.
//

import UIKit
import Lottie

protocol OnboardingViewDelegate: AnyObject {
    func showOnboarding()
    func setup(buttonTitle: String)
    func getPage() -> Int
    func displayScreen(at index: Int)
    func isPossibleNext(_ newState: Bool)
    func showPrevButton()
    func hidePrevButton()
}

enum OnboardingDirection {
    case next, prev, invalid
}

final class OnboardingView: UIView {

    private var isPossibleToNext = true
    var controller: OnboardingControlling?
    var actions: OnboardingDirection = .next {
        didSet {
            controller?.capturedAction(direction: self.actions)
        }
    }

    private lazy var carouselCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let width = self.frame.width
        let height = width * 1.3
        layout.itemSize = CGSize(width: width, height: height)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0

        let myCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        myCollectionView.register(OnboardingCell.self, forCellWithReuseIdentifier: "OnboardingCell")
        myCollectionView.backgroundColor = .clear
        myCollectionView.isUserInteractionEnabled = false
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        myCollectionView.translatesAutoresizingMaskIntoConstraints = false
        myCollectionView.showsHorizontalScrollIndicator = false

        return myCollectionView
    }()

    private lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.translatesAutoresizingMaskIntoConstraints = false
        control.numberOfPages = 3
        control.currentPage = 0
        control.isUserInteractionEnabled = false
        control.pageIndicatorTintColor = .gray
        control.currentPageIndicatorTintColor = UIColor(named: "Pink")!

        return control
    }()

    private lazy var nextButton: UICustomButton = {
        let button = UICustomButton()
        button.setupButton(title: "Continuar", font: (17, .semibold))
        button.addTarget(self, action: #selector(toNext), for: .touchUpInside)

        return button
    }()

    private lazy var prevButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.setTitle("Voltar", for: .normal)
        button.backgroundColor = .systemBackground
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(toPrev), for: .touchUpInside)
        button.layer.cornerRadius = 10
        button.setTitleColor(.tintColor, for: .normal)

        return button
    }()

    init(frame: CGRect, controller: OnboardingControlling? = nil) {
        self.controller = controller
        super.init(frame: frame)

        buildLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
}

extension OnboardingView: OnboardingViewDelegate {
    func showOnboarding() {
        buildLayout()
    }

    func getPage() -> Int {
        self.pageControl.currentPage
    }

    func setup(buttonTitle: String) {
        UIView.transition(
            with: nextButton,
            duration: 0.3,
            options: .transitionCrossDissolve,
            animations: {
                self.nextButton.setTitle(buttonTitle, for: .normal)
            }
        )
    }

    func displayScreen(at index: Int) {
        pageControl.currentPage = index
        navigateToCorrectScreen(at: index)
    }

    func isPossibleNext(_ newState: Bool) {
        self.isPossibleToNext = newState
    }

    func showPrevButton() {
        self.addSubview(prevButton)

        NSLayoutConstraint.activate([
            prevButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            prevButton.leadingAnchor.constraint(
                equalToSystemSpacingAfter: self.leadingAnchor,
                multiplier: 2
            )
        ])
    }

    func hidePrevButton() {
        self.prevButton.removeFromSuperview()
    }
}

@objc private extension OnboardingView {
    func toNext() {
        if isPossibleToNext {
            actions = .next
            successAnimateButton()
        } else {
            actions = .invalid
            failureAnimateButton()
        }
    }

    func toPrev() {
        actions = .prev
        pageControl.currentPage -= 1
        navigateToCorrectScreen(at: pageControl.currentPage)
    }
}

private extension OnboardingView {
    func navigateToCorrectScreen(at index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        carouselCollection.isPagingEnabled = false
        carouselCollection.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        carouselCollection.isPagingEnabled = true
    }

    func makeHaptic() {
        let hapticSoft = UIImpactFeedbackGenerator(style: .soft)
        let hapticRigid = UIImpactFeedbackGenerator(style: .rigid)

        hapticSoft.impactOccurred(intensity: 1.00)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            hapticRigid.impactOccurred(intensity: 1.00)
        }
    }

    func successAnimateButton() {
        makeHaptic()

        UIView.animate(withDuration: 0.1, animations: { }, completion: { _ in
            UIView.animate(withDuration: 0.1, animations: {
                self.nextButton.layer.opacity = 0.5
            }, completion: { _ in
                UIView.animate(withDuration: 0.1, animations: {
                    self.nextButton.layer.opacity = 1
                })
            })
        })
    }

    func failureAnimateButton() {
        makeHaptic()

        UIView.animate(withDuration: 0.1, animations: { }, completion: { _ in
            UIView.animate(withDuration: 0.1, animations: {
                self.nextButton.frame.origin.x += 10
            }, completion: { _ in
                UIView.animate(withDuration: 0.1, animations: {
                    self.nextButton.frame.origin.x -= 10
                })
            })
        })
    }
}

extension OnboardingView: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollPos = scrollView.contentOffset.x / self.frame.width
        pageControl.currentPage = Int(scrollPos)
    }
}

extension OnboardingView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "OnboardingCell",
            for: indexPath
        ) as? OnboardingCell else {
            return UICollectionViewCell()
        }

        cell.viewModel = controller?.getCellViewModel(at: indexPath.row) ?? .init(
            animation: "",
            title: "",
            subtitle: ""
        )

        return cell
    }
}

extension OnboardingView: ViewCoding {
    func setupView() {
        self.backgroundColor = .systemBackground
    }

    func setupHierarchy() {
        let views: [UIView] = [
            carouselCollection,
            pageControl,
            nextButton
        ]
        views.forEach { self.addSubview($0) }
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            carouselCollection.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            carouselCollection.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            carouselCollection.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            carouselCollection.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            nextButton.bottomAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.bottomAnchor,
                constant: self.frame.width*(-1)/10
            ),
            nextButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            nextButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            nextButton.heightAnchor.constraint(equalTo: nextButton.widthAnchor, multiplier: 0.2),

            pageControl.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -10),
            pageControl.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
