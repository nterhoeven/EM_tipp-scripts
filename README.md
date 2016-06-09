# EM_tipp-scripts
some scripts to predict football results

All scripts can be run with ```perl scriptname TEAM-1 TEAM-2```. 
The results are formatted as ```TEAM-1 score : score TEAM-2```

## Overview of scripts

### random-result.pl
This script prints a random number between 0 and 5 for each team.

### possible_result.pl
This script uses the scores of the FIFA ranking and the frequency of
certain results in the european championships from 2000, 2004, 2008 and 2012
to predict a winner.