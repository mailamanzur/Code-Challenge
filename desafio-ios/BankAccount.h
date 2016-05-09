//
//  BankAccount.h
//  desafio-ios
//
//  Created by maila manzur on 08/05/16.
//  Copyright © 2016 maila manzur. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BankAccount : NSObject

+ (void)processAccounts:(NSString *)accFile andTransactions:(NSString *)transFile;

@end
