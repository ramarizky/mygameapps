//
//  DetailServices.swift
//  MyGameApps
//
//  Created by Rizky Ramadhan on 19/02/23.
//

import Foundation
import Combine
import Core

public protocol DetailProtocol: AnyObject {
    var networker: NetworkerProtocol { get }
    func getDetailGames(endPoint : NetworkFactory) -> AnyPublisher<DetailGamesModel, Error>
}

public final class DetailServices: DetailProtocol {
    public var networker: NetworkerProtocol
    public init(networker: NetworkerProtocol = Networker()) {
        self.networker = networker
    }
    public func getDetailGames(endPoint : NetworkFactory) -> AnyPublisher<DetailGamesModel, Error> {
        return networker.get(type: DetailGamesModel.self, endPoint: endPoint)
    }
}
