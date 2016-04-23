//
//  BMArticle.h
//  broadcastMindiOS
//
//  Created by Anson Ng on 4/17/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import "BMBaseJSONModel.h"

@protocol BMPost

@end

@interface BMPost : BMBaseJSONModel

@property (strong, nonatomic) NSString <Optional> *text;
@property (strong, nonatomic) NSString <Optional> *createdAt;
@property (strong, nonatomic) NSString <Optional> *updatedAt;
@property (strong, nonatomic) NSString <Optional> *author;

@end