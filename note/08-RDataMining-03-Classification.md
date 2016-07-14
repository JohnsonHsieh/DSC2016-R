
## 關卡 1
這門課程要介紹R裡面的kNN演算法。


## 關卡 2
為了準備接下來的說明，我們準備了以下的物件。X.train是trainingdataset的covariates,而y.train則是trainingdataset的label；X.test是testingdataset的covariates，而y.test則是testingdataset的label。


## 關卡 3
請同學輸入：`X.train`看看trainingdataset的covariates
```r
X.train
```


## 關卡 4
接著我們計算X.train與X.test，列與列之間的EuclideanDistance。之前的Cluster章節，我們介紹過dist函數可以計算一個矩陣之間，所有列與列之間的距離。所以一種做法就是將X.train與X.test合併成一個矩陣，然後運用dist做計算。


## 關卡 5
請問同學，X.train有多少列？
```r
nrow(X.train)
```


## 關卡 6
請問同學，X.test有多少列？
```r
nrow(X.test)
```


## 關卡 7
請輸入`X<-rbind(X.train,X.test)`將X合併
```r
X <- rbind(X.train, X.test)
```


## 關卡 8
請輸入`d<-dist(X)`計算出X列與列之間的距離
```r
d <- dist(X)
```


## 關卡 9
由於我們需要從距離矩陣之中，抽出需要的部分（X.train與X.test的列與列之間的距離），所以需要先把距離物件轉換為矩陣。請同學輸入：`m<-as.matrix(d)`
```r
m <- as.matrix(d)
```


## 關卡 10
接著，我們抽出X.train與X.test的距離的部分。請同學輸入：`m2<-m[1:75,76:150]`。這裡是選出X的前75列，也就是X.train與其他資料的距離；以及X的後75欄，代表X.test與其他資料的距離。
```r
m2 <- m[1:75,76:150]
```


## 關卡 11
R的which.min可以找出一個向量中，數值最小的位置。apply則可以對一個矩陣的每一列或每一欄做相同的動作。apply的第二個參數如果是1，代表是對每一列做；如果是2代表對每一欄做相同的動作。動作則是定義在第三個參數。所以輸入：`i.1nn<-apply(m2,2,which.min)`就可以取得每個欄位中，數字最小的列的位置。
```r
i.1nn <- apply(m2, 2, which.min)
```


## 關卡 12
接著，利用y.train[i.1nn]，我們就可以取得對應的trainingdatapoint的類別。也就是說，y.train[i.1nn]就是1NN的分類結果。請同學輸入：`mean(y.train[i.1nn]==y.test)`來看看1NN的分類結果與實際答案相比，正確的機率有多少。
```r
mean(y.train[i.1nn] == y.test)
```


## 關卡 13
以上是用R的基礎函數所拼湊出來的計算1NN的方法。我們也可以用同樣的脈絡來計算其他資料的1NN分類結果。請同學試試看。
```r
# 使用 ML 習題用的 Ionosphere 資料集
check_then_install("mlbench", "2.1.1")
library(mlbench)

data(Ionosphere)
test.i <- c(4L, 6L, 9L, 13L, 14L, 22L, 31L, 33L, 50L, 52L, 61L, 63L, 68L, 
  79L, 91L, 99L, 119L, 135L, 154L, 155L, 160L, 162L, 166L, 194L, 
  200L, 219L, 233L, 236L, 237L, 242L, 244L, 248L, 250L, 257L, 261L, 
  276L, 278L, 283L, 292L, 310L, 312L, 315L, 319L, 323L, 325L, 327L, 
  335L, 337L, 338L, 344L)
df.test <- Ionosphere[test.i,-2] # remove V2
X.test <- df.test[,-34]
y.test <- df.test$Class
train.i <- setdiff(seq_len(nrow(Ionosphere)), test.i)
df.train <- Ionosphere[train.i,-2]
X.train <- df.train[,-34]
y.train <- df.train$Class

# 以下程式碼示範用euclidean distance來計算1NN的分類結果。
df <- rbind(X.train, X.test)
d <- dist(df, method = "manhattan")
m <- as.matrix(d)
i <- seq_len(nrow(df.train))
j <- nrow(df.train) + seq_len(nrow(df.test))
m2 <- m[i,j]
i.1nn <- apply(m2, 2, which.min)
answer1 <- mean(y.test == y.train[i.1nn])

# 請同學修改上述程式碼中，dist函數的參數
# 讓R使用其他的「距離定義」，找出讓answer1的準確度超過0.95的結果
# 細節可以參考 ?dist 的說明文件
# 完成後請存檔後輸入`submit()`

```


