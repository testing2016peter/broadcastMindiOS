//
//  BMArticleList.h
//  broadcastMindiOS
//
//  Created by Anson Ng on 4/17/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import "BMBaseJSONModel.h"
#import "BMArticle.h"
@protocol BMArticleList

@end

@interface BMArticleList : BMBaseJSONModel

@property (assign, nonatomic) NSInteger totalCount;
@property (strong, nonatomic) NSArray  <BMArticle, Optional> *articles;

@end
