//
//  BMArticleList.h
//  broadcastMindiOS
//
//  Created by Anson Ng on 4/17/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import "BMBaseJSONModel.h"
#import "BMPost.h"
@protocol BMPostList

@end

@interface BMPostList : BMBaseJSONModel

@property (assign, nonatomic) NSString <Optional> *total;
@property (strong, nonatomic) NSArray  <BMPost, Optional> *posts;

@end
