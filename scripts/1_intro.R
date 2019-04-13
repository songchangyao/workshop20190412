#设定路径
getwd()
setwd("/Users/changyaosong/Desktop/Rstudio/workshop_data carpentry_20190412")

#新建文件夹/管理文件
dir.create("data")
dir.create("data_output")
dir.create("fig_output")

#从website下载data
download.file("https://ndownloader.figshare.com/files/11492171",
              "data/SAFI_clean.csv", mode = "wb")


area <- 1
(area <- 1)

length <- pi
width <- exp(1)
area <- length*width

#base function
sqrt(9) #开方
round(2.4999999,digits = 2)  #取值
round(2.4999999,2)
args(round)
args(sqrt)

#vectors and data types
no_membrs <- c(3, 7, 10, 6)
no_membrs
respondent_wall_type <- c("muddaub", "burntbricks", "sunbricks")
respondent_wall_type
length(no_membrs)
length(respondent_wall_type)
class(no_membrs)
class(respondent_wall_type)
str(no_membrs)
str(respondent_wall_type)
possessions <- c("bicycle", "radio", "television")
possessions <- c(possessions, "mobile_phone") # add to the end of the vector
possessions <- c("car", possessions) # add to the beginning of the vector
possessions

num_char <- c(1, 2, 3, "a")
class(num_char)
 
num_logical <- c(1, 2, 3, TRUE)   #TRUE =1 FALSE=0
class(num_logical)
num_logical
 
char_logical <- c("a", "b", "c", TRUE)
class(char_logical)
char_logical
tricky <- c(1, 2, 3, "4")
class(tricky)
tricky

#subsetting vectors
respondent_wall_type <- c("muddaub", "burntbricks", "sunbricks")
respondent_wall_type[2]
respondent_wall_type[c(3,1)]

#Conditional subsetting
no_membrs <- c(3, 7, 10, 6)
no_membrs[c(TRUE, FALSE, TRUE, TRUE)]
no_membrs > 5
no_membrs[no_membrs > 5]
no_membrs[no_membrs < 3 | no_membrs > 5]   #  | means 或
no_membrs[no_membrs < 3 & no_membrs > 5]   #  & means 和

possessions <- c("car", "bicycle", "radio", "television", "mobile_phone")
possessions[possessions == "car" | possessions == "bicycle"] 
possessions %in% c("car", "bicycle", "motorcycle", "truck", "boat")
possessions[possessions %in% c("car", "bicycle", "motorcycle", "truck", "boat")]

#missing value
rooms <- c(2, 1, 1, NA, 4)
mean(rooms)
max(rooms)
mean(rooms, na.rm = TRUE)
max(rooms, na.rm = TRUE)
min(rooms,na.rm = TRUE)

rooms[!is.na(rooms)]   ### Extract those elements which are not missing values.
na.omit(rooms)
rooms[complete.cases(rooms)]

#excecise
rooms <- c(1, 2, 1, 1, NA, 3, 1, 3, 2, 1, 1, 8, 3, 1, NA, 1)
rooms <- rooms[!is.na(rooms)]
rooms
median(rooms)
median(rooms,na.rm = TRUE)
rooms[rooms==2]
count(data.frame(rooms),rooms==2)
