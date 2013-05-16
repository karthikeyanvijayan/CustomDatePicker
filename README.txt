CUSTOM DATE PICKER

created by Karthikeyan

-----------------------------

To use this - type the following : 

 KModalDatePicker *modelDatePicker = [[KModalDatePicker alloc] init];
    [modelDatePicker presentWithDatePicker:self.view withBlock:^(BOOL success, NSString *selectedDate) {
        if (success) {
            NSLog(@"selected date Value : %@",selectedDate);
        }
    }];