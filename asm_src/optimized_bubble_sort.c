void swap(int* xp, int* yp)
{
    int temp = *xp;
    *xp = *yp;
    *yp = temp;
}

// An optimized version of Bubble Sort
void bubbleSort(int arr[], int n)
{
    int swapped;
    for (int i = 0; i < n-1; i++) {
        swapped = 0;
        for (int j = 0; j < n - i - 1; j++) {
            if (arr[j] > arr[j + 1]) {
                swap(&arr[j], &arr[j + 1]);
                swapped = 1; 
            }
          
        }
        // If no two elements were  swapped by inner loop,
        // then break
        
    
        if (swapped == 0) {
                break;
        }
    }
}

int main()
{
    int A[5] = {156, 42, 89, 34, 4};
    int n = 5;
    bubbleSort(A, n);
    return A[0];
}