//
//  BoUserModel.m
//  flutter_sp
//
//  Created by ZhangYu on 2020/12/3.
//

#import "BoUserModel.h"

@implementation BoUserModel

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.uid forKey:@"uid"];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder {
    if (self = [super init]) {
        self.uid = [coder decodeObjectForKey:@"uid"];
    }
    return self;
}


@end
