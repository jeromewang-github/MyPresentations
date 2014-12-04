/*
**      Author: Tapas Kanungo, kanungo@cfar.umd.edu
**      Date:   22 February 1988 
**      File:   esthmm.c
**      Purpose: estimate HMM parameters from observation. 
**      Organization: University of Maryland
**
**      $Id: esthmm.c,v 1.1 1998/02/23 07:49:45 kanungo Exp kanungo $
*/

#include <stdio.h> 
#include <stdlib.h>
#include <math.h>
#include <string.h>
#include "nrutil.h"
#include "hmm.h"

static char rcsid[] = "$Id: esthmm.c,v 1.1 1998/02/23 07:49:45 kanungo Exp kanungo $";

int main (int argc, char **argv)
{
	int 	T;
	HMM  	hmm;
	int	N;
	int	M;
	double 	**alpha; 
	double	**beta;
	double	**gamma;
	int	*O;
	FILE	*fp;

	if (argc != 4) {
		printf("Usage error. \n");
		printf("Usage: %s N M file.seq\n", argv[0]);
		printf("  N - number of states\n");
		printf("  M - number of symbols\n");
		printf("  file.seq - file containing the obs. seqence\n");
		exit (1);
	}
		
	fp = fopen(argv[3], "r");
	ReadSequence(fp, &T, &O); /* read the observed sequence */
	fclose(fp);

	N = atoi(argv[1]); /* number of states */
	M = atoi(argv[2]); /* number of symbols */

	InitHMM(&hmm, N, M);

	alpha = dmatrix(1, T, 1, hmm.N);
	beta = dmatrix(1, T, 1, hmm.N);
	gamma = dmatrix(1, T, 1, hmm.N);

	BaumWelch(&hmm, T, O, alpha, beta, gamma);

	PrintHMM(stdout, &hmm);

	free_ivector(O, 1, T);
	free_dmatrix(alpha, 1, T, 1, hmm.N);
	free_dmatrix(beta, 1, T, 1, hmm.N);
	free_dmatrix(gamma, 1, T, 1, hmm.N);
	FreeHMM(&hmm);
}

