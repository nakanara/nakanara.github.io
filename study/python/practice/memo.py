import sys

action  = sys.argv[1]


if action == '-a':
    memo    = sys.argv[2]
    f = open('memo.txt', 'a')
    f.write(memo)
    f.write('\n')
    f.close()
elif action == '-v':
    f = open('memo.txt', 'r')
    memo = f.read()
    f.close()
    print(memo)
