//
//  Post.swift
//  Reddit
//
//  Created by Mackenzie Wacker on 12/23/22.
// https://www.reddit.com/r/funny.json

import Foundation

struct TopLevelObject {
    let data: SecondLevelObject
}

struct SecondLevelObject {
    let children: [ThirdLevelObject]
}

struct ThirdLevelObject {
    let data: Post
}

struct Post {
    let title: String
    let ups: Int
    let thumbnail: String //
}
