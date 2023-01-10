//
//  ArticleEntity.swift
//  prac-swift_viper
//
//  Created by Lucas on 2022/12/22.
//

import Foundation

struct ArticleEntity: Codable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
}
