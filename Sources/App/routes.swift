import Fluent
import Vapor
import SwiftHtml


func routes(_ app: Application) throws {
    app.get { req async in
        req.templates.renderHtml(
            WebIndexTemplate(.init(title: "Home page"), {
                Div {
                    H1("Web Index Template")
                }
            })
        )
    }
}
