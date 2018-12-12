//
//  GQGL1ViewController.m
//  PGQDemo
//
//  Created by Lois_pan on 2018/7/6.
//  Copyright © 2018年 Lois_pan. All rights reserved.
//

#import "GQGL1ViewController.h"

@implementation GQGL1ViewController

- (void)drawView {
    const GLfloat triangleVertices[] = {
        0.0, 1.0, -6.0,       //top
        -1.0, -1.0, -6.0,     //bottom left
        1.0, -1.0, -6.0       //bottom right
    };
    
    EAGLContext * content = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
    [EAGLContext setCurrentContext: content];

    
//    glBindFramebuffer(GL_FRAMEBUFFER_OES, view)
    
}

@end
