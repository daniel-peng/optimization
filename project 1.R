library(lpSolveAPI)

coupon = c(5, 3.5, 5, 3.5, 4, 9, 6, 8, 9, 7)
c = c(102,99,101,98,98,104,100,101,102,94)
b = c(12000,18000,20000,20000,16000,15000,12000,10000)
A = matrix(0,8,10)

A[1,] = coupon
A[1,1] = A[1,1] + 100
A[2,2:10] = coupon[2:10]
A[2,2:3] = A[2,2:3] + 100
A[3,4:10] = coupon[4:10]
A[3,4] = A[3,4] + 100
A[4,5:10] = coupon[5:10]
A[4,5] = A[4,5] + 100
A[5,6:10] = coupon[6:10]
A[5,6:7] = A[5,6:7] + 100
A[6,8:10] = coupon[8:10]
A[6,8] = A[6,8] + 100
A[7,9:10] = coupon[9:10]
A[7,9] = A[7,9] + 100
A[8,10] = coupon[10]
A[8,10] = A[8,10] + 100

#create an LP model with 0 constraints (we will add constraints later) and 10 decision variables
pcLP<-make.lp(0,10)
#set objective coefficients
set.objfn(pcLP, c)
#set objective direction
lp.control(pcLP,sense='min')

for (i in c(1:8)) {
  add.constraint(pcLP, A[i,], ">=", b[i])
}

#write to text file
write.lp(pcLP,'pc.lp',type='lp')


#solve the model, if this return 0 an optimal solution is found
solve(pcLP)

#this return the proposed solution
get.objective(pcLP)
get.variables(pcLP)
