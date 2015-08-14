//
//  YLockView.m
//  手势解锁
//
//  Created by 杨立荣 on 15/8/13.
//  Copyright (c) 2015年 杨立荣. All rights reserved.
//

#import "YLockView.h"

@interface YLockView()

@property (nonatomic,strong) NSMutableArray *selectedBtn; //选中的所有按钮的数组

@property (nonatomic,assign) CGPoint lastPoint; //最后的连接点

@end

@implementation YLockView

- (NSMutableArray *)selectedBtn
{
    if (!_selectedBtn)
    {
        _selectedBtn = [NSMutableArray array];
    }
    return _selectedBtn;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setupBtn];
    }
    return self;
}

- (void) setupBtn
{
    for (NSInteger i = 0; i < 9; i ++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        btn.tag = i; //设置每个按钮的索引
        
        //设置默认的按钮图片
        [btn setImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
        
        //设置选中的按钮图片
        [btn setImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
        
        //设置按钮不可用
        btn.userInteractionEnabled = NO;
        
        [self addSubview:btn];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesMoved:touches withEvent:event];
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    //获取当前触摸点
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:touch.view];
    
    //判断当前的触摸点是否在按钮的范围内
    for (UIButton *btn in self.subviews)
    {
        if (CGRectContainsPoint(btn.frame, touchPoint))
        {
            if (btn.selected == NO)
            {
                //将选中的按钮存入数组中
                [self.selectedBtn addObject:btn];
            }else
            {
                // 如果触摸位置不在按钮范围内就记录这是最后的触摸点
                self.lastPoint = touchPoint;
            }
            
            btn.selected = YES;

        }
    }
    
    //重绘
    [self setNeedsDisplay];
}

//取消连线
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //拼接选中按钮的索引
    NSMutableString *password = [NSMutableString string];
    for (UIButton *selectedBtn in self.selectedBtn)
    {
        [password appendFormat:@"%ld",selectedBtn.tag];
    }
    
    NSLog(@"password:%@",password);
    
    //取消连线
    [self.selectedBtn makeObjectsPerformSelector:@selector(setSelected:) withObject:@NO];
    
    //移除所有选中按钮
    [self.selectedBtn removeAllObjects];
    
    //重绘
    [self setNeedsDisplay];
}


//画线
- (void)drawRect:(CGRect)rect
{
    NSInteger selectedCount = self.selectedBtn.count;
    
    //如果没有选中任何按钮则返回
    if (selectedCount == 0)
    {
        return;
    }
    
    //创建一个路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    for (NSInteger i = 0; i < selectedCount; i ++)
    {
        CGPoint btnCenter = [self.selectedBtn[i] center];
        if (i == 0)
        {
            [path moveToPoint:btnCenter];
        }else
        {
            [path addLineToPoint:btnCenter];
        }
    }
    
    //画最后一点的连线
    [path addLineToPoint:self.lastPoint];
    
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineCapStyle = kCGLineCapRound;
    
    path.lineWidth = 5;
    [[UIColor greenColor] set];
    [path stroke];
}

//计算每个按钮的位置
- (void)layoutSubviews
{
    NSInteger number = 3;
    CGFloat btnWidth = 74;
    CGFloat btnHeight = 74;
    CGFloat margin = (self.frame.size.width - btnWidth * 3) / 4;
    
    NSInteger btnCount = self.subviews.count;
    for (NSInteger i = 0; i < btnCount; i ++)
    {
        UIButton *btn = self.subviews[i];
        
        //当前按钮所处的列
        NSInteger column = i % number;
        CGFloat btnX = margin + (btnWidth + margin) * column;
        
        //当前按钮所处的行
        NSInteger row = i / number;
        CGFloat btnY = (btnHeight + margin) * row + margin;
        
        btn.frame = CGRectMake(btnX, btnY, btnWidth, btnHeight);
    }
}


@end



















