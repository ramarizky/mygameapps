//
//  DetailServices.swift
//  MyGameApps
//
//  Created by Rizky Ramadhan on 19/02/23.
//

import Foundation
import Combine

protocol DetailProtocol: AnyObject {
    var networker: NetworkerProtocol { get }
    func getDetailGames(endPoint : NetworkFactory) -> AnyPublisher<DetailGamesModel, Error>
}

final class DetailServices: DetailProtocol {
    var networker: NetworkerProtocol
    init(networker: NetworkerProtocol = Networker()) {
        self.networker = networker
    }
    func getDetailGames(endPoint : NetworkFactory) -> AnyPublisher<DetailGamesModel, Error> {
        return networker.get(type: DetailGamesModel.self, endPoint: endPoint)
    }
}
