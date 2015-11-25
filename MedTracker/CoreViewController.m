//
//  CoreViewController.m
//  MedTracker
//
//  Created by Ronald Hernandez on 11/25/15.
//  Copyright © 2015 HardCoders. All rights reserved.
//

#import "CoreViewController.h"

@interface CoreViewController()

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end
@implementation CoreViewController


-(void)cancelAndDismiss{

    //We have to remove any objects that were created. You have to Roll back.
    [self.managedObjectContext rollback];
    [self dismissViewControllerAnimated:YES completion:nil];

}

-(void)saveAndDismiss{

    NSError *error = nil;

    if([self.managedObjectContext hasChanges]){
        if(![self.managedObjectContext save:&error]){//save failed
            NSLog(@"Save Failed! %@", [error localizedDescription]);

        }else{
            NSLog(@"Saved Successfully");
        }
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];

}

//Need to have access to Core Data Stack

-(NSManagedObjectContext *)managedObjectContext{

    return [(AppDelegate *)[[UIApplication sharedApplication]delegate]managedObjectContext];

}

@end
