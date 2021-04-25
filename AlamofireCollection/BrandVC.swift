//
//  ViewController.swift
//  AlamofireCollection
//
//  Created by Farhana Khan on 25/04/21.
//

import UIKit
import Alamofire
import Kingfisher

class BrandVC: UIViewController {
    @IBOutlet var errView: UIView!
    @IBOutlet weak var errLbl: UILabel!
    @IBOutlet weak var errBtn: UIButton!
    @IBOutlet weak var actInd: UIActivityIndicatorView!
    var brandArr = [NSDictionary]()
    @IBOutlet weak var CV: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        actInd.hidesWhenStopped = true
        alamofirePostExample()
    }
    func alamofirePostExample()  {
        let parameter = ["request":"brand_listing","device_type":"ios","country":"india"]
        AF.request("https://www.kalyanmobile.com/apiv1_staging/brand_listing.php",method: .post,parameters: parameter).responseJSON { (resp) in
            if let arr = resp.value as? NSDictionary{
                print("RESPONSE HERE \(arr)")
                if let respCode = arr.value(forKey: "responseCode") as? String, let respMsg = arr.value(forKey: "responseMessage") {
                    if respCode == "success" {
                        self.actInd.stopAnimating()
                        print("success")
                        if let brand = arr.value(forKey: "brand") as? [NSDictionary] {
                            self.brandArr = brand
                            self.CV.backgroundView = nil
                            self.CV.reloadData()
                        }
                        else {
                            print("Err \(respMsg)")
                        }
                    }
                }
            }
            else if let err = resp.error {
                self.actInd.stopAnimating()
                print("Error: \(err.localizedDescription)")
                self.showError(msg: "\(err.localizedDescription)")
            }
        }
    }
    func showError(msg:String) {
        errLbl.text = msg
        CV.backgroundView = errView
    }
    @IBAction func retryPress(_ sender: Any) {
        alamofirePostExample()
    }
}

extension BrandVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return brandArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCVC
        let brandId = brandArr[indexPath.row].value(forKey: "brand_id") as? String ?? ""
        let brandnme = brandArr[indexPath.row].value(forKey: "brand_name") as? String ?? ""
        cell.brandName.text = "Description: \(brandnme)"
        let brand_description = brandArr[indexPath.row].value(forKey: "brand_description") as? String ?? ""
        cell.brandId.text = "Id: \(brandId)"
        cell.brandDesp.text = "Name: \(brand_description)"
        let img = brandArr[indexPath.row].value(forKey: "brand_image_path") as? String ?? ""
        let url = URL(string: "\(img)")
        print(img)
        cell.imgV.kf.setImage(with: url)
        cell.imgV.layer.borderWidth = 4
        cell.imgV.layer.borderColor = UIColor.black.cgColor
        cell.imgV.contentMode = .scaleAspectFit
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //        return CGSize(width: floor((collectionView.frame.size.width-4)/2), height: floor((collectionView.frame.size.height-4)/2))
        return CGSize(width: collectionView.frame.size.width, height:150)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
}
