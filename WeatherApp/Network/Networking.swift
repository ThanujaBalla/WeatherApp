//
//  Networking.swift
//  WeatherApp
//
//  Created by rentamac on 1/26/26.
//
import Foundation

protocol Networking {
func request<T: Decodable>(
endpoint: APIEndpoint,
responseType: T.Type
) async throws -> T
}
