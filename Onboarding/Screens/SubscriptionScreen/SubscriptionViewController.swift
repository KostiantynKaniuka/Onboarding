//
//  SubscriptionViewController.swift
//  Onboarding
//
//  Created by Kostiantyn Kaniuka on 09.04.2025.
//

import UIKit
import SnapKit

final class SubscriptionViewController: UIViewController {
    //MARK: - Properties
    private var storeManager = StoreManager()
    
    private let termsUrl = "https://images.steamusercontent.com/ugc/949591360446272042/2EAD55272BDBA9A2999440F5A357566256D537DF/?imw=5000&imh=5000&ima=fit&impolicy=Letterbox&imcolor=%23000000&letterbox=false"
    
    private let image: UIImageView = {
        let image = UIImageView(image: UIImage(named: "subscription image"))
        image.contentMode = .scaleAspectFill
        
        return image
    }()
    
    //MARK: - UI properties
    private let headTitleLabel: UILabel = {
        let label = UILabel ()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 32)
        let firstPart = "Discover All"
        let secondPart = "Premium features"
        label.text = firstPart + "\n" + secondPart
        label.numberOfLines = 2
        
        return label
    }()
    
    private let offerLabel: UILabel = {
        let label = UILabel()
            label.numberOfLines = 2
            label.textColor = .darkGray

            let firstPart = "Try 7 Days for free\n"
            let secondPartStart = "$6.99"
            let secondPartRest = " per week, auto-renewable"

            let attributedText = NSMutableAttributedString(
                string: firstPart,
                attributes: [.font: UIFont(name: "SFProDisplay-Regular", size: 16) as Any]
            )

            let boldPrice = NSAttributedString(
                string: secondPartStart,
                attributes: [.font: UIFont(name: "SFProDisplay-Bold", size: 16) as Any]
            )

            let restText = NSAttributedString(
                string: secondPartRest,
                attributes: [.font: UIFont(name: "SFProDisplay-Regular", size: 16) as Any]
            )
        
            attributedText.append(boldPrice)
            attributedText.append(restText)

            label.attributedText = attributedText
            return label
    }()
    
    private let startButton: UIButton = {
        var button = UIButton()
        let attributedText = NSMutableAttributedString(string: "Start Now", attributes: [
            NSAttributedString.Key.font: UIFont(name: "SFProDisplay-Regular", size: 17) ?? UIFont.boldSystemFont(ofSize: 17),
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.kern: 1
        ])
        var continueConfig = UIButton.Configuration.filled()
        continueConfig.baseBackgroundColor = .black
        continueConfig.cornerStyle = .capsule
        
        button.configuration = continueConfig
        button.setAttributedTitle(attributedText, for: .normal)
        button.frame.size = CGSize(width: 357, height: 56)
        
        return button
    }()
    
    private let conditionsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        label.textColor = .darkGray
        label.text = "By continuing you accept our:"
        
        return label
    }()
    

        
    //MARK: - Lifecycle
 
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "AppBackground")
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        setUpNavigationCrossItem()
        setUpConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = true
    }
    
    //MARK: - Methods
    private func setUpNavigationCrossItem() {
        let crossButton = UIBarButtonItem(
            image: UIImage(systemName: "xmark")?.withRenderingMode(.automatic),
            style: .plain,
            target: self,
            action: #selector(crossButtonTapped)
        )
        crossButton.tintColor = .black
        self.navigationController?.navigationBar.tintColor = .black
          navigationItem.rightBarButtonItem = crossButton
    }
    
    @objc private func crossButtonTapped () {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func startButtonTapped() {
        Task {
            do {
                try await storeManager.purchase(storeManager.products.first!)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: - Constraints
    private func setUpConstraints() {
        view.addSubview(image)
        
        image.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.snp.centerY)
        }
        
        view.addSubview(headTitleLabel)
        
        headTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(32)
        }
        
        view.addSubview(offerLabel)
        
        offerLabel.snp.makeConstraints { make in
            make.top.equalTo(headTitleLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(32)
        }
                
        let stackView = makeHyperLinks()
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-8)
            make.centerX.equalToSuperview()
            make.height.greaterThanOrEqualTo(20)
                make.width.lessThanOrEqualTo(view.snp.width).offset(-32)
        }
        
        view.addSubview(startButton)
        
        startButton.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.width.equalTo(327)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(stackView.snp.top).offset(-16)
        }
    }
}

private extension SubscriptionViewController {
  
    func makeHyperLinks() -> UIStackView {
        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .equalSpacing
        verticalStackView.alignment = .center
        verticalStackView.spacing = 8

        let linksTextView = UITextView()
        linksTextView.backgroundColor = .clear
        linksTextView.isScrollEnabled = false
        linksTextView.isEditable = false
        linksTextView.textContainerInset = .zero
        linksTextView.textContainer.lineFragmentPadding = 0

        linksTextView.translatesAutoresizingMaskIntoConstraints = false
        linksTextView.heightAnchor.constraint(equalToConstant: 20).isActive = true

        let color = UIColor(named: "hyperlinkcolor") ?? .systemBlue
        let font = UIFont(name: "SFProDisplay-Regular", size: 12) ?? UIFont.systemFont(ofSize: 12)

        let attributedString = NSMutableAttributedString()
        
        // Add the hyperlinks
        attributedString.append(makeHyperlink(text: "Terms of Use", url: termsUrl, font: font))
        attributedString.append(NSAttributedString(string: ", ", attributes: [.font: font]))
        attributedString.append(makeHyperlink(text: "Privacy Policy", url: termsUrl, font: font))
        attributedString.append(NSAttributedString(string: ", ", attributes: [.font: font]))
        attributedString.append(makeHyperlink(text: "Subscription Terms", url: termsUrl, font: font))

        linksTextView.linkTextAttributes = [.foregroundColor: color]
        linksTextView.attributedText = attributedString

        verticalStackView.addArrangedSubview(conditionsLabel)
        verticalStackView.addArrangedSubview(linksTextView)

        return verticalStackView
    }

     func makeHyperlink(text: String, url: String, font: UIFont) -> NSAttributedString {
        let range = NSRange(location: 0, length: text.count)
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.link, value: url, range: range)
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
        attributedString.addAttribute(.font, value: font, range: range)
        return attributedString
    }
}
