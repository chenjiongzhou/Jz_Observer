//
//  NSObject+Jz_Observer.h
//  JZObserver
//
//  Created by jiong23 on 2017/4/16.
//  Copyright © 2017年 Chenjz. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^handlerBlock)(id newValue);

@interface NSObject (Jz_Observer)

- (void)Jz_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath handlerBlock:(handlerBlock)handler;

@end
