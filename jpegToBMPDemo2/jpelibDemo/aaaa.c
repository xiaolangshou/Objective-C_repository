//
//  aaaa.c
//  CDemo
//
//  Created by GangLing Wei on 2020/4/30.
//  Copyright © 2020 GangLing Wei. All rights reserved.
//

#include "aaaa.h"

#include<stdio.h>
#include<stdlib.h>
#include<string.h>


typedef unsigned short WORD;//2*8=16
typedef unsigned long DWORD;//4*8=32
typedef long LONG;//4*8=32
typedef unsigned char BYTE;//1*8=8


#pragma pack(1)
typedef struct tagRGBQUAD
{ /*颜色表用于说明位图中的颜色，它有若干个表项
                      ，每一个表项是一个RGBQUAD类型的结构，定义一种颜色。*/
    BYTE rgbBlue; /*蓝色的亮度(值范围为0-255)*/
    BYTE rgbGreen; /*绿色的亮度(值范围为0-255) */
    BYTE rgbRed;/*红色的亮度(值范围为0-255)*/
    BYTE rgbReserved; /*保留，必须为0 */
}RGBQUAD;/*颜色表中RGBQUAD结构数据的个数有biBitCount来确定:
　　 当biBitCount=1,4,8时，分别有2,16,256个表项;
　　 当biBitCount=24时，没有颜色表项。*/
#pragma pack()




/*位图文件头*/
#pragma pack(1)//单字节对齐
typedef struct tagBITMAPFILEHEADER1
{
  unsigned char bfType[2];//文件格式
  unsigned int bfSize;//文件大小
  unsigned short bfReserved1;//保留
  unsigned short bfReserved2;//保留
  unsigned int bfOffBits;//数据偏移量
}fileHeader1;
#pragma pack()

/*位图信息头*/
#pragma pack(1)
typedef struct tagBITMAPINFOHEADER1
{
  unsigned int biSize;//BITMAPINFOHEADER结构所需要的字数
  int biWidth;//图像宽度，像素为单位
  int biHeight;//图像高度，像素为单位，为正数，图像是倒序的，为负数，图像是正序的
  unsigned short biPlanes;//为目标设备说明颜色平面数，总被置为1
  unsigned short biBitCount;//说明比特数/像素
  unsigned int biCompression;//说明数据压缩类型
  unsigned int biSizeImage;//说明图像大小，字节单位
  int biXPixPerMeter;//水平分辨率，像素/米
  int biYPixPerMeter;//垂直分辨率
  unsigned int biClrUsed;//颜色索引数
  unsigned int biClrImportant;//重要颜色索引数，为0表示都重要
}fileInfo1;
#pragma pack()

//自定义的有关图像处理的头文件为rgbtogray.h

//系统定义有关图像处理的头文件为windows.h

//目前，引用系统的windows.h程序工作正常，但自己的头文件有问题，待改正！

//最终实现引用自己的头文件rgbtogray.h

//太棒了：头文件的问题终于解决了

  //#include

//#include "rgbtogray.h"


//全局变量声明

FILE * fpSrcBmpfile;//定义文件指针，用于读入和存储图像文件

FILE * fpDestBmpfile;


void SetRGBQUAD(void);//建立颜色板并存入灰度图文件中




void SetRGBQUAD()
{
    int i;
    RGBQUAD rgbquad[256];
    for(i=0;i<256;i++) {
        rgbquad[i].rgbBlue = i;
        rgbquad[i].rgbGreen = i;
        rgbquad[i].rgbRed = i;
        rgbquad[i].rgbReserved = 0;
    }
    fwrite(rgbquad, 256 * sizeof(RGBQUAD), 1, fpDestBmpfile);
}

