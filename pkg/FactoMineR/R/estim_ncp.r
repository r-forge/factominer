estim_ncp <- function(X, ncp.min=0,ncp.max=NULL, scale=TRUE,method="Smooth"){

## Pas de NA dans X
method <- tolower(method)
p=ncol(X)
n=nrow(X)
if (is.null(ncp.max)) ncp.max <- ncol(X)-1
ncp.max <- min(nrow(X)-2,ncol(X)-1,ncp.max)
crit <- NULL

##res.pca = PCA(X,scale=scale,graph=FALSE,ncp=ncp.max)
X=scale(X,scale=FALSE)

if (scale){
 et = apply(X,2,sd)
 X = sweep(X,2,et,FUN="/")
}
if (ncp.min==0)  crit = mean(X^2, na.rm = TRUE)*nrow(X)/(nrow(X)-1)

rr = svd(X,nu=ncp.max,nv=ncp.max)

for (q in max(ncp.min,1):ncp.max){
    if (q>1) rec = as.matrix(rr$u)[,1:q,drop=F]%*%diag(rr$d[1:q])%*%t(as.matrix(rr$v)[,1:q,drop=F])
    if (q==1) rec = as.matrix(rr$u)[,1,drop=FALSE]%*%t(as.matrix(rr$v)[,1,drop=FALSE])*rr$d[1]

##if (scale) rec = sweep(rec,2,et,FUN="*")

    if (method=="smooth"){
      if (q>1){
        a <- apply(rr$u[,1:q]^2,1,sum)
        b <- apply(rr$v[,1:q]^2,1,sum)
      } else {
        a=rr$u[,1]^2
        b=rr$v[,1]^2
      }
      zz=sweep(rec-X,1,1-a,FUN="/")
      sol = sweep(zz,2,1-b,FUN="/")
      crit=c(crit,mean(sol^2))
    }    
    if (method=="gcv") crit=c(crit,mean(( (n*p)*(X-rec)/ (n*p- q*(n+p-q)))^2,na.rm=T))
  }
  if (any(diff(crit)>0)) { ncp = which(diff(crit)>0)[1]
  } else ncp <- which.min(crit)
#  return(list(ncp = which.min(crit)+ncp.min-1,criterion=crit))
  return(list(ncp = ncp+ncp.min-1,criterion=crit))
}
