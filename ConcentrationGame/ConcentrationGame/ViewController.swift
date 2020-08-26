//
//  ViewController.swift
//  ConcentrationGame
//
//  Created by Max on 7/25/20.
//  Copyright © 2020 Max. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private lazy var game = Concentration(numberOfPairs: numberOfPairs)
    var numberOfPairs: Int{
        get{
            return (cardButtons.count + 1) / 2
        }
    }
    
    private var cardColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    private var cardEmoji = [Card:String]()
    private var emojiChoices = [String]()
    private var currentThemeIndex = 0
    
    private let themes = [
        Theme(name: "fruits", emoji: ["🍏","🍎","🍐","🍊","🍋","🍌","🍉","🍇","🍓"], colors: [#colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1),#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)]),
        Theme(name: "cars", emoji: ["🚗","🚕","🚙","🚌","🚎","🚓","🚒","🚐","🚚"], colors: [#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)]),
        Theme(name: "flags", emoji: ["🇨🇦","🇨🇱","🇹🇩","🇨🇮","🇯🇵","🇫🇮","🇬🇧","🏴󠁧󠁢󠁥󠁮󠁧󠁿","🇺🇸"], colors: [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)]),
        Theme(name: "sport", emoji: ["⚽️","🏀","🏈","⚾️","🥎","🏐","🏉","🎾","🎱"], colors: [#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1),#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)]),
        Theme(name: "street food", emoji: ["🍕","🍟","🍔","🌭","🍗","🥨","🥞","🥐","🌮"], colors: [#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1),#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)]),
        Theme(name: "animals", emoji: ["🐶","🐱","🐭","🐼","🐰","🦊","🐻","🐨","🐵"], colors: [#colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1),#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)]),
    ]
    

    @IBOutlet weak var themeLabel: UILabel!
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        setTheme()
        updateViewFromModel()
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }else{
            print("Chosen card not in array")
        }
    }
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func startNewGame(_ sender: UIButton) {
        game.reset()
        game = Concentration(numberOfPairs: numberOfPairs)
        cardEmoji.removeAll()
        setTheme()
        updateViewFromModel()
    }
    
    private func updateViewFromModel(){
        flipCountLabel.text = "Flips: \(game.flipCount)"
        flipCountLabel.textColor = cardColor
        
        scoreLabel.text = "Score: \(game.score)"
        scoreLabel.textColor = cardColor
        
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(getEmoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }else{
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) : cardColor
            }
        }
    }
    
    private func getEmoji(for card: Card)->String{
        if cardEmoji[card] == nil, emojiChoices.count > 0{
            let randomIndex = getRandomIndex(for: emojiChoices.count)
            cardEmoji[card] = emojiChoices.remove(at: randomIndex)
        }
        return cardEmoji[card] ?? "?"
    }
    
    private func getRandomIndex(for arrayCount: Int)->Int{
        return Int(arc4random_uniform(UInt32(arrayCount)))
    }
    
    private func setTheme(){
        var newThemeIndex = getRandomIndex(for: themes.count)
        
        while newThemeIndex == currentThemeIndex {
            newThemeIndex = getRandomIndex(for: themes.count)
        }
        
        currentThemeIndex = newThemeIndex
        emojiChoices = themes[currentThemeIndex].emojiSet
        cardColor = themes[currentThemeIndex].colors[0]
        themeLabel.text = themes[currentThemeIndex].name
        themeLabel.textColor = cardColor
        view.backgroundColor = themes[currentThemeIndex].colors[1]
    }
    
    
}

