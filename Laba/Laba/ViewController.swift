//
//  ViewController.swift
//  Laba
//
//  Created by   Павел Недобежкин on 14.10.2023.
//

import UIKit

class ViewController: UIViewController {
    private var numberOfCards = 24
    private lazy var game : Concentration = Concentration(numberOfPairsOfCards: (numberOfCards+1)/2,numberOfButtons: cardButtons.count)
    @IBOutlet private weak var scoreCountLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    private var emojies = ["🍓🍊🍋🍌🍏🍉🥥🍍🫐🍒🍑🥭", "⚽️🏀🏈⚾️🥎🎾🏐🏉🥏🎱🏓🏒", "🚗🚕🚙🚌🚎🏎️🚓🚑🚒🚐🛻🚚"]
    private var indEm = 0
    lazy var emojiChoices = emojies[indEm]
    private var emoji = [Card:String]()

    private func emoji(for card: Card)->String{
        
        if emoji[card] == nil, emojiChoices.count > 0{
            let randomStingIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy:Int.random(in: 0..<emojiChoices.count))
            emoji[card] = String(emojiChoices.remove(at: randomStingIndex))
            
        }
        return emoji[card] ?? "?"
    }
    @IBAction func Restart(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards:(numberOfCards+1)/2,numberOfButtons: cardButtons.count)
        if indEm == 3{
            emojiChoices = emojies[Int(arc4random_uniform(UInt32(3)))]
        } else{
            emojiChoices = emojies[indEm]
        }
        updateViewFromModel()
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNum = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardNum)
            updateViewFromModel()
        }
        scoreCountLabel.text = "Score: \(game.score)"
    }
    
    
    @IBAction func Hint(_ sender: UIButton) {
        game.showAllCards()
        updateViewFromModel()
        DispatchQueue.main.asyncAfter(deadline: .now()+2){
            self.game.hideAllCards()
            self.updateViewFromModel()
        }
    }
    
    
    @IBAction func changeNumOfCards(_ sender: UIButton) {
        switch(sender.titleLabel?.text){
        case "🟥":
            numberOfCards = 12
            sender.setTitle("🟨", for: UIControl.State.normal)
        case "🟨":
            numberOfCards = 8
            sender.setTitle("🟩", for: UIControl.State.normal)
        case "🟩":
            numberOfCards = 24
            sender.setTitle("🟥", for: UIControl.State.normal)
        default:
            break
        }
    }
    
    
    @IBAction func changeThemes(_ sender: UIButton) {
        switch(sender.titleLabel?.text){
        case "🍓":
            sender.setTitle("⚽️", for: UIControl.State.normal)
            indEm = 1
        case "⚽️":
            sender.setTitle("🚗", for: UIControl.State.normal)
            indEm = 2
        case "🚗":
            sender.setTitle("🔀", for: UIControl.State.normal)
            indEm = 3
        case "🔀":
            sender.setTitle("🍓", for: UIControl.State.normal)
            indEm = 0
        default:
            break
        }
    }
    
    private func updateViewFromModel(){
        for index in 0..<game.cards.count{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
            else{
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)  : #colorLiteral(red: 1, green: 0.5853247549, blue: 0, alpha: 1)
            }
        }
    }
}


