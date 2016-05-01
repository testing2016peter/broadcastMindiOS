//
//  BMArticle.h
//  broadcastMindiOS
//
//  Created by Anson Ng on 4/17/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import "BMBaseJSONModel.h"
#import "BMUser.h"
@protocol BMPost

@end

@interface BMPost : BMBaseJSONModel

@property (strong, nonatomic) NSString <Optional> *text;
@property (strong, nonatomic) NSString <Optional> *createdAt;
@property (strong, nonatomic) NSString <Optional> *updatedAt;
@property (strong, nonatomic) BMUser <Optional, BMUser> *author;
@property (strong, nonatomic) NSString <Optional> *like1_count;
@property (strong, nonatomic) NSString <Optional> *like2_count;
@property (strong, nonatomic) NSString <Optional> *objectId;


@end