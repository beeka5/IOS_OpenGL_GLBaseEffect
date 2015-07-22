//
//  MainSceneViewController.m
//  opencvdemo
//
//  Created by macist on 7/21/15.
//  Copyright (c) 2015 zen. All rights reserved.
//

#import "MainSceneViewController.h"
#import "Sphere.h"
#import "RWDirector.h"
#import "SSScene.h"

@interface MainSceneViewController (){
    GLKBaseEffect * shader;
    
}

@property (strong, nonatomic) EAGLContext *context;
@property (strong, nonatomic) GLKBaseEffect *effect;

@end

@implementation MainSceneViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    if (!self.context) {
        NSLog(@"Failed to create ES context");
    }
    
    GLKView *view = (GLKView *)self.view;
    view.context = self.context;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    
    [self setupScene];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setupScene{
    
    [EAGLContext setCurrentContext:self.context];
    
    self.effect = [[GLKBaseEffect alloc] init];
    
    float aspect = fabsf(self.view.bounds.size.width / self.view.bounds.size.height);
    GLKMatrix4 projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(65.0f), aspect, 0.1, 1000.0f);
//    CGRect rect = self.view.bounds;
//    
//    GLKMatrix4 orthmatrix=GLKMatrix4MakeOrtho(-1.0,                                          // Left
//                                              1.0,                                          // Right
//                                              -1.0 / (rect.size.width / rect.size.height),   // Bottom
//                                              1.0 / (rect.size.width / rect.size.height),   // Top
//                                              0.01,                                         // Near
//                                              10000.0);
    self.effect.transform.projectionMatrix = projectionMatrix;
    
    
    [RWDirector sharedInstance].scene = [[SSScene alloc] initWithShader:self.effect];
    
    [RWDirector sharedInstance].view = self.view;
    
    

}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    
    glClearColor(0, 0, 0, 1);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glEnable(GL_DEPTH_TEST);
//    glShadeModel(GL_SMOOTH);
    
    [[RWDirector sharedInstance].scene render:GLKMatrix4Identity];

    
}

-(void)update{
    
    [[RWDirector sharedInstance].scene update:0.05];
}

 
 - (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
 [[RWDirector sharedInstance].scene touchesBegan:touches withEvent:event];
 }
 
 - (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
 [[RWDirector sharedInstance].scene touchesMoved:touches withEvent:event];
 }
 
 - (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
 [[RWDirector sharedInstance].scene touchesEnded:touches withEvent:event];
 }
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