## 關卡 14
上述的方法，要計算kNN是比較不方便的。因此，我們使用`class`這個套件來計算kNN的結果。請同學先安裝套件`class`
```r
check_then_install("class", "7.3")
```


## 關卡 15
接著請同學載入class套件
```r
library(class)
```


## 關卡 16
我們利用knn函數即可快速計算knn的結果。請同學先輸入`?knn`打開說明文件。
```r
?knn
```


## 關卡 17
根據說明文件，我們只要輸入：`knn(X.train,X.test,y.train,k=1)`即可取得1NN的計算結果。請同學試試看。
```r
knn(X.train, X.test, y.train, k = 1)
```


## 關卡 18
以上就是在R中計算kNN演算法的方式。


## 關卡 19
接下來，我們介紹的是DecisionTree。先請同學安裝套件rpart。
```r
check_then_install("rpart", "4.1.10")
```


## 關卡 20
接著，請載入套件rpart
```r
library(rpart)
```


## 關卡 21
在摸索一個套件時，我們可以找找看套件作者有沒有撰寫vignette。請同學輸入：`vignette(package="rpart")`
```r
vignette(package = "rpart")
```


## 關卡 22
由跳出的視窗，我們可以看到一個名為：`"longintro"`的文件名稱，是一份介紹rpart的文件。請輸入`vignette("longintro",package="rpart")`打開這份文件。


## 關卡 23
有興趣的同學可以閱讀這份文件的前半段。我們則直接用範例來解說rpart的功能。


## 關卡 24
請同學先輸入`data(stagec)`載入一個關於C期前列腺癌的研究數據。這比數據中，記錄著146位病患的資訊。
```r
data(stagec)
```


## 關卡 25
請同學輸入：`cfit<-rpart(pgstat~age+eet+g2,data=stagec,method="class")`。
```r
cfit <- rpart(pgstat ~ age + eet + g2, data = stagec, method = "class")
```


## 關卡 26
這裡的函數`rpart`就是用於建立decisiontree的函數。請同學打開`rpart`的說明頁面。
```r
?rpart
```


## 關卡 27
根據`rpart`的說明文件，我們剛剛輸入的：`cfit<-rpart(pgstat~age+eet+g2,data=stagec,method="class")`中的`pgstat~age+eet+g2`是對應到`rpart`函數的哪一個參數呢？
formula


## 關卡 28
上述輸入的formula參數：`pgstat~age+eet+g2`，描述的是在建構decisiontree時，變數之間的關係。pgstat是要被預測、被分類的變數名稱，age、eet和g2則是用來對pgstat做預測的變數。


## 關卡 29
根據`rpart`的說明文件，我們剛剛輸入的：`cfit<-rpart(pgstat~age+eet+g2,data=stagec,method="class")`中的`stagec`是對應到`rpart`函數的哪一個參數呢？
data


## 關卡 30
接著，請列出stagec的欄位名稱。
```r
colnames(stagec)
```


## 關卡 31
我們可以看到，剛剛formula中的變數名稱，都在stagec之中。


## 關卡 32
rpart這個函數有許多功能，使用者可以在method的參數指定要使用的功能。請同學參考rpart的說明文件中，關於method參數的說明。請問下列哪一個選項「不是」rpart的method參數的有效選項？
regression


## 關卡 33
在關於method的說明文件中，仔細地解釋了rpart是如何依照formula中選擇的變數形態來智慧的選擇預設的method。請同學查詢stagec的pgstat欄位的形態為何。
```r
class(stagec$pgstat)
```


## 關卡 34
依照rpart的說明文件和stagec$pgstat的型態，請問如果我們沒有指定method的話，rpart會用哪一種method參數來運作？
anova


