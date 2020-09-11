import numpy as np
import time
##numpy version of Array10m.py
testA = np.array([2.3423] * 10000000)
testB = np.array([1.4214] * 10000000)


print("Starting NUMPY example... Array 10m entries")
print("Created arrays...")
print("testA: " + str(len(testA)))
print("testB: " + str(len(testB)))

print("Multiplying...")
timeStart = time.time()

outputC = np.dot(testA, testB)
outputC = np.dot(outputC, testA)
outputC = np.dot(outputC, testB)

timeFinal = (time.time() - timeStart)*1000
print("[NUMPY] Time taken: " + str(round(timeFinal, 4)) + "ms")
