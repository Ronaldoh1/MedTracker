//
//  AddPrescriptionVC.m
//  MedTracker
//
//  Created by Ronald Hernandez on 11/25/15.
//  Copyright © 2015 HardCoders. All rights reserved.
//

#import "AddPrescriptionVC.h"
#import "PrescriptionTVC.h"

@implementation AddPrescriptionVC

- (IBAction)onCancelButtonTapped:(UIBarButtonItem *)sender {




    [super cancelAndDismiss];
}

- (IBAction)onSaveButtonTapped:(UIBarButtonItem *)sender {

    self.prescription.patient = self.prescriptionsPatient;
    
    self.prescription.prescriptionName = self.prescriptionName.text;
    self.prescription.prescriptionInstruction = self.prescriptionInstructions.text;

    [super saveAndDismiss];
}
@end
