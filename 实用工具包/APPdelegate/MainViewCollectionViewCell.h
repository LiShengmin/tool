//
//  MainViewCollectionViewCell.h
//  实用工具包
//
//  Created by Ghoul on 15/12/24.
//  Copyright © 2015年 Ghoul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootCollectionViewCell.h"

@interface MainViewCollectionViewCell : RootCollectionViewCell

@property (nonatomic, copy)      NSString * labelText;
@property (nonatomic, copy)      NSString * imageStr;
@property (nonatomic, copy)      NSString * imageURL;
//@property (nonatomic, strong) NSIndexPath * indexPath;

@end
