//
//  PickerViewController.swift
//  CardPicker
//
//  Created by Nikita on 01.01.2022.
//

import UIKit

class PickerViewController: UIViewController {
    
    var cards: [Card] = CardsProvider.shared.getCards()
    var currentCard: Card!
    var isOpen = false
    
    var mainView: PickerView {
        return view as! PickerView
    }
    
    override func loadView() {
        let view = PickerView()
        self.view = view
    }
    
    let notification: UIAlertController = {
        let alert = UIAlertController(title: "Уведомление", message: "Пожалуйста, сбросьте игру.", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(cancelAction)
        
        return alert
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.delegate = self
        
        setupNavigationBar()
        setupCard()
    }
    
    private func setupNavigationBar() {
        mainView.counterButton.title = "\(cards.count)"
        
        navigationItem.rightBarButtonItem = mainView.resetButton
        navigationItem.leftBarButtonItem = mainView.counterButton
    }
    
    private func setupCard() {
        guard let card = cards.first else { return }
        currentCard = card
    }
}

// MARK: - PickerViewController: PickerViewProtocol

extension PickerViewController: PickerViewProtocol {
    func onCardClick() {
        if !cards.isEmpty {
            if isOpen {
                UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut) { [unowned self] in
                    mainView.cardImage.center.x = mainView.cardImage.center.x + view.bounds.width
                } completion: { [unowned self] isFinish in
                    if isFinish {
                        mainView.cardImage.image = UIImage(named: "back")
                        mainView.cardImage.center.x = view.center.x
                        cards.remove(at: 0)
                        navigationItem.leftBarButtonItem?.title = "\(cards.count)"
                        setupCard()
                    }
                }
                
                mainView.taskView.text = ""
            }
            else {
                mainView.cardImage.image = currentCard.image
                UIView.transition(with: mainView.cardImage, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
                mainView.taskView.text = currentCard.rang.getCardsDescription()
            }
            isOpen = !isOpen
        }
        else {
            present(notification, animated: true, completion: nil)
        }
    }
    
    func onBarButtonClick() {
        cards = CardsProvider.shared.getCards()
        isOpen = false
        mainView.cardImage.image = UIImage(named: "back")
        mainView.taskView.text = ""
        setupCard()
        navigationItem.leftBarButtonItem?.title = "\(cards.count)"
    }
}

