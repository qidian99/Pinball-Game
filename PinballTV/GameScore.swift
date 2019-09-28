//
//  GameScore.swift
//  PinballTV
//
//  Created by Dian "Charles" Qi on 27/09/2019.
//  Copyright © 2019 Dian "Charles" Qi. All rights reserved.
//

import Foundation

class GameScore
{
    // Singleton
    static let instance = GameScore(lives: 3);
    
    var Lives : Int;
    var Score : Int;
    
    var HasLives: Bool
    {
        get
        {
            return Lives > 0;
        }
    }
    
    //==============================================================
    // Initializer
    //==============================================================
    
    init(lives: Int)
    {
        Lives = lives;
        Score = 0;
    }
    
    //==============================================================
    // Public Functions
    //==============================================================
    
    public func AddScore(scoreToAdd: Int)
    {
        Score += scoreToAdd;
    }
    
    public func TakeLife()
    {
        Lives -= 1;
    }
}
