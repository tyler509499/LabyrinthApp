//
//  ViewController.swift
//  LabyrinthApp
//
//  Created by Galkov Nikita on 14.08.2021.
//

import UIKit

class ViewController: UIViewController {
    
    private let startRow = 1, startCol = 0
    private let finishRow = 6, finishCol = 5
    private let m = 7, n = 9
    private let storage: StorageType = Storage()

    private var lab = [
        [1, 1, 1, 1, 1, 1, 1, 1, 1],
        [0, 0, 1, 0, 0, 0, 0, 0, 1],
        [1, 0, 1, 0, 1, 0, 1, 0, 1],
        [1, 0, 0, 0, 1, 0, 1, 0, 1],
        [1, 0, 1, 1, 1, 0, 1, 0, 1],
        [1, 0, 0, 0, 1, 0, 1, 0, 1],
        [1, 1, 1, 0, 0, 0, 0, 0, 1]
    ]
    private var isNoExit: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        storage.reset()
        labirint(row: startRow, col: startCol, source: lab)
        checkNoExit()
        checkRoutes(stepStorage: storage.steps)
    }
    
    private func labirint(row: Int, col: Int, source: [[Int]]) {
        isNoExit = false
        if (row == finishRow && col == finishCol) {
            lab[row][col] = 2
            storage.route.append(lab)
            guard !storage.route.isEmpty else { return }
            print("Выход \(storage.route.count) найден.")
            checkStepsCount(labStorage: storage.route.last!)
            for row in storage.route.last!{
                print("\(row)")
            }
        } else {
            isNoExit = true
        }
        lab[row][col] = 2
        
        // down
        if (row < m - 1 && lab[row + 1][col] == 0) {
            labirint(row: row + 1, col: col, source:  lab)
        }
        
        //right
        if (col < n - 1 && lab[row][col + 1] == 0) {
            labirint(row: row, col: col + 1, source: lab)
        }
        //up
        if (row > 0 && lab[row - 1][col] == 0) {
            labirint(row: row - 1, col: col, source: lab)
        }
        //left
        if (col > 0 && lab[row][col - 1] == 0) {
            labirint(row: row, col: col - 1, source: lab)
        }
        lab[row][col] = 0
    }
    
    private func checkNoExit() {
        if isNoExit && storage.route.isEmpty {
            print("Скоро рассвет. Выхода нет.")
        }
    }
    
    private func checkStepsCount(labStorage: [[Int]]) {
        guard !labStorage.isEmpty else { return }
        var steps: Int = 0
        for route in 0...labStorage.count-1 {
            let routeCount = labStorage[route].filter({ $0 == 2 })
            steps += routeCount.count
        }
        storage.steps.append(steps)
        print ("Длина маршрута составляет \(steps) шагов.")
        }
    
    private func checkRoutes(stepStorage: [Int]) {
        guard !stepStorage.isEmpty else { return }
            var minValue = stepStorage[0]
            var maxValue = stepStorage[0]
            for num in stepStorage {
                minValue = (num  < minValue) ? num : minValue
                maxValue = (num > maxValue) ? num : maxValue
            }
        if stepStorage.count > 1 {
        print("Наименьшую длину имеет маршрут \((stepStorage.firstIndex(of: minValue) ?? 0) + 1), состоящий из \(minValue) шагов.")
        print("Наибольшую длину имеет маршрут \((stepStorage.firstIndex(of: maxValue) ?? 0) + 1), состоящий из \(maxValue) шагов.")
        print("Рекомендуется использовать машрут \((stepStorage.firstIndex(of: minValue) ?? 0) + 1) с целью экономии времени и сил.")
        } else {
            print("Наименьшую длину имеет маршрут \((stepStorage.firstIndex(of: minValue) ?? 0) + 1), состоящий из \(minValue) шагов.")
        }
        
        if stepStorage.count > 2 {
            print("Длина остальных маршрутов находится в диапазоне между длинами \((stepStorage.firstIndex(of: minValue) ?? 0) + 1) и \((stepStorage.firstIndex(of: maxValue) ?? 0) + 1) машрута.")
        }
    }
}

