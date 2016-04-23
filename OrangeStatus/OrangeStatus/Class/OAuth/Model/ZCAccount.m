//
//  ZCAccount.m
//  OrangeStatus
//
//  Created by ZhangCheng on 16/4/23.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import "ZCAccount.h"

@implementation ZCAccount
+ (instancetype)accountWithDictionary:(NSDictionary *)dictionary
{
    ZCAccount *account = [[self alloc] init];
    account.access_token = dictionary[@"access_token"];
    account.expires_in = dictionary[@"expires_in"];
    account.uid = dictionary[@"uid"];
    account.create_time = [NSDate date];
 
    
    return account;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.expires_in forKey:@"expires_in"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.create_time forKey:@"create_time"];
    [aCoder encodeObject:self.name forKey:@"name"];
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.expires_in = [aDecoder decodeObjectForKey:@"expires_in"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.create_time = [aDecoder decodeObjectForKey:@"create_time"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
    }
    
    return self;
}
@end
