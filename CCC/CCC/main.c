//
//  main.c
//  CCC
//
//  Created by wds on 2018/5/17.
//  Copyright © 2018年 wdsdong. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
int binarySearch(int arr[],int n,int x);
void bubbleSort(int arr[],int n);
void selectionSort(int arr[],int n);
void inputSort(int arr[],int n);
void margeLeftAndRight(int arr[],int left,int m,int right);
void mergeSort(int array[], int start, int end);
void printArr(int arr[],int n);
void quickSort(int arr[],int start,int end);
void quick(int arr[],int n);

//删除排序数组中的重复项
int removeDuplicates(int* nums, int numsSize) {
    
    int sorted = 0;
    if(numsSize <=0) {
        return sorted;
    }
    for(int i = 1; i < numsSize; i++) {
        
        if(nums[i] > nums[sorted]) {
            if(i - sorted > 1) {
                int tmp = nums[sorted + 1];
                nums[sorted + 1] = nums[i];
                nums[i] = tmp;
            }
            sorted ++;
        }
        
    }
    sorted ++;
    printArr(nums, sorted);
    return sorted ;
}

int* twoSum(int* nums, int numsSize, int target) {
    int *twoArr = (int *)malloc(2*sizeof(int));
    for (int i = 0; i < numsSize - 1; i ++) {
        for (int j = i + 1; j < numsSize; j ++) {
            if (nums[i] + nums[j] == target) {
                twoArr[0] = i;
                twoArr[1] = j;
            }
        }
    }
    free(twoArr);
    return twoArr;
}


int main(int argc, const char * argv[]) {
    // insert code here...
    printf("Hello, World!\n");
    
//    int index = binarySearch(arr, 5, 6);
//    printf("%d\n",index);
//
    int arr[] = {2,1,4,3,6,5};
    
    int a[] = {2,7,11,15};
//    int len = removeDuplicates(a, 3);
    
    int *num = twoSum(a, 4, 9);
    
//    bubbleSort(arr, 6);
//
//    selectionSort(arr, 6);
//
//    inputSort(arr, 6);
    
//    mergeSort(arr, 0, 5);
    
//    quick(arr, 6);
    
    
    return 0;
}

void swap(int arr[],int start,int end) {
    int tmp = arr[start];
    arr[start] = arr[end];
    arr[end] = tmp;
}

int binarySearch(int arr[],int n,int x) {
    int start = 0;
    int end = n - 1;
    int middle = 0;
    int index = -1;
    if (n <= 0) {
        return -1;
    }
    for (int i = 0; i < n; i++) {
        middle = (start + end) / 2;
        if (arr[middle] == x) {
            index = middle;
            break;
        } else if (arr[middle] < x) {
            start = middle + 1;
        } else {
            end = middle - 1;
        }
        
    }
    return index;
}

void countSort(int *nums, int count) {
    int max = 0;
    for (int i = 0; i < count; i++) {
        if (nums[i] > max) {
            max = nums[i];
        }
    }
    int *buckets = malloc(sizeof(int) * (max + 1));
    memset(buckets, 0, max + 1);
    for (int i = 0; i < count; i++) {
        buckets[nums[i]] += 1;
    }
    for (int i = 0, k = 0; i < max + 1; i++) {
        while (buckets[i]) {
            nums[k++] = i;
            buckets[i]--;
        }
    }
}

//冒泡排序,两两比较,大的往后沉
void bubbleSort(int arr[],int n) {
    
//    int hasSwap = 1;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n - 1 - i; j++) {
//            hasSwap = 0;
            if (arr[j] > arr[j + 1]) {
//                hasSwap = 1;
                swap(arr, j, j + 1);
            }
        }
    }
    printArr(arr, n);
}

//选择排序,选出最小的一个和数组最前面的交换
void selectionSort(int arr[],int n) {

    for (int i = 0; i < n; i++) {
        int min = i;
        for (int j = i + 1; j < n; j++) {
            if (arr[min] > arr[j]) {
                min = j;
            }
        }
        swap(arr, i, min);
    }
    printArr(arr, n);
}

//插入排序,在左边有序数列中插入当前数(起始左侧一个有序数值)
void inputSort(int arr[],int n) {
    
    for (int i = 1; i < n; i++) {
        for (int j = i ; j > 0; j--) {
            if (arr[j - 1] > arr[j]) {
                swap(arr, j - 1, j);
            }
        }
    }
    printArr(arr, n);
}

//希尔排序,增加步长的插入排序
void shellSort(int arr[],int n) {
    int gap = 5;
    int h = 1;
    while (h < n / gap) {
        h = gap * h + 1;
    }
    while (h >= 1) {
        for (int i = h; i < n; i ++) {
            for (int j = i; j>=h; j -= h) {
                if (arr[j - h] > arr[i]) {
                    swap(arr, j - h, j);
                }
            }
        }
        h = h / gap;
    }
    printArr(arr, n);
}

//归并排序
void mergeSort(int array[], int start, int end) {
    if (start < end) {
//        int left = start;
//        int right = end;
        int middle = start + (end - start) / 2;
        // 对前半部分进行排序
        mergeSort(array, start, middle);
        // 对后半部分进行排序
        mergeSort(array, middle + 1, end);
        // 合并前后两部分
        margeLeftAndRight(array, start, middle, end);
    }
}

void margeLeftAndRight(int arr[],int left,int m,int right) {
    
    int aux[100]={0};
    
    for (int i = left,j = m + 1,k = 0; k <= right - left; k ++) {
        if (i == m + 1) {
            aux[k] = arr[j++];
            continue;
        }
        if (j == right + 1) {
            aux[k] = arr[i++];
            continue;
        }
        if (arr[i] < arr[j]) {
            aux[k] = arr[i++];
        } else {
            aux[k] = arr[j++];
        }
    }
    
    for (int i = left,j = 0; i <= right; i++,j++) {
        arr[i] = aux[j];
    }
}

void quick(int arr[],int n) {
    quickSort(arr, 0, n - 1);
    printArr(arr, n);
}

void quickSort(int arr[],int start,int end) {
    int i = start;
    int j = end;
    int tmp = arr[start];
    if (i >= j) {
        return;
    }
    
    while (i < j) {
        while (arr[j] >= tmp && i < j) {
            j --;
        }
        while (arr[i] <= tmp && i < j) {
            i ++;
        }
        int t = arr[i];
        arr[i] = arr[j];
        arr[j] = t;
    }
    
    arr[start] = arr[i];
    arr[i] = tmp;
    
    quickSort(arr, start, i - 1);
    quickSort(arr, i + 1, end);
}

void printArr(int arr[],int n) {
    for (int i = 0; i < n; i ++) {
        printf("%d\n",arr[i]);
    }
}


