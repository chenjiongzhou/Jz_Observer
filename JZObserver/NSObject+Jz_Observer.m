//
//  NSObject+Jz_Observer.m
//  JZObserver
//
//  Created by jiong23 on 2017/4/16.
//  Copyright © 2017年 Chenjz. All rights reserved.
//

#import "NSObject+Jz_Observer.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>


static NSString * const kBlocksKey = @"blocks";
static NSString * const kKeyPathsKey = @"keyPaths";
static NSString * const kObserverdObjectKey = @"observerdObject";

@interface NSObject ()

@property NSMutableDictionary<NSString *, handlerBlock> *blocks;
@property NSMutableArray<NSString *> *keyPaths;
@property NSObject *observerdObject;

@end

@implementation NSObject (Jz_Observer)

- (void)Jz_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath handlerBlock:(handlerBlock)handler {
    NSLog(@"%@ Observer %@ keyPath：%@", self, observer, keyPath);
    
    [self addObserver:observer forKeyPath:keyPath options:NSKeyValueObservingOptionNew context:(__bridge void * _Nullable)([NSString stringWithFormat:@"%zd", self.blocks.count])];
    [self.blocks setObject:handler forKey:[NSString stringWithFormat:@"%zd", self.blocks.count]];
    
    NSMutableArray *keyPaths = [observer valueForKey:kKeyPathsKey];
    [keyPaths addObject:keyPath];
    
    observer.observerdObject = self;
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"Observer：%@ notice %@ value %@ change", self, object, keyPath);
    NSString *key = (__bridge NSString *)(context);
#warning why dict == nil???
    NSMutableDictionary *dict = [object valueForKey:kBlocksKey];
    if (!dict) {
        return;
    }
    handlerBlock block = [dict valueForKey:key];
    if (block) {
        id newValue = [change valueForKey:NSKeyValueChangeNewKey];
        block(newValue);
    }
}

#pragma mark Getter && Setter

- (void)setBlocks:(NSMutableDictionary<NSString *,handlerBlock> *)blocks {
    
    objc_setAssociatedObject(self, (__bridge const void *)(kBlocksKey), blocks, OBJC_ASSOCIATION_RETAIN);
}

- (NSMutableDictionary<NSString *,handlerBlock> *)blocks {

   return objc_getAssociatedObject(self, (__bridge const void *)(kBlocksKey));
}

- (void)setKeyPaths:(NSMutableArray<NSString *> *)keyPaths {

    objc_setAssociatedObject(self, (__bridge const void *)(kKeyPathsKey), keyPaths, OBJC_ASSOCIATION_RETAIN);
}

- (NSMutableArray<NSString *> *)keyPaths {

   return objc_getAssociatedObject(self, (__bridge const void *)(kKeyPathsKey));
}

- (void)setObserverdObject:(NSObject *)observerdObject {

    objc_setAssociatedObject(self, (__bridge const void *)(kObserverdObjectKey), observerdObject, OBJC_ASSOCIATION_ASSIGN);
}

- (NSObject *)observerdObject {

    return objc_getAssociatedObject(self, (__bridge const void *)(kObserverdObjectKey));
}


@end