## 關卡 35
接著，請輸入`cfit`來看看rpart的結果。
```r
cfit
```


## 關卡 36
R會把從資料中學到的decisiontree顯示到console中。前段的文字說明了每一行的資訊依序是：node),split,n,loss,yval,(yprob)而且最後標記有星號的就是decisiontree的leafnode。舉例來說，`1)root146540(0.63013700.3698630)`代表這是第一個node，他的切割規則是root，有146個點，loss是54，deviance是0。請問同學，第二個node的loss是什麼？
18


## 關卡 37
這裡的loss代表的是錯誤的label的個數，俗稱0/1loss。在第一個node，也就是root之中，cfit對`stagec$pgstat`的預測是0。請同學計算`stagec$pgstat`中非0的病患總數。看看是不是和第一行，1)root中顯示的loss相同。
```r
sum(stagec$pgstat != 0)
```


## 關卡 38
另外同學應該有注意到，node的編號並不是連續的。這是因為，每個編號為x的node，他的分支一定是編號2x和2x+1。請問同學，編號7的node是編號多少的node的分支？
```r
3
```


## 關卡 39
接著，讓我們畫出cfit。這需要兩個指令，所以請同學先輸入：`plot(cfit)`
```r
plot(cfit)
```


## 關卡 40
再請同學輸入`text(cfit)`
```r
text(cfit)
```


## 關卡 41
我們可以發現，圖的上下維有一點被切掉。這可以透過`par`函數的mar參數做調整。但是其實已經有人發現這件事情，並且寫了一個叫做rpart.plot的套件。請同學安裝這個套件
```r
check_then_install("rpart.plot", "1.5.3")
```


## 關卡 42
接著，請載入rpart.plot套件。
```r
library(rpart.plot)
```


## 關卡 43
我們直接輸入：`rpart.plot(cfit)`來看看畫圖的結果。
```r
rpart.plot(cfit)
```


## 關卡 44
rpart.plot套件對於rpart的圖片輸出做過調整，所以就不會出現圖形被截掉的狀態。


## 關卡 45
接著讓我們來探索rpart是如何產生cfit這棵樹。


## 關卡 46
rpart其實有非常多的參數，並且各類參數的細節分佈在`rpart`的參數parms和control中。


## 關卡 47
在我們剛剛打開的vignette的Chapter3.1，作者說明了如何建構一個decisiontree。裡面解釋了何謂prior、loss和splittingindex。


## 關卡 48
rpart的參數`parms`裡面可以設定和method相關的參數。


## 關卡 49
請問同學，根據`rpart`的說明文件（請參閱Arguments底下的parms），當method為class時（classificationsplitting），預設的prior為何？1)每種類別都相等的機率;2)和資料中各類別出現的頻率成正比的機率
2


## 關卡 50
請問同學，根據`rpart`的說明文件（請參閱Arguments底下的parms），當method為class時（classificationsplitting），預設的splittingindex為何？
gini


## 關卡 51
rpart把和method無關的參數放到`control`底下，並且提供一個輔助函數`rpart.control`來協助使用者在實作時也限制了每個split時，該node的個數限制。請同學輸入`?rpart.control`來看一下這些控制有哪些參數。
```r
?rpart.control
```


