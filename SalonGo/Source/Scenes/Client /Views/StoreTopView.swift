//
//  StoreTopView.swift
//  SalonGo
//
//  Created by Davi Capistrano and edited by Milena Maia Araújo on 05/12/22.
//

import UIKit

class StoreScreenView: UIView {
    lazy var tableView = AppointmentsTableViewController()
    lazy var topImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "Banner")
        return image
    }()

    lazy var nameCompanyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.text = "💅 SALÃO DA IAIÁ"
        return label
    }()

    lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.text = "Rua Travessa Clemente, 234 - Maraponga"
        return label
    }()

    lazy var distanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.text = "À 3km de distância."
        return label
    }()

    lazy var serviceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "redGrayColor")
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 0
        label.text = "AGENDAMENTO"

        return label
    }()

    lazy var timeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Ver horários disponíveis", for: .normal)
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.setTitleColor(.black, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 7.5
        button.backgroundColor = UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1.0)
        // button.addTarget(self, action: #selector(self.tappedRegisterButton), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        return button
    }()

    // Criado uma variável na qual armazenaremos a classificação atual INT
    private var selectedRate: Int = 0
    // Adicionando um efeito de feedback de seleção ao clicar em uma estrela
    private let feedbackGenerator = UISelectionFeedbackGenerator()
    // MARK: - User Interface
    private let container: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 70
        stackView.axis = .vertical
        return stackView
    }()

    private lazy var starsContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        // Adding a UITapGestureRecognizer to our stack of stars handle clicking on a star
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didSelectRate))
        stackView.addGestureRecognizer(tapGesture)
        return stackView
    }()
    // MARK: Private methods
    @objc private func didSelectRate(gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: starsContainer)
        let startWidth = starsContainer.bounds.width / CGFloat(Constants.starsCount)
        let rate = Int(location.x / startWidth) + 1
        // Se a estrela atual não corresponder à tarifa selecionada, alteramos nossa classificação
        if  rate != self.selectedRate {
            feedbackGenerator.selectionChanged()
            self.selectedRate = rate
        }
        // Percorrer startContainer arranjadoSubviews
        // Procure todas as subvisualizações do tipo UIImageView e altere
        // Seu estado isHighlighted (ícones dependem disso)

        starsContainer.arrangedSubviews.forEach { subviews in guard let starImageView = subviews as? UIImageView else {
            return
            }
            starImageView.isHighlighted = starImageView.tag <= rate
        }
    }
    private func createStars() {
        for index in 1...Constants.starsCount {
            let star = makeStarIcon()
            star.tag = index
            starsContainer.addArrangedSubview(star)
        }
    }
    private func makeStarIcon() -> UIImageView {
        let imageView = UIImageView(image: UIImage(named:
        "icon_unfilled_star")!, highlightedImage: UIImage(named: "icon_filled_star")!)
        imageView.contentMode = .scaleToFill
        return imageView
    }
    private func setupUI() {
        container.translatesAutoresizingMaskIntoConstraints = false
        starsContainer.translatesAutoresizingMaskIntoConstraints = false
        container.addArrangedSubview(starsContainer)

    }
    private struct Constants {
    static let starsCount: Int = 5
    }
    
    var serviceDescriptionLabel: UILabel = {
        let serviceLabel = UILabel()
        serviceLabel.translatesAutoresizingMaskIntoConstraints = false
        serviceLabel.text = "Corte simples"
        serviceLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return serviceLabel
    }()
    
    var servicePrice: UILabel = {
        let servicePrice = UILabel()
        servicePrice.translatesAutoresizingMaskIntoConstraints = false
        servicePrice.text = "R$ 80,00"
        servicePrice.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        return servicePrice
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        self.addSubview(self.topImage)
        self.addSubview(self.nameCompanyLabel)
        self.addSubview(self.addressLabel)
        self.addSubview(self.distanceLabel)
        self.addSubview(self.timeButton)
        self.addSubview(self.serviceLabel)
        self.addSubview(container)
        self.addSubview(serviceDescriptionLabel)
        self.addSubview(servicePrice)
        self.tableView.view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableView.view)
        self.createStars()
        self.setupUI()
        self.configConstraints()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configConstraints() {
            NSLayoutConstraint.activate([
            self.topImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.topImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.topImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            self.nameCompanyLabel.topAnchor.constraint(equalTo: self.topImage.bottomAnchor, constant: 10),
            self.nameCompanyLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            self.nameCompanyLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            self.addressLabel.topAnchor.constraint(equalTo: self.nameCompanyLabel.bottomAnchor, constant: 5),
            self.addressLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            self.addressLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            self.distanceLabel.topAnchor.constraint(equalTo: self.addressLabel.bottomAnchor, constant: 5),
            self.distanceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            self.distanceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            self.container.heightAnchor.constraint(equalToConstant: 18),
            self.container.widthAnchor.constraint(equalToConstant: 25),
            self.container.topAnchor.constraint(equalTo: self.distanceLabel.bottomAnchor, constant: 10),
            self.container.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -300),
            self.container.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 5),

            self.timeButton.heightAnchor.constraint(equalToConstant: 30),
            self.timeButton.widthAnchor.constraint(equalToConstant: 150),
            self.timeButton.topAnchor.constraint(equalTo: self.container.bottomAnchor, constant: 10),
            self.timeButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 5),

            self.serviceLabel.topAnchor.constraint(equalTo: self.timeButton.bottomAnchor, constant: 20),
            self.serviceLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),


            self.serviceDescriptionLabel.topAnchor.constraint(equalTo: self.serviceLabel.bottomAnchor, constant: 10),
            self.serviceDescriptionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            self.servicePrice.topAnchor.constraint(equalTo: self.serviceDescriptionLabel.bottomAnchor, constant: 5),
            self.servicePrice.centerXAnchor.constraint(equalTo: self.centerXAnchor),


            self.tableView.view.topAnchor.constraint(equalTo: self.servicePrice.bottomAnchor, constant: 10)

        ])
    }
}
