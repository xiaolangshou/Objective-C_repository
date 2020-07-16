//
//  QueueProcess.m
//  CacheSampleBuffer
//
//  Created by 小东邪 on 08/01/2018.
//  Copyright © 2018 小东邪. All rights reserved.
//

#import "QueueProcess.h"
#import <pthread.h>
#include "log4cplus.h"

#pragma mark - Queue Size   设置队列的长度，不可过长
const int CustomQueueSize = 20;

const static char *kModuleName = "QueueProcess";

#pragma mark - Init
CustomQueueProcess::CustomQueueProcess() {
    m_free_queue = (CustomQueue *)malloc(sizeof(struct CustomQueue));
    m_work_queue = (CustomQueue *)malloc(sizeof(struct CustomQueue));
    
    InitQueue(m_free_queue, CustomFreeQueue);
    InitQueue(m_work_queue, CustomWorkQueue);
    
    for (int i = 0; i < CustomQueueSize; i++) {
        CustomQueueNode *node = (CustomQueueNode *)malloc(sizeof(struct CustomQueueNode));
        node->data = NULL;
        node->size = 0;
        node->index= 0;
        this->EnQueue(m_free_queue, node);
    }
    
    pthread_mutex_init(&free_queue_mutex, NULL);
    pthread_mutex_init(&work_queue_mutex, NULL);
    
    log4cplus_info(kModuleName, "%s: Init finish !",__func__);
}

void CustomQueueProcess::InitQueue(CustomQueue *queue, CustomQueueType type) {
    if (queue != NULL) {
        queue->type  = type;
        queue->size  = 0;
        queue->front = 0;
        queue->rear  = 0;
    }
}

#pragma mark - Main Operation
void CustomQueueProcess::EnQueue(CustomQueue *queue, CustomQueueNode *node) {
    if (queue == NULL) {
        log4cplus_debug(kModuleName, "%s: current queue is NULL",__func__);
        return;
    }
    
    if (node==NULL) {
        log4cplus_debug(kModuleName, "%s: current node is NUL",__func__);
        return;
    }
    
    node->next = NULL;
    
    if (CustomFreeQueue == queue->type) {
        pthread_mutex_lock(&free_queue_mutex);
        
        if (queue->front == NULL) {
            queue->front = node;
            queue->rear  = node;
        }else {
            /*
             // tail in,head out
             freeQueue->rear->next = node;
             freeQueue->rear = node;
             */
            
            // head in,head out
            node->next = queue->front;
            queue->front = node;
        }
        queue->size += 1;
        log4cplus_debug(kModuleName, "%s: free queue size=%d",__func__,queue->size);
        pthread_mutex_unlock(&free_queue_mutex);
    }
    
    if (CustomWorkQueue == queue->type) {
        pthread_mutex_lock(&work_queue_mutex);
        //TODO
        static long nodeIndex = 0;
        node->index=(++nodeIndex);
        if (queue->front == NULL) {
            queue->front = node;
            queue->rear  = node;
        }else {
            queue->rear->next   = node;
            queue->rear         = node;
        }
        queue->size += 1;
        log4cplus_debug(kModuleName, "%s: work queue size=%d",__func__,queue->size);
        pthread_mutex_unlock(&work_queue_mutex);
    }
}

CustomQueueNode* CustomQueueProcess::DeQueue(CustomQueue *queue) {
    if (queue == NULL) {
        log4cplus_debug(kModuleName, "%s: current queue is NULL",__func__);
        return NULL;
    }
    
    const char *type = queue->type == CustomWorkQueue ? "work queue" : "free queue";
    pthread_mutex_t *queue_mutex = ((queue->type == CustomWorkQueue) ? &work_queue_mutex : &free_queue_mutex);
    CustomQueueNode *element = NULL;
    
    pthread_mutex_lock(queue_mutex);
    element = queue->front;
    if(element == NULL) {
        pthread_mutex_unlock(queue_mutex);
        log4cplus_debug(kModuleName, "%s: The node is NULL",__func__);
        return NULL;
    }
    
    queue->front = queue->front->next;
    queue->size -= 1;
    pthread_mutex_unlock(queue_mutex);
    
    log4cplus_debug(kModuleName, "%s: type=%s size=%d",__func__,type,queue->size);
    return element;
}

void CustomQueueProcess::ResetFreeQueue(CustomQueue *workQueue, CustomQueue *freeQueue) {
    if (workQueue == NULL) {
        log4cplus_debug(kModuleName, "%s: The WorkQueue is NULL",__func__);
        return;
    }
    
    if (freeQueue == NULL) {
        log4cplus_debug(kModuleName, "%s: The FreeQueue is NULL",__func__);
        return;
    }
    
    int workQueueSize = workQueue->size;
    if (workQueueSize > 0) {
        for (int i = 0; i < workQueueSize; i++) {
            CustomQueueNode *node = DeQueue(workQueue);
            node->data = NULL;
            EnQueue(freeQueue, node);
        }
    }
    log4cplus_info(kModuleName, "%s: ResetFreeQueue : The work queue size is %d, free queue size is %d",__func__,workQueue->size, freeQueue->size);
}

void CustomQueueProcess::ClearCustomQueue(CustomQueue *queue) {
    while (queue->size) {
        CustomQueueNode *node = this->DeQueue(queue);
        this->FreeNode(node);
    }

    log4cplus_info(kModuleName, "%s: Clear CustomQueueProcess queue",__func__);
}

void CustomQueueProcess::FreeNode(CustomQueueNode* node) {
    if(node != NULL){
        free(node->data);
        free(node);
    }
}

int CustomQueueProcess::GetQueueSize(CustomQueue *queue) {
    pthread_mutex_t *queue_mutex = ((queue->type == CustomWorkQueue) ? &work_queue_mutex : &free_queue_mutex);
    int size;
    pthread_mutex_lock(queue_mutex);
    size = queue->size;
    pthread_mutex_unlock(queue_mutex);
    
    return size;
}
