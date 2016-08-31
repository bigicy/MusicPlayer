//
//  CategoryCollectionViewController.swift
//  iOS04MusicPlayer
//
//  Created by 黄兵 on 16/7/27.
//  Copyright © 2016年 SZT. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CategoryCollectionViewController: UICollectionViewController {
    lazy var hotSingerArray:[CategoryHotSingerModel] = {
        var hotSingerArray = [CategoryHotSingerModel]()
        return hotSingerArray
    }()
    lazy var activityArray:[CategoryActivityModel] = {
         var activityArray = [CategoryActivityModel]()
         return activityArray
    }()
    lazy var moodArray:[CategoryActivityModel] = {
        var moodArray = [CategoryActivityModel]()
        return moodArray
    }()
    lazy var themeArray:[CategoryActivityModel] = {
        var themeArray = [CategoryActivityModel]()
        return themeArray
    }()
    lazy var languageArray:[CategoryActivityModel] = {
        var languageArray = [CategoryActivityModel]()
        return languageArray
    }()
    lazy var timesArray:[CategoryActivityModel] = {
        var timesArray = [CategoryActivityModel]()
        return timesArray
    }()
    lazy var MusicStyleArray:[CategoryActivityModel] = {
        var MusicStyleArray = [CategoryActivityModel]()
        return MusicStyleArray
    }()
    let categoryHotSingerCell = "categoryHotSingerCell"
    let categoryHotSingerHeaderCell = "categoryHotSingerHeaderCell"
    let categoryHotSingerFooterCell = "categoryHotSingerFooterCell"
    let categoryActivityCell = "categoryActivityCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        addHotSingers()
        addAvtivitys()
//        addSearchView()
        collectionView!.backgroundColor = UIColor.clearColor()
        
//        let blurStyle = UIBlurEffect(style: .Dark)
//        let blurView = UIVisualEffectView(effect: blurStyle)
//        blurView.frame = UIScreen.mainScreen().bounds
//        collectionView?.backgroundView = blurView
        
