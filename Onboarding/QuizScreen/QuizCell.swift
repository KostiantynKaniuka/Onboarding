//
//  QuizCell.swift
//  Onboarding
//
//  Created by Kostiantyn Kaniuka on 07.04.2025.
//

import UIKit
import SnapKit

final class QuizCell: UITableViewCell {
    private let quizCellId = "quizID"
    
    private let customBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true

        return view
    }()
    
    private let customSelectedBackgroundView: UIView? = {
        let motherView = UIView()
        let view = UIView()
        view.backgroundColor = UIColor(named: "SelectedCellColor")
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        motherView.addSubview(view)
        
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        
        return motherView
    }()
    
    private let cellLabel: UILabel = {
        let label = UILabel()
        label.text = "text"
        label.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        
        return label
    }()
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
   
    }
    

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
          super.init(style: style, reuseIdentifier: reuseIdentifier)
          configureView()
        setUpConstraints()
      }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureView() {
        backgroundColor = .clear
        backgroundView = customBackgroundView
        selectedBackgroundView = customSelectedBackgroundView
    }
  
    
    private func setUpConstraints() {
        contentView.bounds.size.height = 100
        addSubview(cellLabel)
        
        cellLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(32)
        }
        
        customBackgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
    }
    
    func setText(_ text: String?) {
        cellLabel.text = text ?? ""
    }

}