## 關卡 52
接著，我們來重現cfit的第一層結果。請同學閱讀檔案中的程式碼與註解後，輸入`submit()`。
```r
# R 中的型態很重要。類別的數據，調整成factor之後做運算會方便很多
y <- factor(stagec$pgstat)

# n 是各種類別出現的次數
n <- table(y)

# 預設的prior 是各種類別出現的比率
prior <- n / length(y)

#'@title 這是Vignette中的P 函數的實作
#'
#'@param x factor vector.
#'@return numeric value. 資料點屬於x 的機率
P <- function(x) {
  x.tb <- table(x)
  sum(pi * (x.tb / n))
}

#'@title 這是gini index的計算
#'
#'@param p numeric value. 是某個類別的機率
#'@return numeric value. 該類別的gini index
gini <- function(p) p * (1 - p)

#'@title 這是使用gini index做切割準則時，I 函數的實作
#'@param x factor vector.
#'@return numeric value. x 的impurity
I <- function(x) {
  x.tb <- table(x)
  # 各種類別的機率
  category.prob <- x.tb / length(x)
  #' R 也是一種函數式語言，而sapply等函數能夠很方便的取代for 迴圈
  #' 這個寫法等價於：
  #' for(p in category.prob) gini(p)
  #' 但是自動把輸出結果排列成一個向量
  category.gini <- sapply(category.prob, gini) 
  sum(category.gini)
}

PI <- function(x) P(x) * I(x)

#'@title 給定一個切點之後，計算impurity降低的幅度
impurity_variation_after_cut <- function(cut) {
  origin.impurity <- I(y) * P(y)
  # split 會依照第二個參數的值，將第一個參數分成若干個向量。
  # split 的結果是一個list，而且每一個list element對應到第二個參數的一種類別
  group <- split(y, stagec$age < cut)
  # group 是一個長度為二的list
  # 第一個element是所有stage$age < cut為FALSE 的病患對應的pgstat
  # 第二個element是所有stage$age < cut為TRUE 的病患對應的pgstat

  # 對各種切割後的node計算PI後加總
  splitted.impurity <- sum(sapply(group, PI))
  origin.impurity - splitted.impurity
}

# 列舉所有可能的切點
eval.x <- seq(min(stagec$age) - 0.5, max(stagec$age) + 0.5, by = 1)

# 算出每個切點，對應的impurity 的改善量
index <- sapply(eval.x, impurity_variation_after_cut)
```


## 關卡 53
請問同學，讓impurity改善最大的切點，是第幾個呢？同學可以用`which.max`函數作答。
```r
which.max(index)
```


## 關卡 54
對應的切點的值是多少呢？請利用上一題的答案。
```r
eval.x[which.max(index)]
```


## 關卡 55
上一題的答案和cfit的結果不一致。從前面cfit的輸出可以看到，rpart的第一個切點是age>=58.5。這其實是受到`control`這個參數的影響，所以rpart不會切割出太小（包含太少資料點）的node。請同學輸入：`rpart(pgstat~age,data=stagec,method="class",control=rpart.control(minsplit=1))`
```r
rpart(pgstat ~ age, data = stagec, method = "class", control = rpart.control(minsplit = 1))
```


## 關卡 56
同學是不是看到第一個切點變成我們之前算出來的50.5了？


## 關卡 57
rpart在做分類時，是利用公式去計算各種切點的impurity的改善。而這些切點的選擇也是有限制的（透過`rpart.control`）。使用者可以透過`control=rpart.control(minsplit=1)`來對這些限制條件做修正。


## 關卡 58
Impurity的計算則可以透過parms的設定來調整。請同學閱讀檔案中的程式碼與註解後，輸入`submit()`。
```r
# R 中的型態很重要。類別的數據，調整成factor之後做運算會方便很多
y <- factor(stagec$pgstat)

# n 是各種類別出現的次數
n <- table(y)

# 預設的prior 是各種類別出現的比率
prior <- n / length(y)

#'@title 這是Vignette中的P 函數的實作
#'
#'@param x factor vector.
#'@return numeric value. 資料點屬於x 的機率
P <- function(x) {
  x.tb <- table(x)
  sum(pi * (x.tb / n))
}

#'@title 這是information index的計算
#'
#'@param p numeric value. 是某個類別的機率
#'@return numeric value. 該類別的information index
information <- function(p) {
  if (p == 0) 0 else - p * log(p)
}

#'@title 這是使用information index做切割準則時，I 函數的實作
#'@param x factor vector.
#'@return numeric value. x 的impurity
I <- function(x) {
  x.tb <- table(x)
  # 各種類別的機率
  category.prob <- x.tb / length(x)
  #' R 也是一種函數式語言，而sapply等函數能夠很方便的取代for 迴圈
  #' 這個寫法等價於：
  #' for(p in category.prob) gini(p)
  #' 但是自動把輸出結果排列成一個向量
  category.information <- sapply(category.prob, information) 
  sum(category.information)
}

PI <- function(x) P(x) * I(x)

#'@title 給定一個切點之後，計算impurity降低的幅度
impurity_variation_after_cut <- function(cut) {
  origin.impurity <- I(y) * P(y)
  # split 會依照第二個參數的值，將第一個參數分成若干個向量。
  # split 的結果是一個list，而且每一個list element對應到第二個參數的一種類別
  group <- split(y, stagec$age < cut)
  # group 是一個長度為二的list
  # 第一個element是所有stage$age < cut為FALSE 的病患對應的pgstat
  # 第二個element是所有stage$age < cut為TRUE 的病患對應的pgstat

  # 對各種切割後的node計算PI後加總
  splitted.impurity <- sum(sapply(group, PI))
  origin.impurity - splitted.impurity
}

# 列舉所有可能的切點
eval.x <- seq(min(stagec$age) - 0.5, max(stagec$age) + 0.5, by = 1)

# 算出每個切點，對應的impurity 的改善量
index <- sapply(eval.x, impurity_variation_after_cut)
```


