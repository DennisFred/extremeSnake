//
//  Cell.swift
//  extremeSnake
//
//  Created by Dennis Schilling on 10.06.17.
//  Copyright © 2017 DennisSchilling. All rights reserved.
//

import Foundation
import SpriteKit

enum CellType {
    case food(Int), snakeElement
}

protocol Cell {
    var type: CellType { get }
}


