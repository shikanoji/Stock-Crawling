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
            guard isStockActive(stock: stock) else {
                continue
            }
            if (stock.highest - stock.close) <= (stock.open - stock.lowest) / 2,
               (stock.open - stock.lowest)/(stock.close - stock.open) >= 1.5,
               stock.reference >= stock.open {
                filterList.append(stock)
            }
        }
        return filterList
    }
    
    func filterRevertedHammerCandle(stocks: [Stock]) -> [Stock] {
        var filterList: [Stock] = []
        for stock in stocks {
            guard isStockActive(stock: stock) else {
                continue
            }
            if (stock.close - stock.lowest) <= (stock.highest - stock.open)/2,
               (stock.highest - stock.open)/(stock.open - stock.close) >= 1.5,
               stock.reference <= stock.close {
                filterList.append(stock)
            }
        }
        return filterList
    }
    
    private func isStockActive(stock: Stock) -> Bool {
        guard [stock.close, stock.lowest, stock.open, stock.highest].filter({ $0 == 0 }).isEmpty,
              stock.volume > 500000 else {
            return false
        }
        guard stock.open != stock.close else {
            return false
        }
        return true
    }
    
}
