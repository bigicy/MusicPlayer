//
//  TopListTableViewController.swift
//  iOS04MusicPlayer
//
//  Created by SZT on 16/7/22.
//  Copyright © 2016年 SZT. All rights reserved.
//

import UIKit

class TopListTableViewController: UITableViewController {

    lazy var topMusicListArray:[TopMusicListModel] = {
        var  topMusicListArray = [TopMusicListModel]()
        return topMusicListArray
    }()
    
    let topMusicListViewCell = "TopMusicListViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let blurStyle = UIBlurEffect(style: .Dark)
//        let visualView = UIVisualEffectView(effect: blurStyle)
//        visualView.frame = UIScreen.mainScreen().bounds
//        tableView.backgroundView = visualView
        
//        模糊效果 . 毛玻璃
        let imgV = UIImageView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
        imgV.image = UIImage(named: "方向.jpg")
//        tableView.backgroundColor = UIColor.clearColor()
        tableView.backgroundView = imgV
        let toolBar = UIToolbar(frame: imgV.frame)
        toolBar.barStyle = .BlackTranslucent
        imgV.addSubview(toolBar)
        
        tableView.registerNib(UINib(nibName: "TopMusicListViewCell",bundle: NSBundle.mainBundle()), forCellReuseIdentifier:topMusicListViewCell )
        
        creatView()
     
    }
    func creatView(){
        NetWorkTool.shareNetWorkTool.httpRequest(.get, urlString: rankingMusicListUrl, parameter: nil) { (respondObject, error) in
            guard let receiveData = respondObject else{
                print("网络错误")
                return
            }
            for dic in receiveData["content"] as! [[String:AnyObject]]{
                let topListModel = TopMusicListModel(dict: dic)
                self.topMusicListArray.append(topListModel)
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

extension TopListTableViewController{
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.topMusicListArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(topMusicListViewCell, forIndexPath: indexPath) as! TopMusicListViewCell
        let model:TopMusicListModel = topMusicListArray[indexPath.row]
        cell.setValueWithModel(model)
        cell.backgroundColor = UIColor.clearColor()
        cell.firstMusic.text = String(model.content![0]["title"]!!) + " - " +  String(model.content![0]["author"]!!)
        cell.secondMusic.text = String(model.content![1]["title"]!!) + " - " +  String(model.content![1]["author"]!!)
        cell.thirdMusic.text = String(model.content![2]["title"]!!) + " - " +  String(model.content![2]["author"]!!)
        cell.fourthMusic.text = String(model.content![3]["title"]!!) + " - " +  String(model.content![3]["author"]!!)
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let musicListVC = MusicListDetailController()
        let model:TopMusicListModel = topMusicListArray[indexPath.row]
        musicListVC.typeString = String(model.type)
        musicListVC.imgStr = model.pic_s192
        navigationController?.pushViewController(musicListVC, animated: true)
    }
}

