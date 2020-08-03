import numpy as np

a = [[6,7],[4,5],[8,9]]
b = [1,1]
c = np.abs(np.asarray(a) - np.array(b))
#print(c)

d = [[6], [6], [6]]

print(np.min(c, axis=1))

print(d + np.min(c, axis=1)[:, np.newaxis])
#rand_start = np.random.randint(low=0, high=3, size=1)[0] 

#print(rand_start)