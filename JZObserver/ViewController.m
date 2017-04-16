//
//  ViewController.m
//  JZObserver
//
//  Created by jiong23 on 2017/4/16.
//  Copyright © 2017年 Chenjz. All rights reserved.
//

#import "ViewController.h"
#import "JZPerson.h"
#import "NSObject+Jz_Observer.h"

@interface ViewController () {
    JZPerson *_person;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _person = [JZPerson new];
    _person.name = @"Hello";
    
    [_person Jz_addObserver:self forKeyPath:@"name" handlerBlock:^(id newValue) {
        
        NSLog(@"newValue : %@", newValue);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    _person.name = @"chenjionghzou";
}

@end