void SetRGBQUAD1(fileInfo1 *bmih,char *SrcBmpfile)
{

    FILE * file=fopen(SrcBmpfile,"rb");

    unsigned char *data;
    data=(unsigned char *)malloc(3*sizeof(unsigned char));

    unsigned int *array;
    array = (unsigned int *)malloc(bmih->biSizeImage*sizeof(unsigned int));

    unsigned char count24=(4-(bmih->biWidth*3)%4)%4;
    int k = 0;
    for(int h=bmih->biHeight;h>=0;h--)
    {
       for(int w=0;w<bmih->biWidth;w++)
        {
            fread(data,3,1,file);
            
           unsigned char b=*data;
           unsigned char g=*(data+1);
           unsigned char r=*(data+2);
            int b1 = b;
            int g1 = g;
            int r1 = r;
            int rgb = r1 * 1000000 + g1 * 1000 + b1;
            array[k] = rgb;
//           unsigned char *rgb;
            
            k++;
//            printf("r = %d,g = %d,b = %d\n",r,g,b);
        }
        fseek(file,count24,SEEK_CUR);
    }
    free(data);
    
    // 冒泡
    int temp, isSorted;
    for(int i=0; i<bmih->biSizeImage-1; i++){
        isSorted = 1;  //假设剩下的元素已经排序好了
        for(int j=0; j<bmih->biSizeImage-1-i; j++){
            if(array[j] > array[j+1]){
                temp = array[j];
                array[j] = array[j+1];
                array[j+1] = temp;
                isSorted = 0;  //一旦需要交换数组元素，就说明剩下的元素没有排序好
            }
        }
        if(isSorted) break; //如果没有发生交换，说明剩下的元素已经排序好了
    }
    
    int count = bmih->biSizeImage / 256;
    int p = 0;
    RGBQUAD rgbquad[256];
    for(int i=0;i<256;i++) {
        double total = 0;
        for (int j = p; j < p + count; j++) {
            int rbg = array[j];
            total += rbg;
        }
        p += count;
        
        int average = total / count;
        int r = average / 1000000;
        int g = (average - r * 1000000) / 1000;
        int b = (average - r * 1000000 - g * 1000);
        printf("i:%d r = %d,g = %d,b = %d\n",i,r,g,b);
        rgbquad[i].rgbBlue = (BYTE)b;
        rgbquad[i].rgbGreen = (BYTE)g;
        rgbquad[i].rgbRed = (BYTE)r;
        rgbquad[i].rgbReserved = 0;
    }
    fwrite(rgbquad, 256 * sizeof(RGBQUAD), 1, fpDestBmpfile);
//    for (int j = 0; j < bmih->biSizeImage; j++) {
//        printf("array[%d] = %d\n",j,array[j]);
//    }
//    printf("k = %d",k);
}
//函数体部分(主)

int RgbToGray(char *SrcBmpfile, char *DestBmpfile)
{
    LONG w,h;
    BYTE r,g,b;
    BYTE gray;
    BYTE count24,count8;
    BYTE Bmpnul=0;

//    char SrcBmpfile[256];
//    char DestBmpfile[256];
    BYTE *data;
    
    data=(BYTE *)malloc(3*sizeof(BYTE));
    if(!data)
    {
       printf("Error:Can not allocate memory .\n");
       free(data);
       return -1;
    }

    if((fpSrcBmpfile=fopen(SrcBmpfile,"rb"))==NULL)
    {
        printf("Error:Open the file of SrcBmpfile failed!\n");//输入源位图文件

        free(data);
        return -1;
    }
    
    
    fileHeader1 *bmfh;//位图文件头
    fileInfo1 *bmih;//位图信息头
    
    bmfh=(fileHeader1 *)malloc(sizeof(fileHeader1));
    bmih=(fileInfo1 *)malloc(sizeof(fileInfo1));
    
    /*读入源位图文件头和信息头*/
    fread(bmfh,sizeof(fileHeader1),1,fpSrcBmpfile);
    fread(bmih,sizeof(fileInfo1),1,fpSrcBmpfile);

    if((fpDestBmpfile=fopen(DestBmpfile,"wb"))==NULL)
    {
        printf("Error:Open the file of DestBmpfile failed!\n");
        free(data);
        return -1;
    }
    bmih->biBitCount = 8; // 24 或者 8

    bmih->biClrUsed = 256;
    bmfh->bfOffBits = 54 + bmih->biClrUsed * sizeof(RGBQUAD);
    bmih->biSizeImage = ((((bmih->biWidth * bmih->biBitCount) + 31) & ~31) / 8) * bmih->biHeight;
    bmfh->bfSize = bmfh->bfOffBits + bmih->biSizeImage;
    
    fwrite(bmfh,sizeof(fileHeader1),1,fpDestBmpfile);
    fwrite(bmih,sizeof(fileInfo1),1,fpDestBmpfile);
    
    SetRGBQUAD();
    
//    SetRGBQUAD1(bmih,SrcBmpfile);

    count24=(4-(bmih->biWidth*3)%4)%4;
    count8=(4-(bmih->biWidth)%4)%4;

    for(h=bmih->biHeight-1;h>=0;h--)
    {
        for(w=0;w<bmih->biWidth;w++)
        {
            fread(data,3,1,fpSrcBmpfile);
            if(feof(fpSrcBmpfile))
            {
                printf("Error:Read Pixel data failed!\n");
                free(data);
                return -1;
            }
            b=*data;
            g=*(data+1);
            r=*(data+2);
            gray=(299*r+587*g+114*b)/1000;
            // if(gray>120)gray=250;
            // printf("%hhu\n",gray);
            fwrite(&gray,sizeof(gray),1,fpDestBmpfile);
        }
        fseek(fpSrcBmpfile,count24,SEEK_CUR);
        fwrite(&Bmpnul,1,count8,fpDestBmpfile);
    }
    
    free(data);//释放内存空间

    fclose(fpDestBmpfile);//关闭文件指针

    fclose(fpSrcBmpfile);
    
    printf("8位bmp生成成功\n");
    return 0;
}
