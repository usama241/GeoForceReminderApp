//
//  DatePickerProtocol.swift
//  imagePickerTask
//
//  Created by Usama on 25/10/2018.
//  Copyright © 2018 Usama. All rights reserved.
//

import Foundation

struct SingleValuePickerConfiguration {
    
    var title: String
    var imageName: String
    var description: String?
    var values: [String]
    var units: [String]? = nil
    var selectedValueIndex: Int = 0
    var selectedUnitIndex: Int = 0
    var allowMultipleSelection: Bool = false
    
}
