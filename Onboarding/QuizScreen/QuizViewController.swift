//
//  QuizViewController.swift
//  Onboarding
//
//  Created by Kostiantyn Kaniuka on 06.04.2025.
//

import UIKit
import SnapKit

final class QuizViewController: UIViewController {
    
    private enum Strings: String {
        case titleLabel = "Let's setup App for you"
        case appBackgroundColor = "AppBackground"
        case continueButton = "Continue"
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.titleLabel.rawValue
        label.frame.size = CGSize(width: 327, height: 30)
        label.font = UIFont(name: "SFProDisplay-Bold", size: 26)
        
        return label
    }()
    
    private let quizTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.register(QuizCell.self, forCellReuseIdentifier: "quizID")
        tableView.register(QuizHeaderView.self, forHeaderFooterViewReuseIdentifier: "quizHeader")
        tableView.isScrollEnabled = false
        
        return tableView
    }()
    
    private let continueButton: UIButton = {
        var button = UIButton()
        let attributedText = NSMutableAttributedString(string: Strings.continueButton.rawValue, attributes: [
            NSAttributedString.Key.font: UIFont(name: "SFProDisplay-Regular", size: 17) ?? UIFont.boldSystemFont(ofSize: 17),
                    NSAttributedString.Key.foregroundColor: UIColor.white,
                    NSAttributedString.Key.kern: 1
                ])
        var continueConfig = UIButton.Configuration.filled()
        continueConfig.baseBackgroundColor = .black
        continueConfig.cornerStyle = .capsule
        
        button.configuration = continueConfig
        button.setAttributedTitle(attributedText, for: .normal)
      
        //button.layer.cornerRadius = 40
        //button.layer.masksToBounds = true
        button.frame.size = CGSize(width: 357, height: 56)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        for family in UIFont.familyNames.sorted() {
//            let names = UIFont.fontNames(forFamilyName: family)
//            print("Family: \(family) Font names: \(names)")
//        }
        
        view.backgroundColor = UIColor(named: Strings.appBackgroundColor.rawValue)
        quizTableView.delegate = self
        quizTableView.dataSource = self
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        }
        
        view.addSubview(continueButton)
        
        continueButton.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.width.equalTo(327)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-8)
        }
        
        view.addSubview(quizTableView)
    
        quizTableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalTo(continueButton.snp.top).offset(-32)
        }
        
        
    
    }
}

//MARK: - Data Source

extension QuizViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "quizID", for: indexPath)
       
 
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "quizHeader") as? QuizHeaderView
        view?.addText(_title: "title")
        return view
    }
}

//MARK: - Delegate
extension QuizViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? QuizCell {
            cell.switchTextColor(_cell: true)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? QuizCell {
            cell.switchTextColor(_cell: false)
        }
    }
}
