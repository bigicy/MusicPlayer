//
//  HomePageTableViewController.swift
//  BDMusic
//
//  Created by lanou on 16/7/22.
//  Copyright © 2016年 lanou. All rights reserved.
//

import UIKit
import SDWebImage
import MJRefresh
class HomePageTableViewController: UITableViewController {
    
    var recommendScrollView: UIScrollView?
    
    // 存放轮播图的数据模型数组
    lazy var imageModels:[HomePagePicModel] = {
        var imageArray = [HomePagePicModel]()
        return imageArray
    }()
    // 存放热门推荐图片的数据模型数组
    lazy var commendModels:[HomePageRecommendModel] = {
         var commendArray = [HomePageRecommendModel]()
         return commendArray
    }()
    
    lazy var recommandLists:[HomePageMusicListModel] = {
         var recommandLists = [HomePageMusicListModel]()
        return recommandLists
    }()
    
    var start: Int = 10
    var limit: Int = 20
    
    let recommandIdentifier = "recommandIdentifier"
    let musicListIdentifier = "musicListIdentifier"
    override func viewDidLoad() {
    super.viewDidLoad()
//        模糊效果
        let blurStyle = UIBlurEffect(style: .Dark)
        let blurView = UIVisualEffectView(effect: blurStyle)
        blurView.frame = UIScreen.mainScreen().bounds
        tableView.backgroundView = blurView
        
        MJRefreshData()
//         添加头部轮播图
        addTableHeaderView()
//         添第一个分区
        addReCommendView()
//        添加第二个分区
        addMusicListView()
//        注册cell
        tableView.registerNib(UINib(nibName: "HomePageRecommendCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier:recommandIdentifier)
        tableView.registerNib(UINib(nibName: "HomePageMusicListCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: musicListIdentifier)
    }
    
    //    滑动至下一张图片
    func turnToNext(timer:NSTimer){
        let tableHeaderView = timer.userInfo as! HomePageHeaderView
        let index = tableHeaderView.contentOffset.x/screenWidth
        tableHeaderView.setContentOffset(CGPointMake((index+1)*screenWidth, 0), animated: true)
    }
    
    private func addTableHeaderView()
    {
    NetWorkTool.shareNetWorkTool.httpRequest(.get, urlString:homePageHeaderUrl , parameter: nil) { (respondeData, error) -> () in
//    条件不满足时执行else下面的语句
    guard let receiveObject = respondeData else{
    print("轮播图error\(error)")
    return
    }
    for dict in receiveObject["pic"] as! [[String:AnyObject]]{
        let imageModel = HomePagePicModel(dict: dict)
        self.imageModels.append(imageModel)
    }
//    轮播图，最后一张作为假图，跟第0张一模一样
//    0 1 2 3 4 0
//    imageArray.append(imageArray[0])
        self.imageModels.append(self.imageModels.first!)
//    遍历数组创建UIImageView并且添加到scrollView上面
        let headerScrollView = HomePageHeaderView(frame: CGRectMake(0, 0, screenWidth, 150), imageModels: self.imageModels, tapAction: #selector(HomePageTableViewController.imageTapAction(_:)), timeInterval: 2.0, timeAction: #selector(HomePageTableViewController.turnToNext(_:)), target: self)
        headerScrollView.delegate = self
       self.tableView.tableHeaderView = headerScrollView
        }
    }
    
    // 点击图片
    func imageTapAction(tap:UITapGestureRecognizer){
        print("imageTapAction:")
    }
    
    private func addReCommendView()
    {
        NetWorkTool.shareNetWorkTool.httpRequest(.get, urlString:homePageHeaderRecommendUrl , parameter: nil) { (respondeData, error) -> () in
            //条件不满足时执行else下面的语句
            guard let receiveObject = respondeData else{
                print("轮播图error\(error)")
                return
            }
//           字典转模型, 并且保存起来
            for dict in receiveObject["content"]!!["list"] as! [[String:AnyObject]]{
                let imageModel = HomePageRecommendModel(dict: dict)
//                闭包操作需添加self
                self.commendModels.append(imageModel)
            }
//           回到主线程刷新UI数据
            dispatch_async(dispatch_get_main_queue(), {
//          按section分区重载数据需要在静态变化的数据才可以运行, 动态变化数据不可以
//                self.tableView.reloadSections(NSIndexSet(index:0), withRowAnimation: UITableViewRowAnimation.Automatic)
               self.tableView.reloadData()
            })
        }
    }
    
    func recommandAction(tap:UITapGestureRecognizer){
        print("添加手势")
        let index:Int = (tap.view?.tag)!
        let musicListVC = MusicListDetailController()
        let model = commendModels[index - 1]
        musicListVC.stringID = model.listid
        musicListVC.imgStr = model.pic
        self.navigationController?.pushViewController(musicListVC, animated: true)
    }
    private func addMusicListView(){
        NetWorkTool.shareNetWorkTool.httpRequest(.post, urlString: homePageHeaderMusicListUrl, parameter: ["start":start, "limit":limit]) { (respondObject, error) in
            guard let receivedata = respondObject else{
                print("轮播图error\(error)")
                return
            }
            for dict in receivedata["content"] as![[String:AnyObject]]{
                let musicListmodel = HomePageMusicListModel(dict: dict)
                self.recommandLists.append(musicListmodel)
            }
            dispatch_async(dispatch_get_main_queue(), { 
                self.tableView.reloadData()
                self.tableView.mj_header.endRefreshing()
                self.tableView.mj_footer.endRefreshing()
            })
        }
    }
    
    func MJRefreshData(){
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.start = self.start + 20
            print(self.start)
            self.recommandLists .removeAll()
            self.addMusicListView()
        })
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            self.start = self.start + 20
            self.addMusicListView()
        })
    }
}
// swift遵守协议的方式：extension 本类名：协议名1，协议名2...{}
extension HomePageTableViewController{ // 默认以及遵循好了，就不用再写
    override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x/screenWidth
        if index == 5{
            scrollView.setContentOffset(CGPointMake(0, 0), animated: false)
        }
    }
    override func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x/screenWidth
        if index == 5{
            scrollView.setContentOffset(CGPointMake(0, 0), animated: false)
        }
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else{
            return recommandLists.count
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "热门推荐"
        }else{
            return "热门歌单"
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
           let cell = tableView.dequeueReusableCellWithIdentifier(recommandIdentifier, forIndexPath: indexPath) as! HomePageRecommendCell
            cell.setImageArray(commendModels, target: self
                , action:#selector(HomePageTableViewController.recommandAction))
            cell.backgroundColor = UIColor.clearColor()
            return cell
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier(musicListIdentifier, forIndexPath: indexPath) as!HomePageMusicListCell
            let model = recommandLists[indexPath.row]
            cell.setValueWithModel(model)
            cell.backgroundColor = UIColor.clearColor()
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
           let musicListVC = MusicListDetailController()
            let model = recommandLists[indexPath.row]
            musicListVC.stringID = model.listid
            musicListVC.imgStr = model.pic_300
            self.navigationController?.pushViewController(musicListVC, animated: true)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return (screenWidth - 20)/2+30}
        else{
            return 150
        }
    }
}

