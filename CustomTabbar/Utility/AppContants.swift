//
//  AppContants.swift
//  CustomTabbar
//
//  Created by Thuannv on 4/5/19.
//  Copyright © 2019 Thuannv. All rights reserved.
//

import Foundation

struct AppContants {
    static let primaryColor = 0x243B6B
    static let secondaryColor = 0xFFE6E6
    static let backgroundColor = 0xFFEEEE
    static let textTaskCompletedColor = 0x243B6B
    static let textTaskColor = 0x104F8A
    static let fontTitle: String = "Avenir-Black"
}

internal enum DatabaseChange {
    case delete
    case insert
    case modify
}
