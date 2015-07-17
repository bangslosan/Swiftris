//
//  Block.swift
//  Swiftris
//
//  Created by Paul on 7/16/15.
//  Copyright (c) 2015 FSGBU. All rights reserved.
//

import SpriteKit

let NumberOfColors: UInt32 = 6

//Type of Int and implements the Printable protocol
enum BlockColor: Int, Printable {
    case Blue = 0, Orange, Purple, Red, Teal, Yellow
    
    var spriteName: String {
        switch self {
        case .Blue:
            return "blue"
        case .Orange:
            return "orange"
        case .Purple:
            return "purple"
        case .Red:
            return "red"
        case .Teal:
            return "teal"
        case .Yellow:
            return "yellow"
        }
    }
    
    var description: String {
        return self.spriteName
    }
    
    static func random() -> BlockColor {
        //Return a color
        return BlockColor(rawValue: Int(arc4random_uniform(NumberOfColors)))!
    }
}

//Implements Hashable and Printable protocol
//Hashable allow Block to be stored in Array2D
class Block: Hashable, Printable {
    let color: BlockColor
    
    var column: Int
    var row: Int
    
    //The SKSpriteNode represent the visual element of the Block
    var sprite: SKSpriteNode?
    
    //Shorten the block name from block.color.spriteName to block.spriteName
    var spriteName: String {
        return color.spriteName
    }
    
    //required in Hashable protocol
    var hashValue: Int {
        //exclusive-or of our row and column
        return self.column ^ self.row
    }
    
    var description: String {
        return "\(color): [\(column), \(row)]"
    }
    
    init(column: Int, row: Int, color: BlockColor) {
        self.column = column
        self.row = row
        self.color = color
    }
}

//To judge two Block is equal
func == (lhs: Block, rhs: Block) -> Bool {
    return lhs.column == rhs.column && lhs.row == rhs.row && lhs.color.rawValue == rhs.color.rawValue
}