//
//  HomePageSubDataModel.h
//  Mushroom
//
//  Created by 王雅琦 on 2017/10/19.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomePageArtistsModel.h"

@interface HomePageSubDataModel : NSObject

@property (nonatomic, copy) NSString *videoId;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *posterPic;
@property (nonatomic, strong) NSMutableArray *artists;


@end
