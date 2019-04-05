fileName = raw_input("Enter a file to write pi to: ")
n = 1000
leng = 10*n / 3
a = [2] * leng
nines = 0
predigit = 0
q = 0
piStr = ""

for j in range(0,n):
    q = 0
    for i in range(leng-1, 0, -1):
        x = 10*a[i] + q*i
        a[i] = x % (2*i-1)
        q = x / (2*i - 1)
    a[1] = q % 10
    q = q/10
    if q == 9:
        nines+=1
    elif q == 10:
        piStr+=str(predigit + 1)
        for k in range(0,nines):
            piStr+=str(0)
        predigit = 0
        nines = 0
    else:
        piStr+=str(predigit)
        predigit = q
        if nines != 0:
            for k in range(0,nines):
                piStr+=str(9)
            nines = 0

piStr+=str(predigit)
f = open(fileName, "w+")
f.write(piStr)
f.close()
