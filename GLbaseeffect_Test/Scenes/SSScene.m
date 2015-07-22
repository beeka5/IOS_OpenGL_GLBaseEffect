//
//  SSScene.m
//  OpenGLTest
//
//  Created by macist on 7/21/15.
//  Copyright (c) 2015 zen. All rights reserved.
//

#import "SSScene.h"
#import "Sphere.h"


@implementation SSScene{
    CGSize _gameArea;
    float _sceneOffset;
     NSMutableArray *planets;
    
}


- (instancetype)initWithShader:(GLKBaseEffect *)shader {
    if ((self = [super initWithName:"RWGameScene" shader:shader vertices:nil vertexCount:0])) {
        
        // Create initial scene position (i.e. camera)
//        _gameArea = CGSizeMake(27, 48);
//        _sceneOffset = _gameArea.height/2 / tanf(GLKMathRadiansToDegrees(85.0));
//        self.position = GLKVector3Make(0,9,0);
        self.rotationX = GLKMathDegreesToRadians(5);
        
        for (int i=0; i<1; i++) {
            Sphere * sp=[[Sphere alloc] initWithShader:shader];
            sp.position=GLKVector3Make(0,0, -1*(i+2));
            sp.scale=0.9;
            [planets addObject:sp];
            [self.children addObject:sp];
        }
    
        

    }
    return self;

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
}


@end
