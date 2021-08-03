//
//  Helpers.swift
//  MVVMExample
//
//  Created by Raphael Martin on 03/08/21.
//

import Foundation

func dispatch(after timeout: Double, _ execute: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + timeout, execute: execute)
}

func randomString(length: Int) -> String {
    let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    return String((0..<length).map{ _ in letters.randomElement()! })
}
