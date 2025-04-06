//
//  QuizViewController.swift
//  Onboarding
//
//  Created by Kostiantyn Kaniuka on 06.04.2025.
//

import UIKit
import SnapKit

final class QuizViewController: UIViewController {
    
    enum Strings: String {
        case titleLabel = "Let's setup App for you"
    }
    
 
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.titleLabel.rawValue
        label.frame.size = CGSize(width: 327, height: 30)
        label.font = UIFont(name: "SF Pro", size: 50)
//        label.font = UIFont(name: "SF pro display", size: 42)
        
        return label
    }()
    
    func check() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        check()
    }
}
