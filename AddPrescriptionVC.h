//
//  AddPrescriptionVC.h
//  MedTracker
//
//  Created by Ronald Hernandez on 11/25/15.
//  Copyright © 2015 HardCoders. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreViewController.h"


@interface AddPrescriptionVC : CoreViewController

@property (weak, nonatomic) IBOutlet UITextField *prescriptionName;
@property (weak, nonatomic) IBOutlet UITextField *prescriptionInstructions;

- (IBAction)onCancelButtonTapped:(UIBarButtonItem *)sender;



- (IBAction)onSaveButtonTapped:(UIBarButtonItem *)sender;

@end
