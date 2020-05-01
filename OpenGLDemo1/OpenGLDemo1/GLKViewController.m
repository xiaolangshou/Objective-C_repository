//
//  GLKViewController.m
//  OpenGLDemo1
//
//  Created by Thomas Lau on 2020/4/3.
//  Copyright © 2020 TLLTD. All rights reserved.
//

#import "GLKViewController.h"
#import <GLKit/GLKit.h>

/**
 定义顶点类型
 */
typedef struct {
    GLKVector3 positionCoord; // (X, Y, Z)
    GLKVector2 textureCoord; // (U, V)
} SenceVertex;

@interface GLKViewController ()

@property (strong, nonatomic) GLKView *glkView;
@property (strong, nonatomic) GLKBaseEffect *baseEffect;
@property (assign, nonatomic) SenceVertex *vertices;

@end

@implementation GLKViewController

- (void)dealloc {
    
    if ([EAGLContext currentContext] == self.glkView.context) {
        [EAGLContext setCurrentContext: nil];
    }
    if (_vertices) {
        free(_vertices);
        _vertices = nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self commit];
    [self.glkView display];
    
}

- (void)commit {
    
    EAGLContext *context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    self.vertices = malloc(sizeof(SenceVertex) * 4);
    self.vertices[0] = (SenceVertex){{-1, 1, 0}, {0, 1}}; //左上角
    self.vertices[1] = (SenceVertex){{-1, -1, 0}, {0, 0}}; // 左下角
    self.vertices[2] = (SenceVertex){{1, 1, 0}, {1, 1}}; // 右上角
    self.vertices[3] = (SenceVertex){{1, -1, 0}, {1, 0}}; // 右下角
    
    CGRect frame = CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.width);
    self.glkView = [[GLKView alloc] initWithFrame:frame context:context];
    self.glkView.backgroundColor = [UIColor clearColor];
    self.glkView.delegate = self;
    
    [self.view addSubview:self.glkView];
    
    [EAGLContext setCurrentContext:self.glkView.context];
    NSString *imagePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"sample.jpg"];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    
    NSDictionary *options = @{GLKTextureLoaderOriginBottomLeft : @(YES)};
    GLKTextureInfo *textureInfo = [GLKTextureLoader textureWithCGImage:[image CGImage]
    options:options
      error:NULL];
    self.baseEffect = [[GLKBaseEffect alloc] init];
    self.baseEffect.texture2d0.name = textureInfo.name;
    self.baseEffect.texture2d0.target = textureInfo.target;
}

#pragma mark -GLKViewDelegate

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    [self.baseEffect prepareToDraw];
    
    // 创建顶点缓存
    GLuint vertexBuffer;
    glGenBuffers(1, &vertexBuffer);  // 步骤一：生成
    glBindBuffer(GL_ARRAY_BUFFER, vertexBuffer);  // 步骤二：绑定
    GLsizeiptr bufferSizeBytes = sizeof(SenceVertex) * 4;
    glBufferData(GL_ARRAY_BUFFER, bufferSizeBytes, self.vertices, GL_STATIC_DRAW);  // 步骤三：缓存数据
    
    // 设置顶点数据
    glEnableVertexAttribArray(GLKVertexAttribPosition);  // 步骤四：启用或禁用
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(SenceVertex), NULL + offsetof(SenceVertex, positionCoord));  // 步骤五：设置指针
    
    // 设置纹理数据
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);  // 步骤四：启用或禁用
    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, sizeof(SenceVertex), NULL + offsetof(SenceVertex, textureCoord));  // 步骤五：设置指针
    
    // 开始绘制
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);  // 步骤六：绘图
    
    // 删除顶点缓存
    glDeleteBuffers(1, &vertexBuffer);  // 步骤七：删除
    vertexBuffer = 0;
}

@end
