//
//  HomeServices.swift
//  MyGameApps
//
//  Created by Rizky Ramadhan on 19/02/23.
//

import Foundation
import Combine

protocol HomeProtocol: AnyObject {
    var networker: NetworkerProtocol { get }
    func getListGames(endPoint : NetworkFactory) -> AnyPublisher<GamesModel, Error>
}

final class HomeServices: HomeProtocol {
    var networker: NetworkerProtocol
    init(networker: NetworkerProtocol = Networker()) {
        self.networker = networker
    }
    func getListGames(endPoint : NetworkFactory) -> AnyPublisher<GamesModel, Error> {
        return networker.get(type: GamesModel.self, endPoint: endPoint)
    }
}
