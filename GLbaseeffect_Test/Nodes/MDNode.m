//
//  MDNode.m
//  opencvdemo
//
//  Created by macist on 7/21/15.
//  Copyright (c) 2015 zen. All rights reserved.
//

#import "MDNode.h"
#import <OpenGLES/ES2/glext.h>

@implementation MDNode


- (instancetype)initWithName:(const char *)name shader:(GLKBaseEffect *)shader vertices:(Vertex *)vertices
                 vertexCount:(unsigned int)vertexCount {
    if ((self = [self init])) {
        
        // Initialize passed in variables
        _name = name;
        _vertexCount = vertexCount;
        _shader = shader;

        self.Position = GLKVector3Make(0, 0, 0);
        self.rotationX = 0;
        self.rotationY = 0;
        self.rotationZ = 0;
        self.scale = 1.0;
        self.children = [NSMutableArray array];
        
        if (vertices) {
            
    
            
            // Create the vertex array
            glGenVertexArraysOES(1, &_vao);
            glBindVertexArrayOES(_vao);

            // Generate the vertex buffer
            glGenBuffers(1, &_vertexBuffer);
            glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
            glBufferData(GL_ARRAY_BUFFER, vertexCount * sizeof(Vertex), vertices, GL_STATIC_DRAW);
            
            
            // Enable vertex attributes and set pointers
            glEnableVertexAttribArray(GLKVertexAttribPosition);
            glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE,
                                  sizeof(Vertex), (const GLvoid *) offsetof(Vertex, Position));
            
            glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
            glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE,
                                  sizeof(Vertex), (const GLvoid *) offsetof(Vertex, TexCoord));
            
            
            glEnableVertexAttribArray(GLKVertexAttribNormal);
            glVertexAttribPointer(GLKVertexAttribNormal, 3, GL_FLOAT, GL_FALSE,
                                  sizeof(Vertex), (const GLvoid *) offsetof(Vertex, Normal));
            
            
            // Reset bindings
            glBindVertexArrayOES(0);
            glBindBuffer(GL_ARRAY_BUFFER, 0);
        }
        
    }
    return self;
}

- (instancetype)initWithName:(const char *)name shader:(GLKBaseEffect *)shader vertices:(Vertex *)vertices vertexCount:(unsigned int)vertexCount textureName:(NSString *)textureName specularColor:(GLKVector4)specularColor diffuseColor:(GLKVector4)diffuseColor shininess:(float)shininess {
    if ((self = [self initWithName:name shader:shader vertices:vertices vertexCount:vertexCount])) {
        [self loadTexture:textureName];
        self.specularColor = specularColor;
        self.diffuseColor = diffuseColor;
        self.shininess = shininess;

        glActiveTexture(GL_TEXTURE0);
        
        GLKEffectPropertyTexture *tex = [[GLKEffectPropertyTexture alloc] init];
        tex.enabled = YES;
        tex.envMode = GLKTextureEnvModeDecal;
        tex.name = self.texture;
        
        shader.texture2d0.name = tex.name;
        
    }
    return self;
}

- (instancetype)initWithName:(const char *)name shader:(GLKBaseEffect *)shader vertices:(coloredVertex *)vertices
                 vertexCount:(unsigned int)vertexCount indices:(GLushort *)indices indexCount:(unsigned int)indexCount  {
    if ((self = [self init])) {
        
        // Initialize passed in variables
        _name = name;
        _vertexCount = vertexCount;
        _indexCount = indexCount;
        
        _shader = shader;
        self.position = GLKVector3Make(0, 0, 0);
        self.rotationX = 0;
        self.rotationY = 0;
        self.rotationZ = 0;
        self.scale = 1.0;
        self.children = [NSMutableArray array];
        
        if (vertices) {
            
            // Create the vertex array
            glGenVertexArraysOES(1, &_vao);
            glBindVertexArrayOES(_vao);
            
            
            NSLog(@"%lu",_vertexCount*sizeof(coloredVertex));
            // Generate the vertex buffer
            glGenBuffers(1, &_vertexBuffer);
            glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
            glBufferData(GL_ARRAY_BUFFER, _vertexCount*sizeof(coloredVertex), vertices, GL_STATIC_DRAW);
            
            
            glGenBuffers(1, &_indicesBuffer);
            glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indicesBuffer);
            if(indexCount>255){
                glBufferData(GL_ELEMENT_ARRAY_BUFFER, _indexCount*sizeof(GLushort), indices, GL_STATIC_DRAW);
            }else{
                glBufferData(GL_ELEMENT_ARRAY_BUFFER, _indexCount*sizeof(GLubyte), indices, GL_STATIC_DRAW);
            }
            
            // Enable vertex attributes and set pointers
            glEnableVertexAttribArray(GLKVertexAttribPosition);
            glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE,
                                  sizeof(coloredVertex), (const GLvoid *) offsetof(coloredVertex, Position));
            
            //            glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
            //            glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE,
            //                                  sizeof(coloredVertex), (const GLvoid *) offsetof(Vertex, TexCoord));
            
            glEnableVertexAttribArray(GLKVertexAttribColor);
            glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, sizeof(coloredVertex), (const GLvoid *) offsetof(coloredVertex, Color));
            
            glEnableVertexAttribArray(GLKVertexAttribNormal);
            glVertexAttribPointer(GLKVertexAttribNormal, 3, GL_FLOAT, GL_FALSE,sizeof(coloredVertex), (const GLvoid *) offsetof(coloredVertex, Normal));
            
            // Reset bindings
            glBindVertexArrayOES(0);
            glBindBuffer(GL_ARRAY_BUFFER, 0);
        }
        
    }
    return self;
}


