//
//  AddPatient.m
//  MedTracker
//
//  Created by Ronald Hernandez on 11/25/15.
//  Copyright © 2015 HardCoders. All rights reserved.
//

#import "AddPatientVC.h"

@implementation AddPatientVC


- (IBAction)onCancelButtonTapped:(UIBarButtonItem *)sender {
    //call parent class file.
    [super cancelAndDismiss];

    
}

- (IBAction)onSaveButtonTapped:(UIBarButtonItem *)sender {
    //call parent class file.

    self.addPatient.patientFirstName = self.patientFirstName.text;
    self.addPatient.patientLastName = self.patientLastName.text;
    
    [super saveAndDismiss];
}

@end
