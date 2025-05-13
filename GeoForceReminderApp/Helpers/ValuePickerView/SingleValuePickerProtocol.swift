//
//  DatePickerProtocol.swift
//  imagePickerTask
//
//  Created by Usama on 25/10/2018.
//  Copyright © 2018 Usama. All rights reserved.
//

import Foundation

protocol SingleValuePickerProtocol{
    func userSelected(valueIndex: Int, unitIndex: Int?, tag: String?)
    func userMultipleSelected(valuesIndexes: Array<Int>, unitIndexes: Array<Int>?, tag: String?)
}
