//
//  KModalDatePicker.h
//  CustomDatePicker
//
//  Created by Karthikeyan on 16/05/13.
//  Copyright (c) 2013 . All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ModalDatePickerCompletionBlock)(BOOL success , NSString *selectedDate);

@interface KModalDatePicker : UIView
/* Block to present date picker from given view */
-(void) presentWithDatePicker : (UIView *) view withBlock : (ModalDatePickerCompletionBlock) block;

@end
