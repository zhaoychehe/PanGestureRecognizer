//
//  ViewController.m
//  手势
//
//  Created by 赵燕超 on 2017/9/3.
//  Copyright © 2017年 yc.test. All rights reserved.
//

#import "ViewController.h"

typedef NS_ENUM(NSUInteger, UIPanGestureRecognizerDirection) {
    UIPanGestureRecognizerDirectionUndefined,
    UIPanGestureRecognizerDirectionUp,
    UIPanGestureRecognizerDirectionDown,
    UIPanGestureRecognizerDirectionLeft,
    UIPanGestureRecognizerDirectionRight
};

@interface ViewController () <UIGestureRecognizerDelegate>

@property (nonatomic, assign) CGPoint currentPoint;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIPanGestureRecognizer  *panGesture=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureDown:)];
    panGesture.delegate=self;
    [self.view addGestureRecognizer:panGesture];
    
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldReceiveTouch:(UITouch*)touch{
    
    // NSLog(@"touch.view=====%@",touch.view);
    if([touch.view isKindOfClass:[UISlider class]]){
        return NO;
    }else{
        return YES;
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    self.currentPoint = [[touches anyObject] locationInView:self.view];
}

-(void)panGestureDown:(UIPanGestureRecognizer*)sender{
    
    CGPoint point= [sender locationInView:self.view];// 上下控制点
    CGPoint tranPoint=[sender translationInView:self.view];//播放进度
    
    static UIPanGestureRecognizerDirection direction = UIPanGestureRecognizerDirectionUndefined;
    switch (sender.state) {
        case UIGestureRecognizerStateBegan: {
            if (direction == UIPanGestureRecognizerDirectionUndefined) {
                CGPoint velocity = [sender velocityInView:self.view];
                BOOL isVerticalGesture = fabs(velocity.y) > fabs(velocity.x);
                if (isVerticalGesture) {
                    if (velocity.y > 0) {
                        direction = UIPanGestureRecognizerDirectionDown;
                    } else {
                        direction = UIPanGestureRecognizerDirectionUp;
                    }
                }
                else {
                    if (velocity.x > 0) {
                        direction = UIPanGestureRecognizerDirectionRight;
                    } else {
                        direction = UIPanGestureRecognizerDirectionLeft;
                    }
                }
            }
            break;
        }
        case UIGestureRecognizerStateChanged: {
            
            switch (direction) {
                case UIPanGestureRecognizerDirectionUp: {
                    float dy = point.y - _currentPoint.y;
                    int index = (int)dy;
                    NSLog(@"上%d", index);
                    break;
                }
                case UIPanGestureRecognizerDirectionDown: {
                    float dy = point.y - _currentPoint.y;
                    int index = (int)dy;
                    NSLog(@"下%d", index);
                    break;
                }
                case UIPanGestureRecognizerDirectionLeft: {
                    NSLog(@"左%.2f", tranPoint.x);
                    break;
                }
                case UIPanGestureRecognizerDirectionRight: {
                    NSLog(@"右%.2f", tranPoint.x);
                    break;
                }
                default: {
                    break;
                }
            }
            break;
        }
        case UIGestureRecognizerStateEnded: {
            direction = UIPanGestureRecognizerDirectionUndefined;
            NSLog(@"结束");
            break;
        }
        default:
            break;
    }
}

@end
