//
//  PickerView.swift
//  CardPicker
//
//  Created by Nikita on 02.01.2022.
//

import UIKit

protocol PickerViewProtocol: AnyObject {
    func onCardClick()
    func onBarButtonClick()
}

class PickerView: UIView {
    
    weak var delegate: PickerViewProtocol?
    
    let cardImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "back")
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    let backImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "back")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()

    let taskView: UITextView = {
        let label = UITextView()
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.text = ""
        label.backgroundColor = .black
        label.textColor = .white
        label.textAlignment = .center
        label.isEditable = false
        label.isSelectable = false

        return label
    }()
    
    let resetButton: UIBarButtonItem = {
        let resetButton = UIBarButtonItem()
        resetButton.title = "Сбросить"
        resetButton.tintColor = .white
        
        return resetButton
    }()
    
    let counterButton: UIBarButtonItem = {
        let counterButton = UIBarButtonItem()
        counterButton.title = ""
        counterButton.isEnabled = false
        counterButton.tintColor = .white
        
        return counterButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black
        
        setupSubviews()
        setupConstraints()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        addSubview(backImage)
        addSubview(cardImage)
        addSubview(taskView)
    }
    
    private func setupConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        cardImage.translatesAutoresizingMaskIntoConstraints = false
        backImage.translatesAutoresizingMaskIntoConstraints = false
        taskView.translatesAutoresizingMaskIntoConstraints = false
        
        let cardImageConstraint = [
            cardImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            cardImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            cardImage.rightAnchor.constraint(equalTo: rightAnchor, constant: -16)
        ]
        
        let backImageConstraint = [
            backImage.centerXAnchor.constraint(equalTo: cardImage.centerXAnchor),
            backImage.centerYAnchor.constraint(equalTo: cardImage.centerYAnchor),
            backImage.widthAnchor.constraint(equalTo: cardImage.widthAnchor),
            backImage.heightAnchor.constraint(equalTo: cardImage.heightAnchor)
        ]
        
        let taskViewConstraint = [
            taskView.topAnchor.constraint(equalTo: cardImage.bottomAnchor, constant: 16),
            taskView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            taskView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            taskView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
            taskView.heightAnchor.constraint(equalToConstant: 150)
        ]
        
        constraints.append(contentsOf: cardImageConstraint)
        constraints.append(contentsOf: backImageConstraint)
        constraints.append(contentsOf: taskViewConstraint)
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupActions() {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(onCardClick))
        cardImage.addGestureRecognizer(recognizer)
        
        resetButton.target = self
        resetButton.action = #selector(onBarButtonClick)
    }
    
    @objc func onCardClick() {
        delegate?.onCardClick()
    }
    
    @objc func onBarButtonClick() {
        delegate?.onBarButtonClick()
    }
}