## 關卡 59
在改成用informationindex後，對應的切點的值是多少呢？
```r
eval.x[which.max(index)]
```


## 關卡 60
請同學輸入：`rpart(pgstat~age,data=stagec,method="class",parms=list(split="information"),control=rpart.control(minsplit=1))`
```r
rpart(pgstat ~ age, data = stagec, method = "class", parms = list(split = "information"), control = rpart.control(minsplit=1))
```


## 關卡 61
可以看到差不多的結果。


## 關卡 62
rpart也可以讓我們自己定義分割的邏輯。這題會打開rpart套件提供的範例給同學參考。有興趣的同學可以仔細研究。讀完之後請輸入`submit()`
```r
# The following script is based on `mystate` dataset.
mystate <- data.frame(state.x77, region=state.region)
colnames(mystate) <- tolower(colnames(mystate))

# The 'evaluation' function.  Called once per node.
#  Produce a label (1 or more elements long) for labeling each node,
#  and a deviance.  The latter is
#	- of length 1
#       - equal to 0 if the node is "pure" in some sense (unsplittable)
#       - does not need to be a deviance: any measure that gets larger
#            as the node is less acceptable is fine.
#       - the measure underlies cost-complexity pruning, however
temp1 <- function(y, wt, parms) {
    wmean <- sum(y*wt)/sum(wt)
    rss <- sum(wt*(y-wmean)^2)
    list(label= wmean, deviance=rss)
    }

# The split function, where most of the work occurs.
#   Called once per split variable per node.
# If continuous=T
#   The actual x variable is ordered
#   y is supplied in the sort order of x, with no missings,
#   return two vectors of length (n-1):
#      goodness = goodness of the split, larger numbers are better.
# 0 = couldn't find any worthwhile split
#        the ith value of goodness evaluates splitting obs 1:i vs (i+1):n
#      direction= -1 = send "y< cutpoint" to the left side of the tree
#  1 = send "y< cutpoint" to the right
#         this is not a big deal, but making larger "mean y's" move towards
#         the right of the tree, as we do here, seems to make it easier to
#         read
# If continuos=F, x is a set of integers defining the groups for an
#   unordered predictor.  In this case:
#       direction = a vector of length m= "# groups".  It asserts that the
#           best split can be found by lining the groups up in this order
#           and going from left to right, so that only m-1 splits need to
#           be evaluated rather than 2^(m-1)
#       goodness = m-1 values, as before.
#
# The reason for returning a vector of goodness is that the C routine
#   enforces the "minbucket" constraint. It selects the best return value
#   that is not too close to an edge.
temp2 <- function(y, wt, x, parms, continuous) {
    # Center y
    n <- length(y)
    y <- y- sum(y*wt)/sum(wt)

    if (continuous) {
	# continuous x variable
	temp <- cumsum(y*wt)[-n]

	left.wt  <- cumsum(wt)[-n]
	right.wt <- sum(wt) - left.wt
	lmean <- temp/left.wt
	rmean <- -temp/right.wt
	goodness <- (left.wt*lmean^2 + right.wt*rmean^2)/sum(wt*y^2)
	list(goodness= goodness, direction=sign(lmean))
	}
    else {
	# Categorical X variable
	ux <- sort(unique(x))
	wtsum <- tapply(wt, x, sum)
	ysum  <- tapply(y*wt, x, sum)
	means <- ysum/wtsum

	# For anova splits, we can order the categories by their means
	#  then use the same code as for a non-categorical
	ord <- order(means)
	n <- length(ord)
	temp <- cumsum(ysum[ord])[-n]
	left.wt  <- cumsum(wtsum[ord])[-n]
	right.wt <- sum(wt) - left.wt
	lmean <- temp/left.wt
	rmean <- -temp/right.wt
	list(goodness= (left.wt*lmean^2 + right.wt*rmean^2)/sum(wt*y^2),
	     direction = ux[ord])
	}
    }

# The init function:
#   fix up y to deal with offsets
#   return a dummy parms list
#   numresp is the number of values produced by the eval routine's "label"
#   numy is the number of columns for y
#   summary is a function used to print one line in summary.rpart
# In general, this function would also check for bad data, see rpart.poisson
#   for instace.
temp3 <- function(y, offset, parms, wt) {
    if (!is.null(offset)) y <- y-offset
    list(y=y, parms=0, numresp=1, numy=1,
	      summary= function(yval, dev, wt, ylevel, digits ) {
		  paste("  mean=", format(signif(yval, digits)),
			", MSE=" , format(signif(dev/wt, digits)),
			sep='')
	     })
    }


alist <- list(eval=temp1, split=temp2, init=temp3)

fit1 <- rpart(income ~population +illiteracy  + murder + hs.grad + region,
	     mystate, control=rpart.control(minsplit=10, xval=0),
	     method=alist)
```


