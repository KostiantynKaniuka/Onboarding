//
//  QuizHeaderView.swift
//  Onboarding
//
//  Created by Kostiantyn Kaniuka on 08.04.2025.
//

import UIKit
import SnapKit

final class QuizHeaderView: UITableViewHeaderFooterView {
    
    private let title: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFUIText-Bold", size: 20)
        
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints() {
        addSubview(title)
        
        title.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(4)
        }
    }
    
    func addText(_title text: String?) {
        title.text = text ?? ""
    }
}
