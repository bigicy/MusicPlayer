//
//  NetWorkTool.swift
//  iOS04MusicPlayer
//
//  Created by SZT on 16/7/22.
//  Copyright © 2016年 SZT. All rights reserved.
//

import UIKit
import AFNetworking

class NetWorkTool: AFHTTPSessionManager {
    
//    定义个单利
    static var shareNetWorkTool:NetWorkTool = {
        let instance = NetWorkTool()
        return instance
    }()
    
//    定义请求的方式
    enum requestMethod:String{
        case get = "GET"
        case post = "POST"
    }
//    定义一个请求成功的回调
    typealias requestClosure = (respondObject:AnyObject?,error:NSError?)->()
    /**
     - parameter method:          请求方式
     - parameter urlString:       请求url
     - parameter parameter:       请求附加的参数
     - parameter requestFinished: 请求成功的回调
     */
    func httpRequest(method:requestMethod,urlString:String,parameter:[String:AnyObject]?,requestFinished:requestClosure){
        
        
//        请求成功与失败闭包的类型具体看GET和POST方法中请求成功与失败的闭包类型
        
//        定义一个请求成功的回调
        let successClosure = {
            (dataTask:NSURLSessionDataTask,respondData:AnyObject?)->()
            in
//            请求成功则respondObject有数据，error肯定没数据，所以给nil
            requestFinished(respondObject: respondData, error: nil)
        }
//        定义一个请求失败的回调
        let failsureClosure = {
            (dataTask:NSURLSessionDataTask?,error:NSError)->()
            in
//            请求失败respondObject肯定没数据，所以给nil，error肯定有数据，所以传递error
            requestFinished(respondObject: nil, error: error)
        }
//        根据请求的方式区分要调用的方法
        if method == .get{
            GET(urlString, parameters: parameter, progress: nil, success: successClosure, failure: failsureClosure)
        }else{
            POST(urlString, parameters: parameter, progress: nil, success: successClosure, failure: failsureClosure)
        }
        
    }
    
    
    
    
    
    
    

}
