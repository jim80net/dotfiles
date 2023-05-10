export PATH=/usr/local/cuda-11.8/bin:$PATH
if [ -z "${LD_LIBRARY_PATH}" ]; then
    export LD_LIBRARY_PATH=/usr/local/cuda-11.8/lib64:/usr/local/cuda/extras/CUPTI/lib64
else
    export LD_LIBRARY_PATH=/usr/local/cuda-11.8/lib64:/usr/local/cuda/extras/CUPTI/lib64:${LD_LIBRARY_PATH}
fi

