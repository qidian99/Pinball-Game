//
//  GameScene_GameControllers.swift
//  PinballTV
//
//  Created by Dian "Charles" Qi on 27/09/2019.
//  Copyright © 2019 Dian "Charles" Qi. All rights reserved.
//

import Foundation
import SpriteKit
import GameController

extension GameScene {
    
    func setUpControllerObservers() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(connectControllers), name: NSNotification.Name.GCControllerDidConnect, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(controllerDisconnected), name: NSNotification.Name.GCControllerDidDisconnect, object: nil)
    }
    
    @objc func connectControllers() {
        
        self.isPaused = false
        
        for controller in GCController.controllers() {
            
            if (controller.extendedGamepad != nil && controller.playerIndex == .indexUnset) {
                
                if (playerIndex1InUse == false) {
                    
                    // Set the controller for player 1
                    controller.playerIndex = .index1
                    playerIndex1InUse = true
                } else {
                    
                    // Player 1 must already have been setup, so set this controller to player 2

                    controller.playerIndex = .index2
                }
                
                controller.extendedGamepad?.valueChangedHandler = nil
                setUpExtendedController(controller: controller)
            } else if (controller.extendedGamepad != nil && controller.playerIndex != .indexUnset) {
                
                controller.extendedGamepad?.valueChangedHandler = nil
                setUpExtendedController(controller: controller)
            } else if (controller.gamepad != nil && controller.playerIndex == .indexUnset) {
                
                if (playerIndex1InUse == false) {
                    
                    // Set the controller for player 1
                    controller.playerIndex = .index1
                    playerIndex1InUse = true
                } else {
                    
                    // Player 1 must already have been setup, so set this controller to player 2
                    
                    controller.playerIndex = .index2
                }
                
                controller.gamepad?.valueChangedHandler = nil
                setUpStandardController(controller: controller)
            } else if (controller.gamepad != nil && controller.playerIndex != .indexUnset) {
                
                controller.gamepad?.valueChangedHandler = nil
                setUpStandardController(controller: controller)
            }
        }
    }
    
    func setUpExtendedController( controller:GCController ) {
        
        controller.extendedGamepad?.valueChangedHandler = {
            (gamepad:GCExtendedGamepad, element:GCControllerElement) in
            if (gamepad.controller?.playerIndex == .index1) {
                // this is player 1 playing the controller
            } else if (gamepad.controller?.playerIndex == .index2) {
                // this is player 2 playing the controller
            }
            
            if (gamepad.leftThumbstick == element) {
                if (gamepad.leftThumbstick.left.value > 0.2) {
                    self.tappedLeft()
                } else if (gamepad.leftThumbstick.left.isPressed == false) {
                    self.letGoLeft()
                }
            } else if (gamepad.rightThumbstick == element) {
                if (gamepad.leftThumbstick.right.value > 0.2) {
                    self.tappedRight()
                } else if (gamepad.leftThumbstick.right.isPressed == false) {
                    self.letGoRight()
                }
            } else if (gamepad.dpad == element) {
                if (gamepad.dpad.right.isPressed == true) {
                    self.tappedRight()
                } else if (gamepad.dpad.right.isPressed == false) {
                    self.letGoRight()
                }
                
                if (gamepad.dpad.left.isPressed == true) {
                    self.tappedLeft()
                } else if (gamepad.dpad.left.isPressed == false) {
                    self.letGoLeft()
                }
            } else if (gamepad.leftShoulder == element) {
                if (gamepad.leftShoulder.isPressed == true) {
                    self.tappedLeft()
                } else if (gamepad.leftShoulder.isPressed == false) {
                    self.letGoLeft()
                }
            } else if (gamepad.leftTrigger == element) {
                if (gamepad.leftTrigger.isPressed == true) {
                    self.tappedLeft()
                } else if (gamepad.leftTrigger.isPressed == false) {
                    self.letGoLeft()
                }
            } else if (gamepad.rightShoulder == element) {
                if (gamepad.rightShoulder.isPressed == true) {
                    self.tappedRight()
                } else if (gamepad.rightShoulder.isPressed == false) {
                    self.letGoRight()
                }
            } else if (gamepad.rightTrigger == element) {
                if (gamepad.rightTrigger.isPressed == true) {
                    self.tappedRight()
                } else if (gamepad.rightTrigger.isPressed == false) {
                    self.letGoRight()
                }
            } else if (gamepad.buttonA == element) {
                
                print("pressed Button A")
                
            }
            
        }
    }
    
    func setUpMicroController( controller:GCController ) {
        controller.microGamepad?.valueChangedHandler = {
            (gamepad:GCMicroGamepad, element:GCControllerElement) in
            
            gamepad.reportsAbsoluteDpadValues = true
            gamepad.allowsRotation = true
            
            if (gamepad.dpad == element) {
                
                if (gamepad.dpad.right.value > 0.1) {
                    
                    self.tappedRight()
                }
                
                if (gamepad.dpad.left.value > 0.1) {
                    self.tappedLeft()
                }
                
                if (gamepad.dpad.right.value == 0.0) {
                    self.letGoRight()
                }
                
                if (gamepad.dpad.left.value == 0.0) {
                    self.letGoLeft()
                }
            }
        }
    }
        
    func setUpStandardController( controller:GCController ) {
        
        controller.gamepad?.valueChangedHandler = {
            (gamepad:GCGamepad, element:GCControllerElement) in
            if (gamepad.controller?.playerIndex == .index1) {
                // this is player 1 playing the controller
            } else if (gamepad.controller?.playerIndex == .index2) {
                // this is player 2 playing the controller
            }
            
            if (gamepad.dpad == element) {
                if (gamepad.dpad.right.isPressed == true) {
                    self.tappedRight()
                } else if (gamepad.dpad.right.isPressed == false) {
                    self.letGoRight()
                }
                
                if (gamepad.dpad.left.isPressed == true) {
                    self.tappedLeft()
                } else if (gamepad.dpad.left.isPressed == false) {
                    self.letGoLeft()
                }
            } else if (gamepad.leftShoulder == element) {
                if (gamepad.leftShoulder.isPressed == true) {
                    self.tappedLeft()
                } else if (gamepad.leftShoulder.isPressed == false) {
                    self.letGoLeft()
                }
            } else if (gamepad.rightShoulder == element) {
                if (gamepad.rightShoulder.isPressed == true) {
                    self.tappedRight()
                } else if (gamepad.rightShoulder.isPressed == false) {
                    self.letGoRight()
                }
            } else if (gamepad.buttonA == element) {
                
                print("pressed Button A")
                
            }
        
        }

        
        for controller in GCController.controllers() {
            if (controller.extendedGamepad != nil) {
                // ignore
            } else if (controller.gamepad != nil) {
                // ignore
            } else if (controller.microGamepad != nil && controller.playerIndex == .indexUnset ) {
                if (playerIndex1InUse == false) {
                    
                    // Set the controller for player 1
                    controller.playerIndex = .index1
                    playerIndex1InUse = true
                } else {
                    
                    // Player 1 must already have been setup, so set this controller to player 2
                    
                    controller.playerIndex = .index2
                }
                
                controller.microGamepad?.valueChangedHandler = nil
                setUpMicroController( controller: controller )
            } else if (controller.microGamepad != nil && controller.playerIndex != .indexUnset) {
                controller.microGamepad?.valueChangedHandler = nil
                setUpMicroController( controller: controller )
            }
        }
    }
    
    @objc func controllerDisconnected() {
        self.isPaused = true
    }
}
