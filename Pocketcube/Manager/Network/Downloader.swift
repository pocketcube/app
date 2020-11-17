//
//  Downloader.swift
//  Pocketcube
//
//  Created by Miguel Pimentel on 14/11/20.
//

import UIKit

class Downloader {

    static func download(_ viewController: UIViewController) {
        let fileName = "Teste - \(arc4random()).csv"
        let documentsUrl: URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let destinationFileUrl = documentsUrl.appendingPathComponent("\(fileName)")
        let fileURL = URL(string: "http://0.0.0.0:5000/download")
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        let request = URLRequest(url:fileURL!)
        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            if let tempLocalUrl = tempLocalUrl, error == nil {
                // Success
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    print("Successfully downloaded. Status code: \(statusCode)")
                }
                do {
                    try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
                    do {
                        let contents  = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
                        for indexx in 0..<contents.count {
                            if contents[indexx].lastPathComponent == destinationFileUrl.lastPathComponent {
                                DispatchQueue.main.async {
                                    let avc = UIActivityViewController(activityItems: [contents[indexx]], applicationActivities: nil)
                                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone ) {
                                        viewController.present(avc, animated: true, completion: nil)
                                    } else {
                                        let popoverCntlr = UIPopoverController(contentViewController: avc)
                                        popoverCntlr.present(from: CGRect(x: 982.0, y: 132.0, width: 0, height: 0),  in: viewController.view, permittedArrowDirections: UIPopoverArrowDirection.any, animated: true)
                                    }
                                }
                            }
                        }
                    }  catch (let err) {
                        print("error: \(err)")
                    }
                } catch (let writeError) {
                    print("Error creating a file \(destinationFileUrl) : \(writeError)")
                }
            } else {
                print("Error took place while downloading a file. Error description: \(error?.localizedDescription ?? "")")
            }
        }

        task.resume()
    }
}
