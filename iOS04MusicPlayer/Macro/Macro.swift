//
//  Macro.swift
//  iOS04MusicPlayer
//
//  Created by SZT on 16/7/22.
//  Copyright © 2016年 SZT. All rights reserved.
//

import UIKit

// 屏幕宽
  let screenWidth = UIScreen.mainScreen().bounds.size.width
// 屏幕高
  let screenHeight = UIScreen.mainScreen().bounds.size.height

//    首页
//首页轮播图
  let homePageHeaderUrl:String = "http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.plaza.getFocusPic&format=json&from=ios&version=5.2.3&from=ios&channel=appstore"
//首页热门推荐url
  let homePageHeaderRecommendUrl:String = "http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.diy.getHotGeDanAndOfficial&num=4&version=5.2.3&from=ios&channel=appstore"
//首页热门歌单url
   let homePageHeaderMusicListUrl:String = "http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.diy.gedan&page_no=1&page_size=30&from=ios&version=5.2.3&from=ios&channel=appstore"
// 歌单列表—热门歌单与推荐点击后传入参数
let homePageHotDetailUrl: String = "http://tingapi.ting.baidu.com/v1/restserver/ting?"
// method=baidu.ting.diy.gedanInfo&from=ios&listid=5717&version=5.2.3&from=ios&channel=appstore"
// 歌单列表—轮播图点击后传入参数 (注：轮播图上数据不定含有某些数据与之不同，需要判断type给定不同的url接入参数来解析)  例如：type值为2时
let homePageRotateDetailUrl: String = "http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.album.getAlbumInfo&album_id="
// ***拼接参数****
//  &format=json&from=ios&version=5.2.5&from=ios&channel=appstore
//  type为5时url为热门歌单与推荐点进来的url拼接参数，具体看解析的数据格式


//  排行榜url
let rankingMusicListUrl:String = "http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.billboard.billCategory&format=json&from=ios&version=5.2.1&from=ios&channel=appstore"
//  歌单列表—排行榜
let rankingMusicListOne:String = "http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.billboard.billList&type="
let rankingMusicListTwo:String = "&format=json&offset=0&size=50&from=ios&fields=title,song_id,author,resource_type,havehigh,is_new,has_mv_mobile,album_title,ting_uid,album_id,charge,all_rate&version=5.2.1&from=ios&channel=appstore"

//  歌单列表—歌手歌曲
let rankingSingerListUrlOne:String = "http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.artist.getSongList&format=json&tinguid="
let rankingSingerListUrlTwo:String = "&artistid(null)&limits=30&order=2&offset=0&version=5.2.5&from=ios&channel=appstore"

//  播放页面
let songUrlOne:String = "http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.song.getInfos&ts=1445484488&songid="
let songUrlTwo:String = "&nw=2&l2p=0&lpb=0&ext=mp3&format=json&from=ios&usup=1&lebo=0&aac=0&ucf=4&vid=&res=1&e=USbMxKUnchkbhCYmky%2B5RJ%2FpxskZMYC1wjYkv8AHsvo%3D&version=5.3.2&from=ios&channel=appstore"

// 歌曲url为该url解析后对应的file_link
// 例如：http://yinyueshiting.baidu.com/data2/music/240372672/240372672.mp3?xcode=52d53399875d12f526d7084657a59bf4
//歌词url为该url解析后对应的lrcylink

//例如：
//  http://musicdata.baidu.com/data2/lrc/241647508/%E6%81%8B%E8%A5%BF%E6%B8%B8.lrc


//  分类页面—热门歌手url
let categoryHotSingerUrl:String = "http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.artist.getList&format=json&order=1&limit=6&offset=0&area=0&sex=0&abc=&from=ios&version=5.2.1&from=ios&channel=appstore"

// 分类页面-url
let categoryBigListUrl:String = "http://tingapi.ting.baidu.com/v1/restserver/ting/?method=baidu.ting.scene.getCategoryScene&category_id=%d&version=5.2.5&from=ios&channel=appstore"

//  分类页面—活动url
let categoryActivityUrl:String = "http://tingapi.ting.baidu.com/v1/restserver/ting/?method=baidu.ting.scene.getCategoryScene&category_id=0&version=5.2.5&from=ios&channel=appstore"

//  分类页面—心情url
let categoryMoodUrl:String = "http://tingapi.ting.baidu.com/v1/restserver/ting/?method=baidu.ting.scene.getCategoryScene&category_id=3&version=5.2.5&from=ios&channel=appstore"

//  分类页面—主题url
let categoryThemeUrl:String = "http://tingapi.ting.baidu.com/v1/restserver/ting/?method=baidu.ting.scene.getCategoryScene&category_id=1&version=5.2.5&from=ios&channel=appstore"

//  分类页面—语言url
let categoryLanguageUrl:String = "http://tingapi.ting.baidu.com/v1/restserver/ting/?method=baidu.ting.scene.getCategoryScene&category_id=4&version=5.2.5&from=ios&channel=appstore"

