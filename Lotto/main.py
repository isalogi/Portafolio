#Isabel Critina López
# PROBLEM ID: 441-lOTTO

#INPUT: One line containing several integers separted from each other by spaces.
# The frist integer will be k and then k integers specifying s. 

# k(Number of s elements 6<k<13)
#s(Set of numbers)

#Output: All posible games combinations in ascending order, each game on one line.

def combinations(s):
    if len(s)>0:
        rest = combinations(s[1:])
        return rest + [[s[0]] + x for x in rest ]
    return [[]];

import sys

def main():
      
    entrada=[[]]

    for line in sys.stdin:
        line=line.replace("\n","")
        if(len(line)>0):
            if line=='0':
                break
            else:
                k=(int)(line.strip().split(" ")[0])

                if(k>6 and k<13):
    
                    if(line[0]=='1'):
                        temp=line[3:].strip().split(" ")   
                    else:
                       temp=line[1:].strip().split(" ")   

                    index=0
                    insert=False

                    tamEntreda=len(entrada)
                    while(index<tamEntreda):
                        tam=len(entrada[index])
                        if(k<=tam):
                            insert=True
                            entrada.insert(index,temp)
                        index+=1

                    if(insert==False):    
                        entrada.append(temp) 

    entrada=entrada[1:]

    cont=1

    for InputLine in entrada:           
        a=combinations(InputLine)
        result=[[]]
        for item in a:
            if(len(item)==6):
                result.append(item)

        i=len(result)-1
        while i > 0:
            
            sys.stdout.write(' '.join(str(x) for x in result[i]))
            sys.stdout.write('\n')
            i-=1

        cont+=1
        if(cont<=len(entrada)):
            sys.stdout.write('\n')

if __name__ == "__main__":
    main()