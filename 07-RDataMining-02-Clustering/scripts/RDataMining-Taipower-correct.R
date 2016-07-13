# 請先安裝套件
install.packages("reshape2") # 安裝 `reshape2` 套件
install.packages("vegan")
install.packages("ggplot2")
install.packages("ggdendro")

# 載入套件
library(reshape2) 
library(vegan)
library(ggplot2)
library(ggdendro)

# 讀取103年台電得到發標案最高的前一百間公司決標公告
Taipower <- read.csv(("https://johnsonhsieh.github.io/DSC2016-R/data/Taipower_top100.csv"), fileEncoding = "big5")

# 篩選出總決標金額最高的10間公司, 指向 TP10 物件
top10 <- group_by(Taipower, tenderer_name) %>%
  summarise(value=sum(as.numeric(total_tender_awarding_value), na.rm = TRUE), count=n()) %>%
  arrange(-value) %>% slice(1:10)

TP10 <- filter(Taipower, tenderer_name%in%top10$tenderer_name)


# 建構這10間公司與標案類別的 incidence matrix
is.present <- function(x){
  y <- sum(as.numeric(x)>0, na.rm = TRUE)
  ifelse(y>0, 1, 0)
}

TP10.inc <- dcast(TP10, tenderer_name ~ attr_of_procurement, value.var = "total_tender_awarding_value", fun.aggregate = is.present)
rownames(TP10.inc) <- TP10.inc[,1]
TP10.inc <- TP10.inc[,-1] # 第一欄結果指向rownames, 並移除第一欄

d <- vegdist((TP10.inc), method = "jaccard")
hc <- hclust(d)
plot(hc) # 繪製

## ggplot2 style

dhc <- as.dendrogram(hc)
ddata <- dendro_data(dhc, type = "rectangle")
p <- ggplot(segment(ddata)) + 
  geom_segment(aes(x = x, y = y, xend = xend, yend = yend)) + 
  coord_flip() + 
  scale_y_reverse(expand = c(0., 0.4))  +
  geom_text(data = ddata$labels, family="STHeiti",
            aes(x = x, y = y-0.01, label = label), size = 3, hjust = 0)
p 

