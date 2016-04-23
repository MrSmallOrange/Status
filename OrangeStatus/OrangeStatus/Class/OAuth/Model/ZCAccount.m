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
    
    return account;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.expires_in forKey:@"expires_in"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.expires_in = [aDecoder decodeObjectForKey:@"expires_in"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
    }
    
    return self;
}
@end
