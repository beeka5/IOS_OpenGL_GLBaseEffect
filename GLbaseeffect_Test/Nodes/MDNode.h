//
//  MDNode.h
//  opencvdemo
//
//  Created by macist on 7/21/15.
//  Copyright (c) 2015 zen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import "vertex.h"

@interface MDNode : NSObject{
    const char *_name;
    GLuint _vao;
    GLuint texName;
    GLuint _vertexBuffer;
    GLuint _indicesBuffer;
    unsigned int _vertexCount;
    unsigned int _indexCount;
    GLKBaseEffect *_shader;
}

@property(nonatomic)GLKBaseEffect * shader;

@property(nonatomic)GLKVector3 position;

@property (nonatomic) float rotationX;
@property (nonatomic) float rotationY;
@property (nonatomic) float rotationZ;

@property (nonatomic) float scale;

@property (nonatomic)GLuint texture;
@property (nonatomic, assign) GLKVector4 specularColor;
@property (nonatomic, assign) GLKVector4 diffuseColor;
@property (nonatomic, assign) float shininess;

@property (nonatomic, strong) NSMutableArray *children;
@property (nonatomic, assign) float width;
@property (nonatomic, assign) float height;


- (instancetype)initWithName:(const char *)name shader:(GLKBaseEffect *)shader vertices:(Vertex *)vertices vertexCount:(unsigned int)vertexCount;
- (instancetype)initWithName:(const char *)name shader:(GLKBaseEffect *)shader vertices:(Vertex *)vertices vertexCount:(unsigned int)vertexCount textureName:(NSString *)textureName specularColor:(GLKVector4)specularColor diffuseColor:(GLKVector4)diffuseColor shininess:(float)shininess;
//draw using indices for gldrawelement
- (instancetype)initWithName:(const char *)name shader:(GLKBaseEffect *)shader vertices:(coloredVertex *)vertices vertexCount:(unsigned int)vertexCount indices:(GLushort *)indices indexCount:(unsigned int)indexCount;
- (instancetype)initWithName:(const char *)name shader:(GLKBaseEffect *)shader vertices:(coloredVertex *)vertices vertexCount:(unsigned int)vertexCount indices:(GLushort *)indices indexCount:(unsigned int)indexCount  textureName:(NSString *)textureName specularColor:(GLKVector4)specularColor diffuseColor:(GLKVector4)diffuseColor shininess:(float)shininess;

- (id)initWithFile:(NSString *)fileName effect:(GLKBaseEffect *)effect;
-(void)render:(GLKMatrix4)parentModelViewMatrix;
- (void)update:(float)dt;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;


@end
