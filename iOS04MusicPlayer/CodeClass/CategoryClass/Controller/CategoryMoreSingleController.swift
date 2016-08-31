//
//  CategoryMoreSingleController.swift
//  iOS04MusicPlayer
//
//  Created by 黄兵 on 16/7/29.
//  Copyright © 2016年 SZT. All rights reserved.
//

import UIKit

class CategoryMoreSingleController: UITableViewController {

    lazy var chineseArray:[[String:AnyObject]] = {
        var chineseArray = [[String:AnyObject]]()
        return chineseArray
    }()
    lazy var westernArray:[[String:AnyObject]] = {
        var westernArray = [[String:AnyObject]]()
        return westernArray
    }()
    lazy var japanArray:[[String:AnyObject]] = {
        var japanArray = [[String:AnyObject]]()
        return japanArray
    }()
    lazy var koreaArray:[[String:AnyObject]] = {
        var koreaArray = [[String:AnyObject]]()
        return koreaArray
    }()
    lazy var dataDic:[[String:AnyObject]] = {
        var dataDic = [[String:AnyObject]]()
        return dataDic
    }()
    lazy var otherArray:[[String:AnyObject]] = {
        var otherArray = [[String:AnyObject]]()
        return otherArray
    }()
    
    let categoryMoreSinger:String = "CategoryMoreSinger"
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let blurStyle = UIBlurEffect(style: .Dark)
//        let blurView = UIVisualEffectView(effect: blurStyle)
//        blurView.frame = UIScreen.mainScreen().bounds
//        tableView.backgroundColor = UIColor.cyanColor()
//        tableView?.backgroundView = blurView

        
//        UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
//        bgImgView.image = [UIImage imageNamed:@"huoying.jpg"];
//        [self.view addSubview:bgImgView];
//        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(, , bgImgView.frame.size.width*., bgImgView.frame.size.height)];
//        toolbar.barStyle = UIBarStyleBlackTranslucent;
//        [bgImgView addSubview:toolbar];
        
        let imgV = UIImageView(frame: view.bounds)
        imgV.image = UIImage(named: "方向.jpg")
        tableView.backgroundView = imgV
        let toolBar = UIToolbar(frame: view.bounds)
        toolBar.barStyle = .BlackTranslucent
        imgV.addSubview(toolBar)
        
        tableView.registerNib(UINib(nibName: "CategoryMoreSingerCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: categoryMoreSinger)
        tableView.separatorStyle = .None
        addMoreSingerList()
    }
    func addMoreSingerList(){
        let path = NSBundle.mainBundle().pathForResource("SingerCategory", ofType: "json")
        let data = NSData(contentsOfFile: path!)
        do{
           let dictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
            for dict in dictionary["chinese"] as! [[String:AnyObject]] {
                chineseArray.append(dict)
            }
            for dict in dictionary["western"] as! [[String:AnyObject]]{
                westernArray.append(dict)
            }
            for dict in dictionary["japan"] as! [[String:AnyObject]]{
                japanArray.append(dict)
            }
            for dict in dictionary["korea"] as! [[String:AnyObject]]{
                koreaArray.append(dict)
            }
            for dict in dictionary["other"] as! [[String:AnyObject]]{
                otherArray.append(dict)
            }
        }catch{
            print("error")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension CategoryMoreSingleController{
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 4 {
            return 1
        }else{
            return 3
        }
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 5
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(categoryMoreSinger, forIndexPath: indexPath) as! CategoryMoreSingerCell
        cell.backgroundColor = UIColor.clearColor()
        if indexPath.section == 0 {
            cell.maleLabel.text = chineseArray[indexPath.row]["title"]! as? String
        }else if indexPath.section == 1{
            cell.maleLabel.text = westernArray[indexPath.row]["title"]! as? String
        }else if indexPath.section == 2{
            cell.maleLabel.text = koreaArray[indexPath.row]["title"]! as? String
        }else if indexPath.section == 3{
            cell.maleLabel.text = japanArray[indexPath.row]["title"]! as? String
        }else{
            cell.maleLabel.text = otherArray[indexPath.row]["title"]! as? String
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "华语乐坛"
        case 1:
            return "欧美流行"
        case 2:
            return "韩语乐坛"
        case 3:
            return "日语乐坛"
        default:
            return "其他歌手"
        }
    }
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.textColor = UIColor.cyanColor()
        switch section {
        case 0:
            label.text = "华语乐坛"
        case 1:
            label.text = "欧美流行"
        case 2:
            label.text = "韩语乐坛"
        case 3:
            label.text = "日语乐坛"
        default:
            label.text = "其他歌手"
        }
        return label
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let singerListVC = CategorySingerListController()
        singerListVC.xStr = String(indexPath.row + 1)
        switch indexPath.section {
        case 0:
            singerListVC.areaStr = String(6)
        case 1:
            singerListVC.areaStr = String(3)
        case 2:
            singerListVC.areaStr = String(7)
        case 3:
            singerListVC.areaStr = String(60)
        default:
            singerListVC.areaStr = String(5)
        }
        navigationController?.pushViewController(singerListVC, animated: true)
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
}





