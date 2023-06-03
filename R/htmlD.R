# Hello, world!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Install Package:           'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'

library(reticulate)
library(rvest)

# Python
is_python <- py_available()
python_version <- "3.11.3"
if(is_python == FALSE){
  install_python(python_version)
}

# VirtualEnv
vname <- "rsl"
is_virtualenv <- virtualenv_exists(vname)
if(is_virtualenv == FALSE){
  virtualenv_create(vname,version = python_version)
}
use_virtualenv(vname)

# Selenium
is_selenium <- py_module_available("selenium")
if(is_selenium == FALSE){
  py_install("selenium")
}

load_url <- function(url){
  selenium <- import("selenium",convert = TRUE)
  driver <- selenium$webdriver$Chrome("./chromedriver_win32/chromedriver.exe")
  driver$get(url)
  content <- read_html(driver$page_source)
  driver$close()
  return(content)
}

#print(load_url("https://r-pkgs.org/setup.html"))