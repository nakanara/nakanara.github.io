
"배수 구하기"

def getSum(val):
    sum = 0
    i = 0
    while i < val:
        if(i % 3 == 0 or i % 5 == 0):
            sum += i
            print(f"sum={sum} val={i}")
        i += 1
    
    return sum


sum = getSum(1000)
print(sum)