//
//  Array.swift
//  Alien
//
//  Created by Daniel Correia on 26.03.23.
//

import Foundation

func Rearrange<T>(array: Array<T>, fromIndex: Int, toIndex: Int) -> Array<T>{
    var arr = array
    let element = arr.remove(at: fromIndex)
    var newIndex: Int = 0
    newIndex = toIndex < 0 ? 0 : toIndex
    arr.insert(element, at: newIndex)
    return arr
}

func Insert<T>(array: Array<T>, toIndex: Int, element: T) -> Array<T>{
    var arr = array
    arr.insert(element, at: toIndex)
    return arr
}
