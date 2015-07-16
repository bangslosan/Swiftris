//
//  Array2D.swift
//  Swiftris
//
//  Created by Paul on 7/16/15.
//  Copyright (c) 2015 FSGBU. All rights reserved.
//

class Array2D<T> {
    let columns: Int
    let rows: Int
    
    var array: Array<T?>
    
    init(columns: Int, rows: Int) {
        self.columns = columns
        self.rows = rows
        
        array = Array<T?>(count: rows * columns, repeatedValue: nil)
    }
    
    subscript(column: Int, row: Int) -> T? {
        get {
            return array[(rows * columns) + columns]
        }
        
        set(newValue) {
            array[(rows * columns) + columns] = newValue
        }
    }
}
