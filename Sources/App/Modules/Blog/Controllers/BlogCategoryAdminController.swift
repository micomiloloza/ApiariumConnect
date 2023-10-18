//
//  BlogCategoryAdminController.swift
//
//
//  Created by Mico Miloloza on 12.10.2023..
//

import Vapor
import Fluent


struct BlogCategoryAdminController: AdminListController, AdminDetailController {
    typealias DatabaseModel = BlogCategoryModel
    
    var modelName: Name = .init(singular: "category", plural: "categories")
    var parameterId: String = "categoryId"
    
    func listColumns() -> [ColumnContext] {
        [
            .init(key: "title")
        ]
    }
    
    func listCells(for model: BlogCategoryModel) -> [CellContext] {
        [
            .init(value: model.title, link: .init(label: model.title))
        ]
    }
    
    func detailFields(for model: DatabaseModel) -> [DetailContext] {
        [
            .init("title", model.title)
        ]
    }
}
