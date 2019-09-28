//
//  MenuScene.swift
//  PinballTV
//
//  Created by Dian "Charles" Qi on 28/09/2019.
//  Copyright © 2019 Dian "Charles" Qi. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class MenuScene:SKScene
{
    //==============================================================
    // Public Override Functions
    //==============================================================
    
    override public func didMove(to view: SKView)
    {
        backgroundColor = SKColor.black;
        DrawText();
    }
    
    override public func sceneDidLoad()
    {
        //Father, forgive me for I have hardcoded.
        GameScore.instance.Lives = 3;
        GameScore.instance.Score = 0;
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        SKTAudio.sharedInstance().playSoundEffect("CoinIn2.wav");
        let sksNameToLoad:String = "GameScene"
        
        var fullSKSNameToLoad:String = sksNameToLoad
        
        if (UIDevice().userInterfaceIdiom == .pad) {
            print("ipad")
            if let _ = SKScene(fileNamed: fullSKSNameToLoad + "Pad") {
                fullSKSNameToLoad = sksNameToLoad + "Pad"
            }
        } else if (UIDevice().userInterfaceIdiom == .phone) {
            print("iphone")
            if let _ = SKScene(fileNamed: fullSKSNameToLoad + "Phone") {
                fullSKSNameToLoad = sksNameToLoad + "Phone"
            }
        } else if (UIDevice().userInterfaceIdiom == .tv) {
            print("apple TV")
            if let _ = SKScene(fileNamed: fullSKSNameToLoad + "TV") {
                fullSKSNameToLoad = sksNameToLoad + "TV"
            }
        }
        let newScene = SKScene(fileNamed: fullSKSNameToLoad)
        newScene?.scaleMode=scaleMode;
        
        let transition = SKTransition.doorway(withDuration: 1.0);
        self.view?.presentScene(newScene!, transition: transition);
        
    }
    
    //==============================================================
    // Private Functions
    //==============================================================
    
    private func DrawText()
    {
        let titleLabel = SKLabelNode(text:"Swift");
        SetFontSettings(label: titleLabel, fontColor: SKColor.white, fontSize: 60);
        titleLabel.position = CGPoint(x:self.frame.size.width/2, y:self.frame.size.height/2 + 50)
        
        
        let title2Label = SKLabelNode(text:"Pinball")
        SetFontSettings(label: title2Label, fontColor: SKColor.white, fontSize: 70);
        title2Label.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2);
        
        
        let tipLabel=SKLabelNode(text:"Tap to Begin")
        SetFontSettings(label: tipLabel, fontColor: SKColor.white, fontSize: 40);
        tipLabel.position=CGPoint(x: self.frame.size.width/2, y: tipLabel.fontSize);
        
        self.addChild(titleLabel);
        self.addChild(title2Label);
        self.addChild(tipLabel);
    }
    
    private func SetFontSettings(label: SKLabelNode, fontColor: SKColor, fontSize: Int)
    {
        label.fontName = "Copperplate Bold";
        label.fontColor = fontColor;
        label.fontSize = CGFloat(fontSize);
    }
}
