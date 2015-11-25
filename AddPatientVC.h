//
//  AddPatient.h
//  MedTracker
//
//  Created by Ronald Hernandez on 11/25/15.
//  Copyright © 2015 HardCoders. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreViewController.h"
#import "Patient.h"

@interface AddPatientVC : CoreViewController

@property (weak, nonatomic) IBOutlet UITextField *patientFirstName;
@property (weak, nonatomic) IBOutlet UITextField *patientLastName;

@property (nonatomic, strong) Patient *addPatient;


- (IBAction)onCancelButtonTapped:(UIBarButtonItem *)sender;


- (IBAction)onSaveButtonTapped:(UIBarButtonItem *)sender;

@end
