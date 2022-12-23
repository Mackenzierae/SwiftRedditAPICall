//
//  Post.swift
//  Reddit
//
//  Created by Mackenzie Wacker on 12/23/22.
// https://www.reddit.com/r/funny.json

import Foundation

struct TopLevelObject: Codable {
    let data: SecondLevelObject
}

struct SecondLevelObject: Codable {
    let children: [ThirdLevelObject]
}

struct ThirdLevelObject: Codable {
    let data: Post
}

struct Post: Codable {
    let title: String
    let ups: Int
    let thumbnail: String //
}