//        模糊效果 .毛玻璃
        let imgV = UIImageView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
        imgV.image = UIImage(named: "方向.jpg")
        view.insertSubview(imgV, atIndex: 0)
        let toolBar = UIToolbar(frame: imgV.frame)
        toolBar.barStyle = .BlackTranslucent
        imgV.addSubview(toolBar)
        
        collectionView?.registerNib(UINib(nibName: "CategoryHotSingerCell",bundle: NSBundle.mainBundle()),forCellWithReuseIdentifier: categoryHotSingerCell)
        collectionView?.registerNib(UINib(nibName: "CategoryHotSingerHeaderCell", bundle: NSBundle.mainBundle()), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: categoryHotSingerHeaderCell)
         collectionView?.registerNib(UINib(nibName: "CategoryHotSingerFooterCell", bundle: NSBundle.mainBundle()), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: categoryHotSingerFooterCell)
        
        collectionView?.registerNib(UINib(nibName: "CategoryActivityCell",bundle: NSBundle.mainBundle()), forCellWithReuseIdentifier: categoryActivityCell)
        
        }

    func addHotSingers(){
        NetWorkTool.shareNetWorkTool.httpRequest(.get, urlString: categoryHotSingerUrl, parameter: nil) { (respondObject, error) in
            guard let receiveData = respondObject else{
                print("网络差")
                return
            }
            for dict in receiveData["artist"] as! [[String:AnyObject]]{
                let model = CategoryHotSingerModel(dict: dict)
                self.hotSingerArray.append(model)
            }
            dispatch_async(dispatch_get_main_queue(), { 
                self.collectionView?.reloadData()
            })
        }
    }
      func addAvtivitys(){
        for i in 0...6 {
         let categoryListUrl: String = NSString(format: categoryBigListUrl, i) as String
        NetWorkTool.shareNetWorkTool.httpRequest(.get, urlString: categoryListUrl , parameter: nil) { (respondObject, error) in
            guard let receiveData = respondObject else{
                print("数据解析错误")
                return
            }
            for dict in receiveData["result"] as! [[String:AnyObject]]{
                let model = CategoryActivityModel(dict: dict)
                switch i {
                case 0:
                    self.activityArray.append(model)
                case 1:
                    self.themeArray.append(model)
                case 3:
                    self.moodArray.append(model)
                case 4:
                    self.languageArray.append(model)
                case 5:
                    self.timesArray.append(model)
                case 6:
                    self.MusicStyleArray.append(model)
                default:
                    return
                }
            }
            dispatch_async(dispatch_get_main_queue(), { 
                self.collectionView?.reloadData()
            })
         }
       }
    }
    func addSearchView(){
        NetWorkTool.shareNetWorkTool.httpRequest(.get, urlString: searchUrl, parameter: nil) { (respondObject, error) in
            guard let receiveData = respondObject else{
                print("搜索失败")
                return
            }
            print(receiveData)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension CategoryCollectionViewController:UICollectionViewDelegateFlowLayout{
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return hotSingerArray.count
        }else if section == 1{
            return activityArray.count
        }else if section == 2{
            return moodArray.count
        }else if section == 3{
            return themeArray.count
        }else if section == 4{
            return languageArray.count
        }else if section == 5{
            return timesArray.count
        }else{
            return MusicStyleArray.count
        }
    }
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(categoryHotSingerCell, forIndexPath: indexPath) as! CategoryHotSingerCell
            let model:CategoryHotSingerModel = hotSingerArray[indexPath.row]
            cell.backgroundColor = UIColor.clearColor()
            cell.setValueWithModel(model)
            return cell
        }else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(categoryActivityCell, forIndexPath: indexPath) as! CategoryActivityCell
            cell.layer.borderColor = UIColor.whiteColor().CGColor
            cell.layer.borderWidth = 1
            cell.backgroundColor = UIColor.clearColor()
            switch indexPath.section {
            case 1:
                let model:CategoryActivityModel = activityArray[indexPath.row]
                cell.setValueWithModel(model)
            case 2:
                let model:CategoryActivityModel = moodArray[indexPath.row]
                cell.setValueWithModel(model)
            case 3:
                let model:CategoryActivityModel = themeArray[indexPath.row]
                cell.setValueWithModel(model)
            case 4:
                let model:CategoryActivityModel = languageArray[indexPath.row]
                cell.setValueWithModel(model)
            case 5:
                let model:CategoryActivityModel = timesArray[indexPath.row]
                cell.setValueWithModel(model)
            default:
                let model:CategoryActivityModel = MusicStyleArray[indexPath.row]
                cell.setValueWithModel(model)
            }
            return cell
        }
    }
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 7
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10, 75/4, 10, 75/4)
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if indexPath.section == 0{
            return CGSizeMake(100, 140)
        }
        else{
            return CGSizeMake(100, 100)
        }
    }
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        if indexPath.section == 0 {
            let view = collectionView .dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: categoryHotSingerHeaderCell, forIndexPath: indexPath) as! CategoryHotSingerHeaderCell
            view.block = {
                () -> Void in
               let moreSingerVC = CategoryMoreSingleController()
                self.navigationController?.pushViewController(moreSingerVC, animated: true)
            }
            return view
        }else{
            let view = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: categoryHotSingerFooterCell, forIndexPath: indexPath) as! CategoryHotSingerFooterCell
            switch indexPath.section {
            case 1:
                view.nameLabel.text = "活动"
            case 2:
                view.nameLabel.text = "心情"
            case 3:
                view.nameLabel.text = "主题"
            case 4:
                view.nameLabel.text = "语言"
            case 5:
                view.nameLabel.text = "年代"
            default:
                view.nameLabel.text = "曲风"
            }
            return view
        }
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSizeMake(0, 50)
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            let hotSingerModel:CategoryHotSingerModel = hotSingerArray[indexPath.row]
            let singerListVC = MusicListDetailController()
            singerListVC.tingUid = String(hotSingerModel.ting_uid!)
            singerListVC.imgStr = hotSingerModel.avatar_big
            navigationController?.pushViewController(singerListVC, animated: true)
        }else{
            let musicListVC = MusicListDetailController()
            switch indexPath.section {
            case 1:
                let model:CategoryActivityModel = activityArray[indexPath.row]
                musicListVC.imgStr = model.icon_android
                musicListVC.scene_id = model.scene_id
            case 2:
                let model:CategoryActivityModel = moodArray[indexPath.row]
                musicListVC.imgStr = model.icon_android
                musicListVC.scene_id = model.scene_id
            case 3:
                let model:CategoryActivityModel = themeArray[indexPath.row]
                musicListVC.imgStr = model.icon_android
                musicListVC.scene_id = model.scene_id
            case 4:
                let model:CategoryActivityModel = languageArray[indexPath.row]
                musicListVC.imgStr = model.icon_android
                musicListVC.scene_id = model.scene_id
            case 5:
                let model:CategoryActivityModel = timesArray[indexPath.row]
                musicListVC.imgStr = model.icon_android
                musicListVC.scene_id = model.scene_id
            default:
                let model:CategoryActivityModel = MusicStyleArray[indexPath.row]
                musicListVC.imgStr = model.icon_android
                musicListVC.scene_id = model.scene_id
            }
            navigationController?.pushViewController(musicListVC, animated: true)
        }
    }

}




