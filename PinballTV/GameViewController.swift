//
//  GameViewController.swift
//  PinballTV
//
//  Created by Dian "Charles" Qi on 26/09/2019.
//  Copyright © 2019 Dian "Charles" Qi. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: fullSKSNameToLoad) {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
                print(fullSKSNameToLoad)
            }
            
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
            view.showsPhysics = true
            #if os(iOS)
//            print(view.isUserInteractionEnabled)
            #endif
        } else {
            print("could not find the SKS file")
        }
    }

}
