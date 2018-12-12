//
//  AlgorithmSwiftViewController.swift
//  PGQDemo
//
//  Created by Lois_pan on 2018/8/24.
//  Copyright © 2018年 Lois_pan. All rights reserved.
//

import UIKit

public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}


public class ListNode {
    public var val: Int = 0
    public var next: ListNode?
    
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

class AlgorithmSwiftViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        print(solution(s: "skjhekajhkjhskd"))
//        test(n: 10)
    }
    
//    func test(n: Int) {
//        for j in 2..<n.map{$0 * 2} {
//            j *= 2;
//            print(j)
//        }
//    }
    
//    func findMin(_ root: TreeNode?) -> TreeNode? {
//    
//    }
    
    
    //翻转二叉树
    func invertTree(_ root: TreeNode?) -> TreeNode? {
        if root == nil {
            return nil
        }
        
        root?.left = invertTree(root?.left)
        root?.right = invertTree(root?.right)
        
        let tmp = root?.left
        root?.left = root?.right
        root?.right = tmp
        
        return root
    }
    
    var head: ListNode?
    var tail: ListNode?

    //尾插法
    func appendToTail(_ val: Int) {
        if tail == nil {
            tail = ListNode(val)
            head = nil
        } else {
            tail?.next = ListNode(val)
            tail = tail?.next
        }
    }
    
    //头插法
    func addpendToHeade(_ val: Int) {
        if head == nil {
            head = ListNode(val)
            tail = head
        } else {
            let tmp = ListNode(val)
            tmp.next = head
            head = tmp
            
        }
    }
    
    
//    func solution(s:String) -> Int {
//
//        var resultS: String!
//        let lengthOfLongestSubstring = 0
//        var arrNums = [Int]()
////        arrNums.append(1)
////        print(arrNums)
//
//        let ans = 0
//        let i = 0
//        let j = 0
//
//        let n = s.count
//
//        while i < n  && j < n {
//        }
//        return ans
//    }
    
    
}
