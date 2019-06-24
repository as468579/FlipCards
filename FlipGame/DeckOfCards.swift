//
//  DeckOfCards.swift
//  FlipGame
//
//  Created by User18 on 2019/6/23.
//  Copyright © 2019 jackliu. All rights reserved.
//

import Foundation

class DeckOfCards{
    
    static let faces:  [String] = ["orc", "ghost", "bat", "turtle", "bear", "bird", "wolf", "rabbit"]
    
    var numberOfCards: Int
    var currentCard: Int
    var deck: [Card]
    
    init(numberOfCards num:Int){
        self.numberOfCards = num
        self.currentCard = 0
        self.deck = [Card]()
        for i in stride(from: 0, to: num, by: 1) {
            deck.insert(Card(face: DeckOfCards.faces[i/2]), at: i)
        }
    }
    
    func shuffle(){
        currentCard = 0
        deck.shuffle()
    }
    
    func  getCard(index: Int) -> Card? {
        if index < numberOfCards{
            return deck[index]
        }
        else{
            return nil
        }
    }
    
    func dealCard() -> Card?{
        if currentCard < numberOfCards{
            let card = deck[currentCard]
            currentCard += 1
            return card
        }
        else{
            return nil
        }
    }
    
    
    
}
