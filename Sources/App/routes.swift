import Vapor
import SwiftSoup

func routes(_ app: Application) throws {
    app.get { req -> [Stock] in
        let stocks = await StockCrawler.share.getStocks()
        return StockHelper.shared.filterHammerCandle(stocks: stocks)
    }
}
