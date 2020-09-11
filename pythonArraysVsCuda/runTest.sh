echo "Beginning test:"
echo
echo "Running matrix multiplication test..."
echo "Python: Single threaded loop: LAUNCH"
echo
py Array10m.py
echo
echo "Running matrix multiplication test..."
echo "Python: Numpy dot: LAUNCH"
echo
py Array10mNP.py
echo
echo "Running matrix multiplication test..."
echo "CUDA: Parallelized on GPU: LAUNCH"
echo
./Array10mCPP.exe


