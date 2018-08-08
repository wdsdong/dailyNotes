//
//  SimplifyPath.swift
//  算法整理
//
//  Created by wds on 2018/7/30.
//  Copyright © 2018年 wdsdong. All rights reserved.
//

import UIKit

class SimplifyPath {

    func simplifyPath(path: String) -> String {
        //用数组来实现栈的功能
        var pathStack = [String]()
        //拆分原路径
        let paths = path.components(separatedBy: "/")
        
        for path in paths {
            //对于“.”我们直接跳过
            guard path != "." else {
                continue
            }
            //对于".."使用 pop 操作
            if path == ".." {
                if pathStack.count > 0 {
                    pathStack.removeLast()
                }
            } else if path != "" {
                pathStack.append(path)
            }
        }
        //将栈中的内容转化为优化后的新路径
        let res = pathStack.reduce(""){ total, dir in "\(total)/\(dir)" }
        
        //注意空路径的结果是"/"
        return res.isEmpty ? "/" : res
    }
    
    
    
}
