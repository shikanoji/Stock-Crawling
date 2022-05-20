//
//  File.swift
//  
//
//  Created by Nguyen Dinh Thach on 17/05/2022.
//

import Foundation
import Vapor

struct Stock: Content {
    init(code: String, open: Float, close: Float, highest: Float, lowest: Float, changeRate: Float, reference: Float, volume: Int) {
        self.code = code
        self.open = open
        self.close = close
        self.highest = highest
        self.lowest = lowest
        self.changeRate = changeRate
        self.reference = reference
        self.volume = volume
    }
    
    static func generate(withData data: [String]) -> Stock? {
        guard data.count > 1 else { return  nil}
        let code = data[1]
        guard code.count == 3 else { return nil }
        let reference = data.count > 4 ? data[4].floatValue : 0
        let close = data.count > 5 ? data[5].floatValue : 0
        let changeRateString = data.count > 8 ? data[8] : "0"
        let changeRate = String(changeRateString.dropLast()).floatValue
        let volume = data.count > 9 ? Int(data[9].filter("0123456789.".contains)) : 0
        let open = data.count > 12 ? data[13].floatValue : 0
        let highest = data.count > 13 ? data[14].floatValue : 0
        let lowest = data.count > 14 ? data[15].floatValue : 0
        return Stock(code: code, open: open, close: close, highest: highest, lowest: lowest, changeRate: changeRate, reference: reference, volume: volume ?? 0)
    }
    
    var code: String
    var open: Float
    var close: Float
    var highest: Float
    var lowest: Float
    var changeRate: Float
    var reference: Float
    var volume: Int
}

extension String {
    var floatValue: Float {
        return round((self as NSString).floatValue * 100) / 100
    }
}
