#!/bin/sh -f

if [ ! -e /bin/cellprofiler_galaxy ]; then    
   /opt/conda/envs/cellprofiler/bin/cellprofiler
else    
   cellprofiler_galaxy
fi
