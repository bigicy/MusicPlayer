//
//  CategorySingerListController.swift
//  iOS04MusicPlayer
//
//  Created by 黄兵 on 16/7/30.
//  Copyright © 2016年 SZT. All rights reserved.
//

import UIKit

class CategorySingerListController: UITableViewController {

    var areaStr: String?
    var xStr: String?
    
    lazy var singerListArray:[CategorySingerListModel] = {
         var singerListArray = [CategorySingerListModel]()
         return singerListArray
    }()
    let categorySingerListCell = "categorySingerListCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let blurEffect = UIBlurEffect(style: .Dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = UIScreen.mainScreen().bounds
        tableView.backgroundView = blurView
        
        tableView.registerNib(UINib(nibName: "CategorySingerListCell",bundle: NSBundle.mainBundle()), forCellReuseIdentifier: categorySingerListCell)
        addSingerListView()
    }

    func addSingerListView(){
        let singerListUrl = SingerUrlOne + areaStr! + "&sex=" + xStr! + singerUrlTwo
        NetWorkTool.shareNetWorkTool.httpRequest(.get, urlString: singerListUrl, parameter: nil) { (respondObject, error) in
            guard let receiveData = respondObject else{
                print("歌手解析错误")
                return
            }
            for dict in receiveData["artist"] as! [[String:AnyObject]] {
                let model = CategorySingerListModel(dict: dict)
                self.singerListArray.append(model)
            }
            dispatch_async(dispatch_get_main_queue(), { 
                self.tableView.reloadData()
            })
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
extension CategorySingerListController{
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return singerListArray.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(categorySingerListCell, forIndexPath: indexPath) as! CategorySingerListCell
        cell.backgroundColor = UIColor.clearColor()
        let model:CategorySingerListModel = singerListArray[indexPath.row]
        cell.setValueWithModel(model)
        return cell
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let musicListVC = MusicListDetailController()
        let model:CategorySingerListModel = singerListArray[indexPath.row]
        musicListVC.tingUid = model.ting_uid
        musicListVC.imgStr = model.avatar_big
        navigationController?.pushViewController(musicListVC, animated: true)
    }
}
