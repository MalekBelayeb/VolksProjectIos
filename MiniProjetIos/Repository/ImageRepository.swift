//
//  ImageRepository.swift
//  MiniProjetIos
//
//  Created by malek belayeb on 1/11/20.
//  Copyright © 2020 Akthem-Malek. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import AlamofireImage



class ImageRepository
{
    
    
    private static var instance: ImageRepository?

    public static func getInstance() -> ImageRepository{
        if(instance == nil){
            instance = ImageRepository()
        }
        return instance!
    }
    

    func downloadImages(username: String, completionHandler: @escaping (_ image: UIImage) -> ()) {
        
        //222222222222
        /*
        AF.request(Helper.ENDPOINT+"uploads/"+username, method: .get)
            .validate()
            .responseData(completionHandler: { (responseData) in
               
                guard let image = responseData.result.value else {
                             // Handle error
                             return
                }
                    completionHandler(UIImage(data: image)!)
                    
                
            })*/
    }
    
    func getImage(username: String)
    {
        ///333333333333
        /*
        AF.request(Helper.ENDPOINT+"upload/"+username, method: .get).responseImage { response in
            
            print(response)
            
            guard let image = response.result.value else {
                // Handle error
                return
            }
            
            // Do stuff with your image
        }*/
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
    URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) -> UIImage{
        var image: UIImage? = nil
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            DispatchQueue.main.async() {
                image = UIImage(data: data)!
            }
        }
        return image!
    }
    
    
    
    /*
    func addUser(user: User, image: UIImage?, completionHandler: @escaping () -> ()) {
        let url = try! URLRequest(url: URL(string:Helper.ENDPOINT+"upload", method: .post, headers: nil),
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            if image != nil {
                multipartFormData.append(image!.jpegData(compressionQuality: 0.5)!, withName: "image", fileName: "send.png", mimeType: "image/jpg")
            }
            multipartFormData.append((user.username)!.data(using: .utf8)!, withName: "username", mimeType: "text/plain")
            multipartFormData.append((user.email)!.data(using: .utf8)!, withName: "email", mimeType: "text/plain")
            multipartFormData.append((user.password)!.data(using: .utf8)!, withName: "password", mimeType: "text/plain")
        }, with: url, encodingCompletion: { (result) in
            switch result {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    completionHandler()
                    Loader.getInstance().stopLoader()
                }
            case .failure(let encodingError):
                print("",encodingError.localizedDescription)
                Loader.getInstance().stopLoader()
            }
        })
    }
    */
    
    public func uploadImage(img: UIImage,imageName : String,progressView : UIProgressView,uploadButton : UIButton)
    {
        //4444444444
        /*
        let ImageData = img.jpeg(.lowest)
        let urlReq = Helper.ENDPOINT+"upload"
          let parameters = ["user_id": "useridValue"]//you can comment this if not needed

          AF.upload(multipartFormData: { multipartFormData in
              multipartFormData.append(ImageData!, withName: "upload",fileName: imageName+".jpeg", mimeType: "image/jpeg")
              for (key, value) in parameters {// this will loop the 'parameters' value, you can comment this if not needed
                  multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
              }
          },
                           to:urlReq,method: .post)
          { (result) in
              switch result {
              case .success(let upload, _, _):

                  upload.uploadProgress(closure: { (progress) in
                      print("Upload Progress: \(progress.fractionCompleted)")
                  
                    progressView.progress = Float(progress.fractionCompleted)
                    
                    if(progress.fractionCompleted == 1.0)
                    {
                        progressView.isHidden = true
                        uploadButton.isHidden = true
                    }
                  
                  })

                  upload.responseJSON { response in
                      print(response.result.value)
                      if let dic = response.result.value as? NSDictionary{
                          //do your action base on Api Return failed/success
                      }
                  }

              case .failure(let encodingError):
                  print(encodingError)
              }
          }
*/
        
    }
    
    
    public func uploadEventImage(img: UIImage,imageName : String,progressView : UIProgressView,uploadButton : UIButton)
    {
        //5555555
        
        /*
        let ImageData = img.jpeg(.lowest)
        let urlReq = Helper.ENDPOINT+"upload"
          let parameters = ["user_id": "useridValue"]//you can comment this if not needed

          AF.upload(multipartFormData: { multipartFormData in
              multipartFormData.append(ImageData!, withName: "upload",fileName: imageName+".jpeg", mimeType: "image/jpeg")
              for (key, value) in parameters {// this will loop the 'parameters' value, you can comment this if not needed
                  multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
              }
          },
                           to:urlReq,method: .post)
          { (result) in
              switch result {
              case .success(let upload, _, _):

                  upload.uploadProgress(closure: { (progress) in
                      print("Upload Progress: \(progress.fractionCompleted)")
                  
                    progressView.progress = Float(progress.fractionCompleted)
                    
                    if(progress.fractionCompleted == 1.0)
                    {
                        progressView.isHidden = true
                        uploadButton.isHidden = true
                    }
                  
                  })

                  upload.responseJSON { response in
                      print(response.result.value)
                      if let dic = response.result.value as? NSDictionary{
                          //do your action base on Api Return failed/success
                      }
                  }

              case .failure(let encodingError):
                  print(encodingError)
              }
          }

        */
    }
    
    
}
