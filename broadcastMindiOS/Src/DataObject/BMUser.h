//
//  BMUser.h
//  broadcastMindiOS
//
//  Created by Anson Ng on 5/1/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import "BMBaseJSONModel.h"
@protocol BMUser

@end
@interface BMUser : BMBaseJSONModel
@property (strong, nonatomic) NSString <Optional >* backgroundImg;//= "http://weknowyourdreamz.com/image.php?pic=/images/beautiful/beautiful-07.jpg";
@property (strong, nonatomic) NSString <Optional >* email;        // = "cwnga@yahoo-inc.com";
@property (strong, nonatomic) NSString <Optional >* nickname;     // = badass;
@property (strong, nonatomic) NSString <Optional >* objectId;     // = 57134de771cfe400677e6779;
@property (strong, nonatomic) NSString <Optional >* profileImg;   // = "http://webneel.com/sites/default/files/images/project/best-portrait-photography-regina-pagles%20(10).jpg";

@end