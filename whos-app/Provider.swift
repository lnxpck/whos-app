//
//  Provider.swift
//  whos-app
//
//  Created by PATRICK LESAINT on 17/10/2019.
//  Copyright © 2019 PATRICK LESAINT. All rights reserved.
//

import Moya

func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data // fallback to original data if it can't be serialized.
    }
}

#if DEBUG
//print("setup plugins in debug mode....")
let plugins: [PluginType] = [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)]
#else
let plugins: [PluginType] = []
#endif

//let userProvider = MoyaProvider<UserNetwork>(stubClosure: MoyaProvider.immediatelyStub, plugins: plugins)

let userProvider = MoyaProvider<UserNetwork>(plugins: plugins)
