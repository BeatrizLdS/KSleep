//
//  SetSceneProtocol.swift
//  KSleep
//
//  Created by Beatriz Leonel da Silva on 11/04/23.
//

import Foundation

protocol SetSceneProtocol {
    func setPosition()
    func addChilds()
    func updateScene()
}

extension SetSceneProtocol {
    func setScene() {
        addChilds()
        setPosition()
        updateScene()
    }
}
