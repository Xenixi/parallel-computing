
import time

testA = ([2.3423] * 10000000)
testB = ([1.4214] * 10000000)
outputC = ([0] * 10000000)

print("Starting python loop example... Array 10m entries")
print("Created arrays...")
print("testA: " + str(len(testA)))
print("testB: " + str(len(testB)))

print("Multiplying...")
timeStart = time.time()

for i in range (len(testA)):
    outputC[i] = testA[i] * testB[i]

for i in range (len(testA)):
    outputC[i] = outputC[i] * testA[i]

for i in range (len(testA)):
    outputC[i] = outputC[i] * testB[i]


timeFinal = (time.time() - timeStart)*1000
print("[PYTHON LOOP] Time taken: " + str(round(timeFinal, 4)) + "ms")