- (void)loadTexture:(NSString *)filename {
    
    NSDictionary *options = @{ GLKTextureLoaderOriginBottomLeft: @YES };
    NSError *error;
    NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:nil];
    GLKTextureInfo *info = [GLKTextureLoader textureWithContentsOfFile:path options:options error:&error];
    if (info == nil) {
        NSLog(@"Error loading file: %@", error.localizedDescription);
    } else {
        self.texture = info.name;
        
      
    }
    
   
  
}

- (GLKMatrix4)modelMatrix {
    
    GLKMatrix4 modelMatrix = GLKMatrix4Identity;
    modelMatrix = GLKMatrix4Translate(modelMatrix, self.position.x, self.position.y, self.position.z);
    modelMatrix = GLKMatrix4Rotate(modelMatrix, self.rotationX, 1, 0, 0);
    modelMatrix = GLKMatrix4Rotate(modelMatrix, self.rotationY, 0, 1, 0);
    modelMatrix = GLKMatrix4Rotate(modelMatrix, self.rotationZ, 0, 0, 1);
    modelMatrix = GLKMatrix4Scale(modelMatrix, self.scale, self.scale, self.scale);
    return modelMatrix;
    
}

-(void)render:(GLKMatrix4)parentModelViewMatrix {
    
    GLKMatrix4 modelViewMatrix = GLKMatrix4Multiply(parentModelViewMatrix, [self modelMatrix]);
    for (MDNode * child in self.children) {
        [child render:modelViewMatrix];
    }
    
    if (_vao == 0) return;
    
    glPushGroupMarkerEXT(0, _name);
    {
        GLKMatrix4 modelViewMatrix = GLKMatrix4Multiply(parentModelViewMatrix, [self modelMatrix]);
        _shader.transform.modelviewMatrix = modelViewMatrix;
        _shader.light0.position = GLKVector4Make(0, 2, 3, 0);
     
        // Prepare the effect

        _shader.texture2d0.name = _texture;
        _shader.light0.enabled = GL_TRUE;
        _shader.light0.diffuseColor = _diffuseColor;
        
        _shader.light0.ambientColor = GLKVector4Make(1, 1, 1, 1.0);
        _shader.light0.specularColor = _specularColor;
        _shader.material.shininess = _shininess;
        _shader.lightingType = GLKLightingTypePerPixel;
        
        [_shader prepareToDraw];
        
        // Bind to the vertex object array for this model
        glBindVertexArrayOES(_vao);
        
     
        
        // Draw the model using triangles
        glDrawArrays(GL_TRIANGLES, 0, _vertexCount);
        
        // Important to unbind
        glBindVertexArrayOES(0);
    }
    glPopGroupMarkerEXT();
}


- (void)update:(float)dt {
    
//    GLKVector3 curMove = GLKVector3MultiplyScalar(GLKVector3Make(2, 0,0), dt);
//    self.position = GLKVector3Add(self.position, curMove);
    
//    self.rotationX+=dt;
//
//    if (self.rotationX>=0.3) {
//        self.rotationY+=0.055;
//    }
    
    for (MDNode * child in self.children) {
        child.rotationX+=dt;
    }
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
}

@end
