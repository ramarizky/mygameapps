//
//  HomeServices.swift
//  MyGameApps
//
//  Created by Rizky Ramadhan on 19/02/23.
//

import Foundation
import Combine
import Core

public protocol HomeProtocol: AnyObject {
    var networker: NetworkerProtocol { get }
    func getListGames(endPoint : NetworkFactory) -> AnyPublisher<GamesModel, Error>
}

public final class HomeServices: HomeProtocol {
    public var networker: NetworkerProtocol
    public init(networker: NetworkerProtocol = Networker()) {
        self.networker = networker
    }
    public func getListGames(endPoint : NetworkFactory) -> AnyPublisher<GamesModel, Error> {
        return networker.get(type: GamesModel.self, endPoint: endPoint)
    }
}
