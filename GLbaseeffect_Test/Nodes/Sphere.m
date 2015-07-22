//
//  Cube.m
//  opencvdemo
//
//  Created by macist on 7/21/15.
//  Copyright (c) 2015 zen. All rights reserved.
//

#import "Sphere.h"
#import "ball.h"

@implementation Sphere


-(id)initWithShader:(GLKBaseEffect*)shader{
    if (self==[super initWithName:"Ball"
                           shader:shader
                         vertices:(Vertex *)Ball_Sphere_ball_Vertices
                      vertexCount:sizeof(Ball_Sphere_ball_Vertices)/sizeof(Ball_Sphere_ball_Vertices[0])
                      textureName:@"ball.png"
                    specularColor:Ball_Sphere_ball_specular
                     diffuseColor:Ball_Sphere_ball_diffuse
                        shininess:Ball_Sphere_ball_shininess
               ]) {
        
        //custom initializetion
    }
    return self;
}

@end
