//
//  EPPZDecoupledView.m
//  UIView_from_Xib
//
//  Created by Borbás Geri on 2/25/14.
//  Copyright (c) 2014 eppz! development, LLC.
//
//  follow http://www.twitter.com/_eppz
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "EPPZDecoupledView.h"


@interface EPPZDecoupledViewOwner : NSObject
@property (nonatomic, weak) IBOutlet EPPZDecoupledView *decoupledView;
@end

@implementation EPPZDecoupledViewOwner
@end

@interface EPPZDecoupledView ()
@property (nonatomic, weak) UIViewController <EPPZDecoupledViewDelegate> *delegateViewController;
@end

@implementation EPPZDecoupledView

+(void)presentInViewController:(UIViewController<EPPZDecoupledViewDelegate>*) viewController
{
    // Instantiating encapsulated here.
    EPPZDecoupledViewOwner *owner = [EPPZDecoupledViewOwner new];
    [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:owner options:nil];
    
    // Pass in a reference of the viewController.
    owner.decoupledView.delegateViewController = viewController;
    
    // Add (thus retain).
    [viewController.view addSubview:owner.decoupledView];
}

-(IBAction)viewTouchedUp
{
    // Forward to delegate.
    [self.delegateViewController decoupledViewTouchedUp:self];
}

-(IBAction)dismiss
{
    [self removeFromSuperview];
    
    // Forward to delegate.
    [self.delegateViewController decoupledViewDidDismiss:self];
}

@end
