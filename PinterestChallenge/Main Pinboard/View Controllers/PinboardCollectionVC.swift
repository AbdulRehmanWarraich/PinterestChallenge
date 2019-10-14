//
//  PinboardCollectionVC.swift
//  PinterestChallenge
//
//  Created by AbdulRehman Warraich on 10/13/19.
//

import UIKit
import ObjectMapper

private let reuseIdentifier = "PhotoCellID"

class PinboardCollectionVC: UICollectionViewController {

    //MARK:- Properties
    private var pinboards : [PinboardModel]? = []
    private var refreshControl = UIRefreshControl()

    //MARK:- Controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        if let layout = collectionView.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)

        refreshControl.addTarget(self, action: #selector(pullToRefresh(sender:)), for: .valueChanged)
        self.collectionView.refreshControl = refreshControl

        /* set max number objects which will be cached */
        CacheManager.shared.updateMaxLimt(30)

        /* set time interval to check and release above limit memory */
        CacheManager.shared.validateCacheSize(after: 20)

        /* calls API to load information */
        getPinboardInfo()
    }

    //MARK:- Function
    @objc func pullToRefresh(sender:UIRefreshControl) {
        getPinboardInfo()
    }

    func relaodPinboard(with data:[PinboardModel]?) {

        pinboards = data
        self.collectionView.reloadData()
    }
}

//MARK:- UICollectionView Delegate and DataSource
extension PinboardCollectionVC {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return pinboards?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? PhotoCell,
            let aPinboards = pinboards?[indexPath.item]{

            cell.userNameLabel.text = aPinboards.user?.name
            cell.imageView.loadImage(urlString: aPinboards.urls?.regular ?? "")

            return cell
        }

        return UICollectionViewCell()
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "PinboardDetailVC") as? PinboardDetailVC,
            let aPinboards = pinboards?[indexPath.item] {

            detailVC.aPinInfo = aPinboards
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}


//MARK:- CollectionView custom layout delegate
extension PinboardCollectionVC: PinterestLayoutDelegate {

    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {

        return scaleImageHeight(rawHeight: pinboards?[indexPath.item].height ?? 0)
    }

    private func scaleImageHeight(rawHeight: Int) -> CGFloat {
        return CGFloat(rawHeight) * 0.10
    }
}

//MARK:- API calls
extension PinboardCollectionVC {

    func getPinboardInfo(){

        ActivityIndicator.shared.showActivityIndicator()

        APIClient.shared.requestJSON(urlString: Constants.baseURL, parameters: nil) { [weak self] (isSuccess, result) in

            ActivityIndicator.shared.hideActivityIndicator()
            self?.refreshControl.endRefreshing()

            if isSuccess,
                let data = Mapper<PinboardModel>().mapArray(JSONObject: result) {

                self?.relaodPinboard(with: data)

            } else {
                
                var errorMessage :String = "Loading pinboard failed. Please try again."
                if let error = result as? NSError {
                    errorMessage = error.localizedDescription
                }
                self?.showAlert("Error", message: errorMessage)
            }
        }
    }
}
