# StatMLDM

我用來教授統計、機器學習與資料探勘的教材

## 安裝Swirl課程

- 請檢查是否使用`http://wush978.github.io`上的swirl套件：

```
tryCatch({
  # Error if we need to install swirl
  if (!"swirl" %in% rownames(installed.packages())) stop("install swirl")
  if (packageVersion("swirl") < package_version("2.3.1-4")) stop("install swirl")
}, error = function(e) {
  if (conditionMessage(e) == "install swirl") {
    install.packages("swirl", repos = "http://wush978.github.io/R")
  }
})
```

- 載入swirl，並且安裝課程
```
library(swirl)
install_course_github("JohnsonHsieh", "StatMLDM", "tm")
```

- 如果安裝有問題，請清空過往課程
```
library(swirl)
delete_progress("user_name") # 修該user_name成為同學的暱稱
uninstall_all_courses() # 移除所有舊課程
install_course_github("JohnsonHsieh", "StatMLDM", "tm")
```

## 課程筆記
- [TM-RStatistics-01-EDA](https://JohnsonHsieh.github.io/StatMLDM/note/TM-RStatistics-01-EDA.html)
- [TM-RStatistics-02-MonteCarlo](https://JohnsonHsieh.github.io/StatMLDM/note/TM-RStatistics-02-MonteCarlo.html)
- [TM-RStatistics-03-AB-Testing](https://JohnsonHsieh.github.io/StatMLDM/note/TM-RStatistics-03-AB-Testing.html)
