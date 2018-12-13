//
//  Sort.swift
//  PGQDemo
//
//  Created by Lois_pan on 2018/12/12.
//  Copyright © 2018 Lois_pan. All rights reserved.
//

import Foundation

protocol SortType {
    func sort(items: Array<Int>) -> Array<Int>
    func setEveryStepClosure(everyStepClosure: @escaping SortResultClosure,
                             sortSuccessClosure: @escaping SortSuccessClosure) -> Void
    
}
