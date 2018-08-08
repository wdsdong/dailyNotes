//
//  Stack.swift
//  算法整理
//
//  Created by wds on 2018/7/30.
//  Copyright © 2018年 wdsdong. All rights reserved.
//

protocol Stack {
    //持有的元素类型
    associatedtype Element
    
    //是否为空
    var isEmpty: Bool { get }
    //栈的大小
    var size: Int { get }
    //栈顶元素
    var peek: Element? { get }
    
    //进栈
    mutating func push(_ newElement: Element)
    
    //出栈
    mutating func pop() -> Element?
    
}

struct IntegerStack: Stack {
    typealias Element = Int
    
    private var stack = [Element]()
    var isEmpty: Bool { return stack.isEmpty }
    var size: Int { return stack.count }
    var peek: Element? { return stack.last }
    
    mutating func push(_ newElement: Int) {
        stack.append(newElement)
    }
    
    mutating func pop() -> Int? {
        return stack.popLast()
    }
    
}


