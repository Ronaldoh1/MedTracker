//
//  PrescriptionTVC.h
//  MedTracker
//
//  Created by Ronald Hernandez on 11/26/15.
//  Copyright © 2015 HardCoders. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Patient.h"
#import "Prescription.h"
#import "PrescriptionTVC.h"

@interface PrescriptionTVC : UITableViewController <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) Patient *selectedPatient;

@end
