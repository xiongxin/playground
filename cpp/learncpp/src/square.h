#ifndef SQUARE_H
#define SQUARE_H

// 如果在h文件中定义函数实体，那么会引发该函数多次定义
// int getSquareSides() { return 4; }
int getSquareSides();
int getSquarePerimeter(
    int sideLength); // forward declaration for getSquarePerimeter

#endif