## 關卡 63
我們可以利用`predict`函數來使用學習好的cfit函數做預測。舉例來說，`predict(cfit,stagec)`就可以用我們學到的模型回頭預測stagec的pgstat的值。請同學試試看。
```r
predict(cfit, stagec)
```


## 關卡 64
如果同學想要對rpart套件提供的預測函數`predict`有更多的了解可以輸入：`?predict.rpart`注意歐，這裡我們使用的並不是`?predict`，因為這裡rpart套件採用了R的S3物件導向方法。由於`class(cfit)`的輸出是`rpart`，所以`predict`函數最後會呼叫`predict.rpart`來對cfit做處理，相關的說明文件也會放在`?predict.rpart`之中。
```r
?predict.rpart
```


## 關卡 65
以上就是對rpart這個套件的介紹。


## 關卡 66
最後我們再次使用rpart來挑戰mlbench的Ionosphere資料
```r
check_then_install("mlbench", "2.1.1")
library(mlbench)
# 方便起見，同學可以使用這個函數計算 Logarithmic Loss
logloss <- function(y, p, tol = 1e-4) {
  # tol 的用途是避免對0取log所導致的數值問題
  p[p < tol] <- tol
  p[p > 1 - tol] <- 1-tol
  -sum(y * log(p) + (1 - y) * log(1-p))
}

data(Ionosphere)
test.i <- c(4L, 6L, 9L, 13L, 14L, 22L, 31L, 33L, 50L, 52L, 61L, 63L, 68L, 
            79L, 91L, 99L, 119L, 135L, 154L, 155L, 160L, 162L, 166L, 194L, 
            200L, 219L, 233L, 236L, 237L, 242L, 244L, 248L, 250L, 257L, 261L, 
            276L, 278L, 283L, 292L, 310L, 312L, 315L, 319L, 323L, 325L, 327L, 
            335L, 337L, 338L, 344L)
df.test <- Ionosphere[test.i,-2] # remove V2
train.i <- setdiff(seq_len(nrow(Ionosphere)), test.i)
df.train <- Ionosphere[train.i,-2]

# 請利用rpart，從df.train上學出一個模型
# 該模型在df.test上的logloss需要小於12
answer_05 <- local({
  NULL
  # 請調整以下的程式碼
  # Hint : 多試試看幾種不同的 minsplit
  rpart(Class ~ ., data = df.train, control = rpart.control(minsplit=50))
})

stopifnot(class(answer_05) == c("rpart"))
if (interactive()) {
  stopifnot(local({
    p <- predict(answer_05, df.test)[,"good"]
    logloss(df.test$Class == "good", p) < 12
  }))
}

# 完成後，請存檔後回到console輸入`submit()`
```

