# R 語言資料工程及探勘實務 (DSC2016) 課程教材

作者群
- 吳齊軒 / 國立臺灣大學電機所博士生
- 許懷中 / 中研院資科所博士後研究員
- 謝宗震 / DSP 智庫驅動資料科學家


## 安裝Swirl課程

- 請檢查是否使用 `http://wush978.github.io` 上的swirl套件：

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
install_course_github("JohnsonHsieh", "DSC2016-R", "course")
```

- 如果安裝有問題，請清空過往課程
```
library(swirl)
delete_progress("user_name") # 修該user_name成為同學的暱稱
uninstall_all_courses() # 移除所有舊課程
install_course_github("JohnsonHsieh", "DSC2016-R", "course")
```

## 課程公布欄
- [共同筆記](https://dsp.hackpad.com/R--zX1JuCX7uEF)
- [關卡提示](https://johnsonhsieh.github.io/DSC2016-R/note/)
- [討論聊天](https://gitter.im/JohnsonHsieh/DSC2016-R)
- [臭蟲回報](https://github.com/JohnsonHsieh/DSC2016-R/issues)
