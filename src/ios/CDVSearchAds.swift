import AdServices

@available(iOS 10.0, *)
@objc(CDVSearchAds) class CDVSearchAds : CDVPlugin {

    fileprivate func sendResult(_ pluginResult : CDVPluginResult, callbackId : String) {
        pluginResult.setKeepCallbackAs(false)

        self.commandDelegate!.send(
            pluginResult,
            callbackId: callbackId
        )
    }

    fileprivate func sendError(message: String, command:CDVInvokedUrlCommand) {
        print(message)
        let pluginResult = CDVPluginResult(
          status : CDVCommandStatus_ERROR,
          messageAs : message
        );
      self.sendResult(pluginResult!, callbackId: command.callbackId!);
    }

    @objc(initialize:)
    func initialize(_ command:CDVInvokedUrlCommand) {
      fetchAttributionData(command: command)
    }

  func fetchAttributionData(command:CDVInvokedUrlCommand) {
      if #available(iOS 14.3, *) {
        if let adAttributionToken = try? AAAttribution.attributionToken() {
            let request = NSMutableURLRequest(url: URL(string:"https://api-adservices.apple.com/api/v1/")!)
            request.httpMethod = "POST"
            request.setValue("text/plain", forHTTPHeaderField: "Content-Type")
            request.httpBody = Data(adAttributionToken.utf8)
            let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
                guard let data = data, error == nil else {
                    self.sendError(message: error?.localizedDescription ?? "No data received", command: command)
                    return
                }
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        do {
                            let jsonResponse = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                            if jsonResponse["campaignId"] is Int {
                                let pluginResult = CDVPluginResult(
                                    status: CDVCommandStatus_OK,
                                    messageAs : jsonResponse
                                )
                                self.sendResult(pluginResult!, callbackId: command.callbackId!);
                            }
                        } catch let error as NSError {
                            self.sendError(message: "Failed to serialise JSON: \(error.localizedDescription)", command: command)
                        }
                    } else if httpResponse.statusCode == 500 {
                        self.sendError(message: "Server error", command: command)
                    }
                }
            }
            task.resume()
        } else {
            self.sendError(message: "No attribution token", command: command)
        }
      } else {
          self.sendError(message: "Unsupported", command: command);
      }
  }
}
