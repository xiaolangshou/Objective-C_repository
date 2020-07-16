//
//  QueueProcess.h
//  CacheSampleBuffer
//
//  Created by 小东邪 on 08/01/2018.
//  Copyright © 2018 小东邪. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    CustomWorkQueue,
    CustomFreeQueue
} CustomQueueType;

typedef struct CustomQueueNode {
    void    *data;
    size_t  size;  // data size
    long    index;
    void    *userData;
    struct  CustomQueueNode *next;
} CustomQueueNode;

typedef struct CustomQueue {
    int size;
    CustomQueueType type;
    CustomQueueNode *front;
    CustomQueueNode *rear;
} CustomQueue;

class CustomQueueProcess {
    
private:
    pthread_mutex_t free_queue_mutex;
    pthread_mutex_t work_queue_mutex;
    
public:
    CustomQueue *m_free_queue;
    CustomQueue *m_work_queue;
    
    CustomQueueProcess();
    ~CustomQueueProcess();
    
    // Queue Operation
    void InitQueue(CustomQueue *queue,
                   CustomQueueType type);
    void EnQueue(CustomQueue *queue,
                 CustomQueueNode *node);
    CustomQueueNode *DeQueue(CustomQueue *queue);
    void ClearCustomQueue(CustomQueue *queue);
    void FreeNode(CustomQueueNode* node);
    void ResetFreeQueue(CustomQueue *workQueue, CustomQueue *FreeQueue);
    
    int  GetQueueSize(CustomQueue *queue);
};


