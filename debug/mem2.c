#include<stdlib.h>
#include <stdio.h>
int main(void)
{
  int i,size,sum;
  int *p;
  
  printf("Entrez un nombre\n");
  scanf("%d",&size);

  p = (int*)malloc(size * sizeof(int));
  for(i = 0 ; i< size ; i++)
    p[i] = i ;
  
  
 
  for(i = 0 ; i< size ; i++)
     sum += p[i]; 

  free(p);

  return EXIT_SUCCESS;     
}
