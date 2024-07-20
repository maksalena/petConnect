//
//  ClinicFeedbackTableViewCell.swift
//  PetConnect
//
//  Created by SHREDDING on 27.10.2023.
//

import UIKit
import SnapKit
import UIColorExtensions

class ClinicSendFeedbackTableViewCell: UITableViewCell {
    
    lazy var markView:UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var feedbackMark:UILabel = {
        let label = UILabel()
        label.text = "4.8"
        label.font = UIFont.SFProDisplay(weight: .semibold, ofSize: 64)
        return label
    }()
        
    lazy var starsHorisontalStackView:UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.backgroundColor = .clear
        
        for _ in 0..<5{
            let star = UIImageView()
            star.image = UIImage(systemName: "star.fill")
            star.tintColor = .systemYellow
            stackView.addArrangedSubview(star)
        }
        return stackView
    }()
    
    lazy var marksNumber:UILabel = {
        let label = UILabel()
        label.text = "35 оценок"
        label.textColor = .systemGray
        return label
    }()
    
    lazy var sendFeedbackView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "FAFDFA")
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor(resource: .shadow).cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 8
        view.layer.shadowOffset = CGSize(width: 1, height: 1)
        
        return view
    }()
    
    lazy var writeFeedbackLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.SFProDisplay(weight: .bold, ofSize: 16)
        label.textAlignment = .center
        label.textColor = UIColor(hexString: "6D7A75")
        label.text = "Оцените и напишите отзыв"
        return label
    }()
    
    lazy var sendFeedbackStarsHorisontalStackView:UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        stackView.backgroundColor = .clear
        
        for _ in 0..<5{
            let star = UIImageView()
            star.contentMode = .scaleAspectFill
            star.image = UIImage(systemName: "star.fill")
            star.tintColor = .systemYellow
            star.snp.makeConstraints { make in
                make.height.width.equalTo(40)
            }
            stackView.addArrangedSubview(star)
        }
        return stackView
    }()
    
    lazy var sendFeedbackButton:UIButton = {
        var conf = UIButton.Configuration.filled()
        conf.baseBackgroundColor = UIColor(hexString: "E4EEE9")
        conf.baseForegroundColor = .primary
        conf.cornerStyle = .capsule
        
        let button = UIButton(configuration: conf)
        let title = NSAttributedString(string: "Написать отзыв", attributes: [.font: UIFont.SFProDisplay(weight: .bold, ofSize: 15)!])
        button.setAttributedTitle(title, for: .normal)
        return button
    }()
    
    
    lazy var allFeedbacks:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.SFProDisplay(weight: .semibold, ofSize: 17)
        label.text = "Все отзывы"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit(){
        self.selectionStyle = .none
        
        self.contentView.addSubview(markView)
        self.markView.addSubview(feedbackMark)
        self.markView.addSubview(starsHorisontalStackView)
        self.markView.addSubview(marksNumber)
        
        // MARK: - Send Feedback
        self.contentView.addSubview(sendFeedbackView)
        self.sendFeedbackView.addSubview(writeFeedbackLabel)
        self.sendFeedbackView.addSubview(sendFeedbackStarsHorisontalStackView)
        self.sendFeedbackView.addSubview(sendFeedbackButton)
        
        self.contentView.addSubview(allFeedbacks)

                
        markView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(55)
        }
        
        feedbackMark.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(40)
            make.top.bottom.equalToSuperview()
        }
        
        starsHorisontalStackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(feedbackMark.snp.trailing).offset(30)
            make.width.equalTo(140)
        }
        
        marksNumber.snp.makeConstraints { make in
            make.leading.equalTo(feedbackMark.snp.trailing).offset(30)
            make.trailing.lessThanOrEqualToSuperview().inset(40)
            make.bottom.equalToSuperview().inset(5)
        }
        
        sendFeedbackView.snp.makeConstraints { make in
            make.top.equalTo(markView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(190)
        }
        
        writeFeedbackLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        sendFeedbackStarsHorisontalStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(47)
            make.top.equalTo(writeFeedbackLabel.snp.bottom).offset(20)
            make.height.equalTo(40)
        }
        sendFeedbackButton.snp.makeConstraints { make in
            make.bottom.trailing.leading.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
        allFeedbacks.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().offset(20)
            make.top.equalTo(sendFeedbackView.snp.bottom).offset(32)
            make.bottom.equalToSuperview()
        }
        
    }
}
