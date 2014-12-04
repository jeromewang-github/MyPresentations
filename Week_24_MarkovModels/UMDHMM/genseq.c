/*
**      Author: Tapas Kanungo, kanungo@cfar.umd.edu
**      Date:   22 February 1998 
**      File:   genseq.c
**      Purpose: driver for generating a sequence of observation symbols. 
**      Organization: University of Maryland
**
**      $Id: genseq.c,v 1.2 1998/02/23 07:52:27 kanungo Exp kanungo $
*/

#include <stdio.h> 
#include <stdlib.h> 
#include <math.h>
#include <string.h>
#include "nrutil.h"
#include "hmm.h"

static char rcsid[] = "$Id: genseq.c,v 1.2 1998/02/23 07:52:27 kanungo Exp kanungo $";

int main (int argc, char **argv)
{
	HMM  	hmm; 	/* the HMM */
	int  	T; 	/* length of observation sequence */
	int	*O;	/* the observation sequence O[1..T]*/
	int	*q; 	/* the state sequence q[1..T] */
	FILE 	*fp;	/* HMM parameters in this file */

	if (argc != 3) {
		printf("Usage error \n");
		printf("Usage: %s mod.hmm T\n", argv[0]);	
		printf("  T = length of sequence\n");
		printf("  mod.hmm is a file with HMM parameters\n");
		exit (1);
	}

	fp = fopen(argv[1],"r");		
	ReadHMM(fp, &hmm);
	fclose(fp);


	/* length of observation sequence, T */
	T = atoi(argv[2]);

	O = ivector(1,T); /* alloc space for observation sequence O */
	q = ivector(1,T); /* alloc space for state sequence q */

	GenSequenceArray(&hmm, T, O, q);

	PrintSequence(stdout, T, O);
	free_ivector(O, 1, T);
	free_ivector(q, 1, T);
	FreeHMM(&hmm);
}

