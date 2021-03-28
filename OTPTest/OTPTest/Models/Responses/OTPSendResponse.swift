//
//  OTPSendResponse.swift
//  OTPTest
//
//  Created by Aaron Lee on 2021/03/28.
//

import Foundation

struct OTPSendResponse: APIResponse {
    var status: Int
    var success: Bool
    var description: String
    var data: OTPSendResponseData?
}

struct OTPSendResponseData: Decodable {
    var expiresIn: Int
    var mobileNo: String
}
