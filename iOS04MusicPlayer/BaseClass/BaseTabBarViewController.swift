//
//  BaseTabBarViewController.swift
//  iOS04MusicPlayer
//
//  Created by SZT on 16/7/22.
//  Copyright © 2016年 SZT. All rights reserved.
//

import UIKit

class BaseTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tabBar.barTintColor = UIColor.blackColor()
        tabBar.tintColor = UIColor.redColor()
        
        addChildViewControllers()

        
    }
    
//    private修饰的方法属性外界不可访问，为了提高我们阅读代码的效率，经常将本类中不需要给外部调用的方法和属性用private修饰。但是！！！UI控件的响应事件不可以用private修饰，因为在调用栈里面UI的响应事件不是由本类区调用的
    private func addChildViewControllers()
    {
        let path = NSBundle.mainBundle().pathForResource("BaseTBC", ofType: "json")
        let data = NSData(contentsOfFile: path!)
        do{
            let rootArray = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
            
            for dict in rootArray as! [[String:String]]{
                addChildViewControllerWith(dict["controllName"]! , title: dict["title"]! , imageName: dict["imageName"]! )
            }
        }catch{
            
            //            默认的一些操作
            addChildViewControllerWith("HomePageTableViewController", title: "首页", imageName: "cm2_note_icn_listen@2x")
            addChildViewControllerWith("TopListTableViewController", title: "排行榜", imageName: "cm2_note_icn_logo@2x")
            
            addChildViewControllerWith("CategoryCollectionViewController", title: "分类", imageName: "cm2_btm_icn_music_prs@2x")
            addChildViewControllerWith("UserTableViewController", title: "我的", imageName: "ic_radiopage_personal@2x")
        }
    }
    
//  根据视图控制器名字和对应的属性添加导航视图控制器至TabBarcontroller
   private func addChildViewControllerWith(controllerName:String,title:String,imageName:String){
        
//        swift中系统会在类名前面加上一个命名空间，命名空间可以通过 NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"]来获取到
        let nameSpace = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as! String
        
//        根据一个类型来加载类objClass
        let objClass:AnyObject = NSClassFromString("\(nameSpace).\(controllerName)")!
//        将objClass转化为真实的类UITableViewController
    if controllerName == "CategoryCollectionViewController" {
        let realClass = objClass as! UICollectionViewController.Type
        //        根据realClass实例化一个控制器对象
        let layout = UICollectionViewFlowLayout()
        let controller = realClass.init(collectionViewLayout: layout)
        //        创建导航视图控制器,并将controller做为根视图
        let navc = UINavigationController(rootViewController: controller)
        //    设置导航条为黑色
        navc.navigationBar.barTintColor = UIColor.blackColor()
        //    设置导航条标题颜色为白色
        navc.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        //        设置标题
        controller.tabBarItem.title = title
        controller.navigationItem.title = title
        //        设置图标
        controller.tabBarItem.image = UIImage(named: imageName)
        //        最后将导航视图控制器添加到tabBarController上面
        addChildViewController(navc)
    }else{
        let realClass = objClass as! UITableViewController.Type
//        根据realClass实例化一个控制器对象
        let controller = realClass.init(style: .Plain)
//        创建导航视图控制器,并将controller做为根视图
        let navc = UINavigationController(rootViewController: controller)
//    设置导航条为黑色
        navc.navigationBar.barTintColor = UIColor.blackColor()
//    设置导航条标题颜色为白色 
    navc.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
    
    
//        设置标题
        controller.tabBarItem.title = title
        controller.navigationItem.title = title
//        设置图标
        controller.tabBarItem.image = UIImage(named: imageName)
    
    
//        最后将导航视图控制器添加到tabBarController上面
        addChildViewController(navc)
    }
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
