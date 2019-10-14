//
//  APIClient.swift
//  PinterestChallenge
//
//  Created by AbdulRehman Warraich on 10/13/19.
//

import UIKit

enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

class APIClient: NSObject {

    static let shared = APIClient()

    let session = URLSession(configuration: .default)


    func getRequest(urlString: String,
                    parameters : [String : AnyObject]?,
                    httpMethod: HTTPMethod = .post,
                    completionBlock: @escaping (_ success: Bool, _ result: Any?) -> ()) {

        guard let requestURL = URL(string: urlString) else { return }

        if let cachedItemData = CacheManager.shared.getItem(url: requestURL.absoluteString) {
            print("Fetched data from CACHED \(requestURL.absoluteString)")
            completionBlock(true, cachedItemData)

        } else {

            var request = URLRequest(url: requestURL)
            request.httpMethod = httpMethod.rawValue

            let jsonData = try? JSONSerialization.data(withJSONObject: parameters ?? [])

            if let _jsonData = jsonData {
                request.httpBody = _jsonData
            }

            let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in

                DispatchQueue.main.async {

                    if let data = data ,
                        let response = response as? HTTPURLResponse,
                        response.statusCode == 200 {

                        self.showRequestDetailForSuccess(responseObject: response)
                        CacheManager.shared.set(url: requestURL.absoluteString, item: data)
                        completionBlock(true, data)
                    } else {
                        if let response = response as? HTTPURLResponse,
                            let error = error as NSError? {
                            self.showRequestDetailForFailure(responseObject: response , error: error)
                        }

                        completionBlock(false, error)
                    }
                }

            })
            dataTask.resume()
        }
    }

    func requestJSON(urlString: String,
                     parameters : [String : AnyObject]?,
                     httpMethod: HTTPMethod = .post,
                     completionBlock: @escaping (_ success: Bool, _ result: Any?) -> ()) {

        self.getRequest(urlString: urlString, parameters: parameters, httpMethod: httpMethod) { (isSucess, data) in

            if isSucess,
                let dataObject = data as? Data ,
                let json = try? JSONSerialization.jsonObject(with: dataObject, options: []) {

                completionBlock(true, json)

            } else {

                completionBlock(false, data)
            }
        }
    }

    func loadImage(urlString: String,
                   completionBlock: @escaping (_ success: Bool, _ result: Any?) -> ()) {


        guard let requestURL = URL(string: urlString) else { return }

        if let cachedItemData = CacheManager.shared.getItem(url: requestURL.absoluteString),
            let image = UIImage(data: cachedItemData) {

            print("Image fetched data from CACHED \(requestURL.absoluteString)")
            completionBlock(true, image)

        } else {
            session.dataTask(with: requestURL, completionHandler: { (data, response, error) in

                DispatchQueue.main.async {

                    if let data = data ,
                        let response = response as? HTTPURLResponse,
                        response.statusCode == 200,
                        let image = UIImage(data: data) {

                        self.showRequestDetailForSuccess(responseObject: response)
                        CacheManager.shared.set(url: requestURL.absoluteString, item: data)
                        completionBlock(true, image)

                    } else {
                        if let response = response as? HTTPURLResponse,
                            let error = error as NSError? {
                            self.showRequestDetailForFailure(responseObject: response , error: error)
                        }

                        completionBlock(false, error)
                    }
                }
            }).resume()
        }
    }

    func showRequestDetailForSuccess(responseObject response : HTTPURLResponse?) {

        #if DEBUG
        var logString :String = ""
        logString = "\n\n\n✅✅✅ ------- Success Response Start ------- ✅✅✅ \n"
        logString += ""+(response?.url?.absoluteString ?? "")
        logString += "\n✅✅✅ ------- Success Response End ------- ✅✅✅ \n\n\n"

        print(logString)
        #endif
    }

    func showRequestDetailForFailure(responseObject response : HTTPURLResponse?, error:NSError) {

        #if DEBUG
        var logString :String = ""
        logString = "\n\n\n❌❌❌❌ ------- Failure Response Start ------- ❌❌❌❌\n"
        logString += ""+(response?.url?.absoluteString ?? "")
        logString += "\n=========   Error   ========== \n" + error.description
        logString += "\n❌❌❌❌ ------- Failure Response End ------- ❌❌❌❌\n\n\n"

        print(logString)
        #endif

    }

}
