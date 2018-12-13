//
//  SortClass.swift
//  PGQDemo
//
//  Created by Lois_pan on 2018/12/12.
//  Copyright © 2018 Lois_pan. All rights reserved.
//

import Foundation

enum SortTypeEnum: Int {
    case BubbleSort = 0    //冒泡排序
    case SelectSort        //选择
    case InsertSort        //插入排序
    case ShellSort         //希尔排序
    case HeapSort          //堆排序
    case MergeSort         //归并排序
    case QuickSort         //快速排序
    case RadixSort         //基数排序
}

//排序类的简单工厂
class SortFactory {
    static func create(type: SortTypeEnum) -> SortType {
        switch type {
        case .BubbleSort:
            return BubbleSort()
        case .SelectSort:
            return BubbleSort()
        case .InsertSort:
            return BubbleSort()
        case .ShellSort:
            return BubbleSort()
        case .HeapSort:
            return BubbleSort()
        case .MergeSort:
            return BubbleSort()
        case .QuickSort:
            return BubbleSort()
        case .RadixSort:
            return BubbleSort()
        }
    }
}

typealias SortResultClosure = (_ index: Int, _ value: Int) -> Void
typealias SortSuccessClosure = (Array<Int>) -> Void

class SortBaseClass {
    var everyStepClosure: SortResultClosure!
    var sortSuccessClosure: SortSuccessClosure!
    
    func displayResult(index: Int, value: Int) {
        if everyStepClosure != nil {
            everyStepClosure(index, value)
            Thread.sleep(forTimeInterval: 0.001)
        }
    }
    
    func successSort(sortList: Array<Int>) -> Void {
        if sortSuccessClosure != nil {
            sortSuccessClosure(sortList)
        }
    }
    
    func setEveryStepClosure(everyStepClosure: @escaping SortResultClosure,
                             sortSuccessClosure: @escaping SortSuccessClosure) -> Void {
        self.everyStepClosure = everyStepClosure
        self.sortSuccessClosure = sortSuccessClosure
    }
}

//冒泡排序  时间复杂度----O(n^2)
class BubbleSort:SortBaseClass, SortType {
    func sort(items: Array<Int>) -> Array<Int> {
        var list = items
        for i in 0..<list.count {
            for j in 0..<(list.count - 1 - i) {
                if list[j - 1] > list[j] {
                    list.swapAt(j - 1, j)
                    
                    displayResult(index: j, value: list[j])
                    displayResult(index: j - 1, value: list[j - 1])
                }
            }
        }
        self.successSort(sortList: list)
        return list
    }
}

//插入排序
class InsertSort: SortBaseClass, SortType {
    func sort(items: Array<Int>) -> Array<Int> {
        var list = items
        for i in 1..<list.count {
            for j in 1..<i {
                if list[j] < list[j - 1]  {
                    list.swapAt(j - 1, j)
                    displayResult(index: j, value: list[j])
                    displayResult(index: j - 1, value: list[j - 1])
                } else {
                    break
                }
            }
        }
        self.successSort(sortList: list)
        return list
    }
}

//希尔排序 ： 时间复杂度 O(n^(3/2))
class Shell: SortBaseClass, SortType {
    func sort(items: Array<Int>) -> Array<Int> {
        var list = items
        var step: Int = list.count / 2
        while step > 0 {
            for i in 0..<list.count {
                var j = i+step
                while j >= step && j < list.count {
                    if list[j] < list[j - step] {
                        list.swapAt(j - step, j)
                        displayResult(index: j, value: list[j])
                        displayResult(index: j - step, value: list[j - step])
                        j = j - step
                    } else {
                        break
                    }
                }
            }
            step = step / 2     //缩小步长
        }
        self.successSort(sortList: list)
        return list
    }
}

//简单选择排序
class SimpleSelectionSort: SortBaseClass, SortType {
    func sort(items: Array<Int>) -> Array<Int> {
        var list = items
        for i in 0..<list.count {
            var j = i + 1
            var minValue = list[i]
            var minIndex = i
            while j < list.count {
                if minValue > list[j] {
                    minValue = list[j]
                    minIndex = j
                }
                displayResult(index: j, value: list[j])
                j = j + 1
            }
            
            if minIndex != i {
                list.swapAt(i, minIndex)
                displayResult(index: i, value: list[i])
                displayResult(index: minIndex, value: list[minIndex])

            }
        }
        self.successSort(sortList: list)
        return list
    }
}


//快速排序
class QuickSort: SortBaseClass, SortType {
    func sort(items: Array<Int>) -> Array<Int> {
        var list = items
        quickSort(list: &list, low: 0, high: list.count-1)
        self.successSort(sortList: list)
        return list
    }
    
    private func quickSort(list: inout Array<Int>, low: Int, high: Int) {
        if low < high {
            let mid = getMid(list: &Array, low: low, high: high)
            quickSort(list: &Array, low: low, high: mid - 1)
            quickSort(list: &Array, low: mid + 1, high: high)
        }
    }
    
    private func getMid(list: inout Array<Int>, low: Int, high: Int) -> Int {
        var low = low
        var high = high
        var temp = list[low]
        while low < high {
            if low < high && list[high] >= temp {
                high -= 1
            }
            list[low] = list[high]
            displayResult(index: low, value: list[low])

            if low < high && list[low] <= temp {
                low += 1
            }
            list[high] = list[low]
            displayResult(index: low, value: list[low])
        }
        list[low] = temp
        return low
    }
}
