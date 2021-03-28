//
//  APIResponse.swift
//  OTPTest
//
//  Created by Aaron Lee on 2021/03/28.
//

import Foundation

protocol APIResponse: Decodable {
    
    associatedtype DataType: Decodable
    
    var status: Int { get }
    var success: Bool { get }
    var description: String { get }
    var data: DataType? { get }
}
