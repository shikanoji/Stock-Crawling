//
//  File.swift
//  
//
//  Created by Nguyen Dinh Thach on 19/05/2022.
//

import Foundation

final class StockHelper {
    static var shared = StockHelper()
    func filterHammerCandle(stocks: [Stock]) -> [Stock]{
        var filterList: [Stock] = []
        for stock in stocks {
            guard [stock.close, stock.lowest, stock.open, stock.highest].filter { $0 == 0 }.isEmpty,
                stock.volume > 100000 else {
                continue
            }
            if stock.close == stock.highest,
               (stock.open - stock.lowest)/(stock.close - stock.open) >= 3,
               stock.reference > stock.open {
                filterList.append(stock)
            }
        }
        return filterList
    }
}
