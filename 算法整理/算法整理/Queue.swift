//
//  Queue.swift
//  算法整理
//
//  Created by wds on 2018/7/30.
//  Copyright © 2018年 wdsdong. All rights reserved.
//

protocol Queue {
    //持有的元素类型
    associatedtype Element
    
    //是否为空
    var isEmpty: Bool { get }
    //队列大小
    var size: Int { get }
    //队首元素
    var peek: Element? { get }
    
    //入队
    mutating func enqueue(_ newElement: Element)
    //出队
    mutating func dequeue() -> Element?
}

struct IntegerQueue: Queue {
    typealias Element = Int
    
    private var left = [Element]()
    private var right = [Element]()
    
    var isEmpty: Bool { return left.isEmpty && right.isEmpty}
    var size: Int { return left.count + right.count }
    var peek: Element? { return left.isEmpty ? right.first : left.last}
    
    mutating func enqueue(_ newElement: Int) {
        right.append(newElement)
    }
    
    mutating func dequeue() -> Int? {
        if left.isEmpty {
            left = right.reversed()
            right.removeAll()
        }
        return left.popLast()
    }
    
}
