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
        
        return tableView
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
        
        view.addSubview(quizTableView)
        
        quizTableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.left.right.bottom.equalToSuperview().inset(16)
        }
    }
}

extension QuizViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "quizID", for: indexPath)
       
 
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
  
    
}

extension QuizViewController: UITableViewDelegate {
    
}
