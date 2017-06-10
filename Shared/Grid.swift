//
//  Grid.swift
//  extremeSnake
//
//  Created by Dennis Schilling on 10.06.17.
//  Copyright © 2017 DennisSchilling. All rights reserved.
//

import Foundation

struct Grid {
    private var contents : [Cell]
    private var columns: Int
    
    
    init(columns:Int, rows:Int) {
        self.columns = columns
        contents = []
    }
}