//  分类页面—年代url
let categoryTimesUrl:String = "http://tingapi.ting.baidu.com/v1/restserver/ting/?method=baidu.ting.scene.getCategoryScene&category_id=5&version=5.2.5&from=ios&channel=appstore"

//  分类页面—曲风url
let categoryMusicStyleUrl:String = "http://tingapi.ting.baidu.com/v1/restserver/ting/?method=baidu.ting.scene.getCategoryScene&category_id=6&version=5.2.5&from=ios&channel=appstore"

// 歌手类别
let SingerUrlOne = "http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.artist.getList&format=json&order=1&limit=50&offset=0&area="
let singerUrlTwo = "&abc=%E7%83%AD%E9%97%A8&from=ios&version=5.2.5&from=ios&channel=appstore"


//   华语男歌手url
let chineseMaleSingerUrl = "http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.artist.getList&format=json&order=1&limit=50&offset=0&area=6&sex=1&abc=%E7%83%AD%E9%97%A8&from=ios&version=5.2.5&from=ios&channel=appstore"

// 华语女歌手url
let chineseFemaleSingerUrl = "http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.artist.getList&format=json&order=1&limit=50&offset=0&area=6&sex=2&abc=%E7%83%AD%E9%97%A8&from=ios&version=5.2.5&from=ios&channel=appstore"

// 华语组合url
let chineseCombinationUrl  = "http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.artist.getList&format=json&order=1&limit=50&offset=0&area=6&sex=3&abc=%E7%83%AD%E9%97%A8&from=ios&version=5.2.5&from=ios&channel=appstore"

// 欧美男歌手url
let westernMaleSingerUrl = "http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.artist.getList&format=json&order=1&limit=50&offset=0&area=3&sex=1&abc=%E7%83%AD%E9%97%A8&from=ios&version=5.2.5&from=ios&channel=appstore"

// 欧美女歌手url
let westernFemaleSingerUrl = "http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.artist.getList&format=json&order=1&limit=50&offset=0&area=3&sex=2&abc=%E7%83%AD%E9%97%A8&from=ios&version=5.2.5&from=ios&channel=appstore"

// 欧美组合url
let westernCombinationUrl = "http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.artist.getList&format=json&order=1&limit=50&offset=0&area=3&sex=3&abc=%E7%83%AD%E9%97%A8&from=ios&version=5.2.5&from=ios&channel=appstore"

// 韩国男歌手url
let koreaMaleSingerUrl = "http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.artist.getList&format=json&order=1&limit=50&offset=0&area=7&sex=1&abc=%E7%83%AD%E9%97%A8&from=ios&version=5.2.5&from=ios&channel=appstore"

// 韩国女歌手url
let koreaFemaleSingerUrl = "http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.artist.getList&format=json&order=1&limit=50&offset=0&area=7&sex=2&abc=%E7%83%AD%E9%97%A8&from=ios&version=5.2.5&from=ios&channel=appstore"

// 韩国组合url
let koreaCombinationUrl = "http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.artist.getList&format=json&order=1&limit=50&offset=0&area=7&sex=3&abc=%E7%83%AD%E9%97%A8&from=ios&version=5.2.5&from=ios&channel=appstore"

// 日本男歌手url
let japanMaleSingerUrl = "http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.artist.getList&format=json&order=1&limit=50&offset=0&area=60&sex=1&abc=%E7%83%AD%E9%97%A8&from=ios&version=5.2.5&from=ios&channel=appstore"

// 日本女歌手url
let japanFemaleSingerUrl = "http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.artist.getList&format=json&order=1&limit=50&offset=0&area=60&sex=2&abc=%E7%83%AD%E9%97%A8&from=ios&version=5.2.5&from=ios&channel=appstore"

// 日本组合url
let japanCombinationUrl = "http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.artist.getList&format=json&order=1&limit=50&offset=0&area=60&sex=3&abc=%E7%83%AD%E9%97%A8&from=ios&version=5.2.5&from=ios&channel=appstore"

// 其他歌手url
let otherSingerUrl = "http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.artist.getList&format=json&order=1&limit=50&offset=0&area=5&sex=4&abc=%E7%83%AD%E9%97%A8&from=ios&version=5.2.5&from=ios&channel=appstore"

// 搜索url（红色标注为输入字符转换的utf-8格式）
let searchUrl = "http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.search.merge&query=%E5%A4%9C%E6%9B%B2-%E5%91%A8%E6%9D%B0%E4%BC%A6&page_size=50&page_no=1&type=-1&format=json&from=ios&version=5.2.5&from=ios&channel=appstore"
// 小分类
let smallCategoryUrl = "http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.song.getSmartSongList&page_no=1&page_size=50&scene_id=%@&item_id=0&version=5.2.5&from=ios&channel=appstore"


class Macro: NSObject {
    

}
