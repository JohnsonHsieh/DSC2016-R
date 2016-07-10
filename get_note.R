library(magrittr)
library(yaml)
library(git2r)

get_lecture_note <- function(course, out_dir = tempdir()) {
  
  from_text <- function(level, i) {
    sprintf("
## 關卡 %d
%s
", i, gsub("\\s", "", level$Output))
  }
  
  from_cmd_question <- function(level, i) {
    sprintf("
## 關卡 %d
%s
```r
%s
```
", i, gsub("\\s", "", level$Output), level$CorrectAnswer)
  }
  
  from_mult_question <- function(level, i) {
    sprintf("
## 關卡 %d
%s
%s
", i, gsub("\\s", "", level$Output), level$CorrectAnswer)
  }
  
  from_script <- function(level, i) {
    script_path <- file.path(dirname(course), "scripts", level$Script)
    correct_script_path <- file.path(dirname(course), "scripts", gsub(".R", "-correct.R", level$Script, fixed = TRUE))
    if (file.exists(correct_script_path)) {
      script <- readLines(correct_script_path)
    } else {
      script <- readLines(script_path)
    }
    script <- script %>%
      paste(collapse = "\n")
    sprintf("
## 關卡 %d
%s
```r
%s
```
", i, gsub("\\s", "", level$Output), script)
  }
  
  content <- yaml.load_file(course)
  retval <- character(0)
  for(i in seq_along(content) %>% tail(-1)) {
    operator <- get(sprintf("from_%s", content[[i]]$Class))
    retval %<>% append(operator(content[[i]], i - 1))
  }
  html_file <- file.path(out_dir, sprintf("%s.html", dirname(course) %>% basename())) %>%
    gsub(pattern = "/./", replacement = "/", fixed = TRUE) %>%
    gsub(pattern = "^\\.", replacement = getwd()) %>%
    normalizePath(mustWork = FALSE)
  rmd_file <- file.path(out_dir, sprintf("%s.Rmd", dirname(course) %>% basename())) %>%
    gsub(pattern = "/./", replacement = "/", fixed = TRUE) %>%
    gsub(pattern = "^\\.", replacement = getwd()) %>%
    normalizePath(mustWork = FALSE)
  md_file <- file.path(out_dir, sprintf("%s.md", dirname(course) %>% basename())) %>%
    gsub(pattern = "/./", replacement = "/", fixed = TRUE) %>%
    gsub(pattern = "^\\.", replacement = getwd()) %>%
    normalizePath(mustWork = FALSE)
  
  #rmd_file <- tempfile(fileext = ".Rmd")
  write(retval, file = rmd_file)
  #md_file <- tempfile(fileext = ".md")
  #knitr::knit(rmd_file, md_file)
  # browser()
  


  #   html_file <- tempfile(fileext = ".html")
  #   browser()
  rmarkdown::render(rmd_file, "html_document", html_file)
  
  invisible(html_file)
}


get_lecture_note("TM-RStatistics-01-EDA/lesson.yaml", "./note")
get_lecture_note("TM-RStatistics-02-MonteCarlo/lesson.yaml", "./note")
get_lecture_note("TM-RStatistics-03-AB-Testing/lesson.yaml", "./note")
