//
//  StockCrawler.swift
//  
//
//  Created by Nguyen Dinh Thach on 19/05/2022.
//

import Foundation
import Vapor
import SwiftSoup

class StockCrawler {
    static var share = StockCrawler()
    
    let hoseURL = "https://www.cophieu68.vn/stockdaily.php?stcid=1&submit=Go"
    let hnxURL = "https://www.cophieu68.vn/stockdaily.php?stcid=2&submit=Go"
    let upcomURL = "https://www.cophieu68.vn/stockdaily.php?stcid=3&submit=Go"
    
    func crawlStocks(fromURL url: String) async -> [Stock] {
        guard let url = URL(string: url) else { return [] }
        guard let html = try? String(contentsOf: url, encoding: .utf8) else { return [] }
        guard let doc: Document = try? SwiftSoup.parse(html) else {
            return []
        }
        var stocks: [Stock] = []
        for row in try! doc.select("table[width=\"100%\"] tr") {
            var cols: [String] = []
            for col in try! row.select("td") {
                let colContent = try! col.text()
                cols.append(colContent)
            }
            if let stock = Stock.generate(withData: cols) {
                stocks.append(stock)
            }
        }
        return stocks
    }
    
    func getStocks() async -> [Stock] {
        return await crawlStocks(fromURL: hoseURL) + crawlStocks(fromURL: hnxURL) + crawlStocks(fromURL: upcomURL)
    }
}
