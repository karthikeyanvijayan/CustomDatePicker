//
//  ViewController.m
//  CustomDatePicker
//
//  Created by Karthikeyan on 16/05/13.
//  Copyright (c) 2013 . All rights reserved.
//

#import "ViewController.h"
#import "KModalDatePicker.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickmeAction:(id)sender {
    KModalDatePicker *modelDatePicker = [[KModalDatePicker alloc] init];
    [modelDatePicker presentWithDatePicker:self.view withBlock:^(BOOL success, NSString *selectedDate) {
        NSLog(@"selected date Value : %@",selectedDate);
    }];
    
}

@end
