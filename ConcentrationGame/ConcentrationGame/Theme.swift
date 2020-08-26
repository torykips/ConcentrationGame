//
//  Theme.swift
//  ConcentrationGame
//
//  Created by Max on 7/25/20.
//  Copyright © 2020 Max. All rights reserved.
//
import UIKit
import Foundation

struct Theme{
    var name: String
    var emojiSet: [String]
    var colors: [UIColor]
    
    init(name: String, emoji: [String], colors: [UIColor]) {
        self.emojiSet = emoji
        self.colors = colors
        self.name = emoji[0] + name.capitalized + emoji[1]
    }
}
