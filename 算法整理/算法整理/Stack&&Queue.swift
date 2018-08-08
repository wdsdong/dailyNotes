//
//  Stack&&Queue.swift
//  算法整理
//
//  Created by wds on 2018/7/30.
//  Copyright © 2018年 wdsdong. All rights reserved.
//

struct MyQueue {
    var stackA: IntegerStack
    var stackB: IntegerStack
    
    var isEmpty: Bool {
        return stackA.isEmpty && stackB.isEmpty
    }
    
    var size: Int {
        return stackA.size + stackB.size
    }
    
    var peek: Int? {
        mutating get {
            shift()
            return stackB.peek
        }
    }
    
    init() {
        stackA = IntegerStack()
        stackB = IntegerStack()
    }
    
    mutating func enqueue(object: Int) {
        stackA.push(object)
    }
    
    mutating func dequeue() -> Int? {
        shift()
        return stackB.pop()
    }
    
    fileprivate mutating func shift() {
        if stackB.isEmpty {
            while !stackA.isEmpty {
                stackB.push(stackA.pop()!)
            }
            
        }
    }
}

struct MyStack {
    var queueA: IntegerQueue
    var queueB: IntegerQueue
    
    init() {
        queueA = IntegerQueue()
        queueB = IntegerQueue()
    }
    
    var isEmpty: Bool {
        return queueA.isEmpty && queueB.isEmpty
    }
    
    var size: Int {
        return queueA.size
    }
    
    var peek: Int? {
        mutating get {
            let peekObj = queueA.peek
            queueB.enqueue(queueA.dequeue()!)
            swap()
            return peekObj
        }
    }
    
    mutating func push(object: Int) {
        queueA.enqueue(object)
    }
    
    mutating func pop() -> Int? {
        shift()
        let popObject = queueA.dequeue()
        swap()
        return popObject
    }
    
    private mutating func shift() {
        while queueA.size != 1 {
            queueB.enqueue(queueA.dequeue()!)
        }
    }
    
    private mutating func swap() {
        (queueA, queueB) = (queueB, queueA)
    }
    
    
}














