//
//  BaseGamblingDataSource.swift
//  Focus
//
//  Created by Igor Starobor on 17.10.2020.
//  Copyright © 2020 Igor Starobor. All rights reserved.
//

import Foundation

protocol BaseGamblingDataSource {    
    var players: [BaseGamblingPlayer] { get }
    var map: BaseGamblingMap { get }
}
