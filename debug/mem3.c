#include<stdlib.h>
#include <stdio.h>
int main(void)
{
  int i,size,sum;
  int **p;
  
  printf("Entrez un nombre\n");
  scanf("%d",&size);
  
  p = malloc(size * sizeof(int*));
  for(i = 0 ; i < size ; i++)
    p[i] =  malloc(size * sizeof(int));

  for( i = 0 ; i < size ; i++)
    free(p[i]);

  free(p);
  return EXIT_SUCCESS;     
}
