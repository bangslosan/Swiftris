//
//  GameViewController.swift
//  Swiftris
//
//  Created by Paul on 7/16/15.
//  Copyright (c) 2015 FSGBU. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController, SwiftrisDelegate, UIGestureRecognizerDelegate {

    var scene: GameScene!
    var swiftris: Swiftris!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let skView = view as! SKView
        skView.multipleTouchEnabled = false
        
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .AspectFill
        
        scene.tick = didTick
        swiftris = Swiftris()
        swiftris.delegate = self
        swiftris.beginGame()
        
        skView.presentScene(scene)

        let tapRecognizer = UITapGestureRecognizer(target: self, action:Selector("didTap:"))
        tapRecognizer.delegate = self
        self.view.addGestureRecognizer(tapRecognizer)
//        //add nextShape to the game layer at the preview location
//        scene.addPreviewShapeToScene(swiftris.nextShape!) {
//            //reposition the underlying Shape object at the starting row and starting column
//            self.swiftris.nextShape?.moveTo(StartingColumn, row: StartingRow)
//            //ask GameScene to move it from the preview location to its starting position
//            self.scene.movePreviewShape(self.swiftris.nextShape!) {
//                //ask Swiftris for a new shape, begin ticking, and add the newly established upcoming piece to the preview area
//                let nextShapes = self.swiftris.newShape()
//                self.scene.startTicking()
//                self.scene.addPreviewShapeToScene(nextShapes.nextShape!) {}
//            }
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    //lower the falling shape by one row and then asks GameScene to redraw the shape at its new location
    func didTick() {
        swiftris.letShapeFall()
//        swiftris.fallingShape?.lowerShapeByOneRow()
//        scene.redrawShape(swiftris.fallingShape!, completion: {})
    }
    
    func nextShape() {
        let newShapes = swiftris.newShape()
        if let fallingShape = newShapes.fallingShape {
            self.scene.addPreviewShapeToScene(newShapes.nextShape!) {}
            self.scene.movePreviewShape(fallingShape) {

                //introduced a boolean which allows us to shut down interaction with the view
                self.view.userInteractionEnabled = true
                self.scene.startTicking()
            }
        }
    }
    
    func gameDidBegin(swiftris: Swiftris) {
        // The following is false when restarting a new game
        if swiftris.nextShape != nil && swiftris.nextShape!.blocks[0].sprite == nil {
            scene.addPreviewShapeToScene(swiftris.nextShape!) {
                self.nextShape()
            }
        } else {
            nextShape()
        }
    }
    
    func gameDidEnd(swiftris: Swiftris) {
        view.userInteractionEnabled = false
        scene.stopTicking()
    }
    
    func gameDidLevelUp(swiftris: Swiftris) {
        
    }
    
    func gameShapeDidDrop(swiftris: Swiftris) {
        
    }
    
    func gameShapeDidLand(swiftris: Swiftris) {
        scene.stopTicking()
        nextShape()
    }
    
    func gameShapeDidMove(swiftris: Swiftris) {
        scene.redrawShape(swiftris.fallingShape!) {}
    }
    
    //MARK: Gesture
    func didTap(recognizer: UITapGestureRecognizer) {
        println("get the gesture")
    }
}
