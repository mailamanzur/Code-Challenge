//
//  BankAccount.m
//  desafio-ios
//
//  Created by maila manzur on 08/05/16.
//  Copyright © 2016 maila manzur. All rights reserved.
//

#import "BankAccount.h"

@implementation BankAccount

+ (NSArray *)readFile:(NSString *)file {
    
    NSString* filePath = [[NSBundle mainBundle] pathForResource:file ofType:@"csv"];
    
    NSString* fileContents = [NSString stringWithContentsOfFile:filePath
                                                       encoding:NSUTF8StringEncoding
                                                          error:nil];
    
    NSArray *lines = [fileContents componentsSeparatedByString:@"\n"];
    NSMutableArray *processed = @[].mutableCopy;
    for (NSString *line in lines) {
        NSArray *components = [line componentsSeparatedByString:@","];
        if (components.count == 2) {
            [processed addObject:@[components[0], components[1]]];
        }
    }
    return processed;
}

+ (void)processAccounts:(NSString *)accFile andTransactions:(NSString *)transFile {
    NSArray *accounts = [BankAccount readFile:accFile];
    NSMutableDictionary *transactions = [BankAccount handleAccountsArray:accounts];
    [BankAccount handleTransactionsArray:transFile transactions:&transactions];
    [BankAccount processBalancesOfAccounts:accounts withTransactions:transactions];
}

+ (NSMutableDictionary *)handleAccountsArray:(NSArray *)accounts {
    NSMutableDictionary *temp = @{}.mutableCopy;
    NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
    for (NSArray *account in accounts) {
        NSString *accountId = account[0];
        NSNumber *balance = [nf numberFromString:account[1]];
        [temp setObject:@[balance] forKey:accountId];
    }
    return temp;
}

+ (void)handleTransactionsArray:(NSString *)fileName transactions:(NSMutableDictionary **)transactions {
    NSArray *fileTrans = [BankAccount readFile:fileName];
    for (NSArray *trans in fileTrans) {
        NSString *accountId = trans[0];
        NSNumber *transValue = trans[1];
        NSMutableArray *transArray = [*transactions mutableArrayValueForKey:accountId];
        [transArray addObject:transValue];
    }
}

+ (void)processBalancesOfAccounts:(NSArray *)accounts withTransactions:(NSDictionary *)transactions {
    NSLog(@"Processing balances...%@ %@",accounts,transactions);
    for (NSArray *account in accounts) {
        NSString *accountId = account[0];
        NSMutableArray  *accountTrans = ((NSArray *)transactions[accountId]).mutableCopy;
        float balance = [((NSNumber *)[accountTrans objectAtIndex:0]) floatValue];
        [accountTrans removeObjectAtIndex:0];
        
        for (NSNumber *transValue in accountTrans) {
            balance += transValue.floatValue;
            if (transValue.floatValue < 0 && balance < 0) {
                balance -= 5.0;
            }
        }
        NSLog(@"Accound Id: %@ -> balance: R$ %f", accountId, balance);
    }
};

@end
