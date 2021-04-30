//
//  MovieVO.swift
//  AlamofireMovieList
//
//  Created by Sinchon on 2021/04/30.
//

import Foundation
import UIKit

struct MovieVo{
    var title:String!
    var genre:String!
    var rating:Double!
    var thumbnail:String!
    //thumbnail 값을 이용해서 저장할 Image
    var image:UIImage!
    
    //하위 데이터에 Webkit View를 이용해서 데이터를 출력하기 위한 URL
    var link:String!
}
