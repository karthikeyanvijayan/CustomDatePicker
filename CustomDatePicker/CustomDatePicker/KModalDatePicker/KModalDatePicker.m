//
//  KModalDatePicker.m
//  CustomDatePicker
//
//  Created by Karthikeyan on 16/05/13.
//  Copyright (c) 2013. All rights reserved.
//

#import "KModalDatePicker.h"

#define KPICKER_PANEL_HEIGHT 260
#define KPICKER_TOOLBAR_HEIGHT 44
#define KPICKER_BACKDROP_OPACITY 0.8

#define CGRECT(x,y,w,h) CGRectMake(x,y,w,h)


@interface KModalDatePicker () {
    
    UIView *_backDropView;
    UIView *_panel;
    UIDatePicker *_datePicker;
    UIToolbar *_toolBar;
}

@property (nonatomic,strong) ModalDatePickerCompletionBlock callBlock;

@property (nonatomic,copy) NSString *selectedDateString;


@end

@implementation KModalDatePicker


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void) onDone : (id) sender {
    self.callBlock(YES,_selectedDateString);
    [self dismissPicker];
}

-(void) onCancel : (id) sender {
    self.callBlock(NO,_selectedDateString);
    [self dismissPicker];
}

-(void) dismissPicker {
    [UIView animateWithDuration:0.25 delay:0
                        options:UIViewAnimationCurveEaseOut
                     animations:^{
                         CGRect newFrame = _panel.frame;
                         newFrame.origin.y += _panel.frame.size.height;
                         _panel.frame = newFrame;
                         _backDropView.alpha = 0;
                     } completion:^(BOOL finished) {
                         [_panel removeFromSuperview];
                         _panel = nil;
                         
                         [_backDropView removeFromSuperview];
                         _backDropView = nil;
                         
                         [self removeFromSuperview];
                     }];
    
}


/// Tool Bar
-(UIToolbar *) toolbar {
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRECT(0, 0,self.bounds.size.width,KPICKER_TOOLBAR_HEIGHT)];
    toolbar.barStyle = UIBarStyleBlackTranslucent;
    
    toolbar.items = @[
                      [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel           target:self action:@selector(onCancel:)],
                      [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(onDone:)]];
    
    return toolbar;
}

/// BackDrop View

-(UIView *) backdropView {
    
    UIView *bkDropView = [[UIView alloc] initWithFrame:self.bounds];
    bkDropView.backgroundColor = [UIColor colorWithWhite:0 alpha:KPICKER_BACKDROP_OPACITY];
    bkDropView.alpha = 0;
    
    UIGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(onCancel:)];
    [bkDropView addGestureRecognizer:tapGesture];
    
    return bkDropView;
    
    
}


/* display Date Selected Date. */

-(void) dateSeletedAction : (id) sender {
    _selectedDateString = _datePicker.date.description;
}

-(UIDatePicker *) datePicker {
    
    UIDatePicker *datePickerTemp = [[UIDatePicker alloc] initWithFrame:CGRECT(0,KPICKER_TOOLBAR_HEIGHT, self.bounds.size.width,KPICKER_PANEL_HEIGHT - KPICKER_TOOLBAR_HEIGHT)];
    [datePickerTemp addTarget:self action:@selector(dateSeletedAction:) forControlEvents:UIControlEventValueChanged];
      datePickerTemp.datePickerMode = UIDatePickerModeDate;
    return datePickerTemp;
}

/* Present Date Picker with Blocks */


-(void) presentWithDatePicker : (UIView *) view withBlock : (ModalDatePickerCompletionBlock) block {
    
    self.frame = view.bounds;
    self.callBlock = block;
    
    [_panel removeFromSuperview];
    [_backDropView removeFromSuperview];
    
    
    _panel = [[UIView alloc] initWithFrame:CGRECT(0,self.frame.size.height - KPICKER_PANEL_HEIGHT,self.frame.size.width,KPICKER_PANEL_HEIGHT)];
    _datePicker = [self datePicker];
    _toolBar = [self toolbar];
    
    _backDropView = [self backdropView];
    [self addSubview:_backDropView];
    
    [_panel addSubview:_datePicker];
    [_panel addSubview:_toolBar];
    
    [self addSubview:_panel];
    [view addSubview:self];
    
    
    
    CGRect oldFrame = _panel.frame;
    CGRect newFrame = _panel.frame;
    newFrame.origin.y += newFrame.size.height;
    _panel.frame = newFrame;
    
    
    [UIView animateWithDuration:0.25 delay:0
                        options:UIViewAnimationCurveEaseOut
                     animations:^{
                         _panel.frame = oldFrame;
                         _backDropView.alpha = 0.1;
                     } completion:^(BOOL finished) {
                         
                     }];

    
    
}


@end
