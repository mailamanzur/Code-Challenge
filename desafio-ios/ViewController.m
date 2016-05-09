//
//  ViewController.m
//  desafio-ios
//
//  Created by maila manzur on 07/05/16.
//  Copyright © 2016 maila manzur. All rights reserved.
//

#import "ViewController.h"
#import "BankAccount.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [BankAccount processAccounts:@"accounts" andTransactions:@"transactions"];
}



@end
