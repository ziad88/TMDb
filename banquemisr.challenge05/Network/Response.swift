//
//  Response.swift
//  banquemisr.challenge05
//
//  Created by mac on 28/08/2024.
//

import Foundation
import UIKit

struct DataResponse<T> {
    let data: T?
    let error: Error?
    var isSuccess : Bool = false
}
