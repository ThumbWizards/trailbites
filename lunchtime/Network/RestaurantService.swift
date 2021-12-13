//
//  RestaurantAPI.swift
//  lunchtime
//
//  Created by Mark Perkins on 12/12/21.
//

import Foundation

enum RestaurantSearchError: Error {
    case unknown(Error)
    case failedToParse
}

protocol RestaurantService {
    func searchRestaurants(searchParameters: RestaurantSearchParameters, completion: @escaping (Result<RestaurantSearchResponse, RestaurantSearchError>) -> Void)
}

class RestaurantSearch: RestaurantService {

    lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        configuration.urlCache = nil
        return URLSession(configuration: configuration)
    }()

    func searchRestaurants(searchParameters: RestaurantSearchParameters, completion: @escaping (Result<RestaurantSearchResponse, RestaurantSearchError>) -> Void) {

        guard let url = buildRequestURL(searchParameters: searchParameters) else {
            return
        }

        let request = URLRequest(url: url)

        session.dataTask(with: request) { data, request, error in

            if let data = data, let response = try? data.decoded() as NearbyResponse {

                let searchResponse = RestaurantSearchResponse(restaurants: response.results)
                DispatchQueue.main.async {
                    completion(.success(searchResponse))
                }
                return
            }

            if let error = error {
                completion(.failure(.unknown(error)))
                return
            }

            DispatchQueue.main.async {
                completion(.failure(.failedToParse))
                return
            }

        }.resume()
    }

    func buildRequestURL(searchParameters: RestaurantSearchParameters) -> URL? {

        var urlBuilder = Constants.Network.apiBaseURL
        urlBuilder += "location=\(searchParameters.location.latitude),\(searchParameters.location.longitude)"
        urlBuilder += "&radius=\(searchParameters.distanceInMeters)"
        urlBuilder += "&types=restaurant"

        if !searchParameters.searchKeyword.isEmpty {
            urlBuilder += "&keyword=\(searchParameters.searchKeyword)"
        }

        urlBuilder += "&key=AIzaSyDue_S6t9ybh_NqaeOJDkr1KC9a2ycUYuE"

        print("\(urlBuilder)")
        if let url = URL(string: urlBuilder) {
            return url
        }
        return nil
    }
}
