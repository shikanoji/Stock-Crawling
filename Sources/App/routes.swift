import Vapor
import SwiftSoup

func routes(_ app: Application) throws {
    app.get("hammer") { req -> [Stock] in
        let stocks = await StockCrawler.share.getStocks()
        return StockHelper.shared.filterHammerCandle(stocks: stocks)
    }
    
    app.get("inverted-hammer") { req -> [Stock] in
        let stocks = await StockCrawler.share.getStocks()
        return StockHelper.shared.filterRevertedHammerCandle(stocks: stocks)
    }
}
