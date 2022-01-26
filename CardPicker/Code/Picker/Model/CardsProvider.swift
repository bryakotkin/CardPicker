//
//  Card.swift
//  CardPicker
//
//  Created by Nikita on 01.01.2022.
//

import Foundation
import UIKit

enum CardType: String, CaseIterable {
    case clubs = "c"
    case diamonds = "d"
    case hearts = "h"
    case spades = "s"
}

enum CardRang: String, CaseIterable {
    case six
    case seven
    case eight
    case nine
    case ten
    case jack
    case queen
    case king
    case ace
    
    func getCardsDescription() -> String {
        switch self {
        case .six:
            return "Задание 1"
        case .seven:
            return "Задание 2"
        case .eight:
            return "Задание 3"
        case .nine:
            return "Задание 4"
        case .ten:
            return "Задание 5"
        case .jack:
            return "Задание 6"
        case .queen:
            return "Задание 7"
        case .king:
            return "Задание 8"
        case .ace:
            return "Задание 9"
        }
    }
}

class Card {
    let rang: CardRang
    let type: CardType
    let image: UIImage
    
    init(rang: CardRang, type: CardType) {
        self.rang = rang
        self.type = type
        self.image = UIImage(named: "\(rang)\(type.rawValue)") ?? UIImage()
    }
}

class CardsProvider {
    
    static let shared: CardsProvider = {
        let provider = CardsProvider()
        
        var cards: [Card] = []
        
        for type in CardType.allCases {
            var set: [Card] = []
            for rang in CardRang.allCases {
                set.append(Card(rang: rang, type: type))
            }
            cards.append(contentsOf: set)
        }
        
        provider.cards = cards
        
        return provider
    }()
    
    private var cards: [Card] = []
    
    private init() {}
    
    func getCards() -> [Card] {
        return cards.shuffled()
    }
}
