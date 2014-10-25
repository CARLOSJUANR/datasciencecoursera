#PROYECTO
#######   working directory
#######  "/home/jcr/Documentos/coursera"

library(DBI)
library(sqldf)

Data_Medicion1<-read.table("./X_train.txt",header = FALSE)
head(Data_Medicion1)

Data_Medicion2<-read.table("./X_test.txt",header = FALSE)
head(Data_Medicion2)

# tabla con las variables de los sub grupos
sub_grupo1<-read.table("./subject_train.txt",header=FALSE,col.names ="V562",as.is=TRUE)
head(sub_grupo1)

sub_grupo2<-read.table("./subject_test.txt",header=FALSE,col.names ="V562",as.is=TRUE)
head(sub_grupo2)

# tabla con la variables de las etiquetas de las actividades
actividad1<-read.table("./y_train.txt",header=FALSE,col.names ="V563",as.is=TRUE)
head(actividad1)
actividad2<-read.table("./y_test.txt",header=FALSE,col.names="V563", as.is=TRUE)
head(actividad2)

Data_TRAIN<-cbind(Data_Medicion1,sub_grupo1,actividad1)
head(Data_TRAIN)
names(Data_TRAIN)

Data_TEST<-cbind(Data_Medicion2,sub_grupo2,actividad2)
head(Data_TEST)
names(Data_TEST)


#DATA 

ONEDATA<-rbind(Data_TRAIN,Data_TEST)
head(ONEDATA)
names(ONEDATA)


#obtenemos un vector de las variables
Nom_var<-read.table("./features.txt",header = FALSE,as.is = TRUE)
Nom_var

p1 <-c("562","Subconj")
p2 <-c("563","activity")


Nom_varFinal<-rbind(Nom_var,p1,p2)
Nom_varFinal
var<-Nom_varFinal[,2]
var
is.vector(var)

#renombramos las variables de acuerdo al vector de variables
names(ONEDATA)<-var
names(ONEDATA)

#CREAMOS LAS ETIQUETAS PARA LAS ACTIVIDADES 
ONEDATA$activity<-factor(ONEDATA$activity)
str(ONEDATA$activity)
ONEDATA$activity<-factor(ONEDATA$activity,levels=c(1:6),labels=c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING"))
str(ONEDATA$activity)
names(ONEDATA)

head(ONEDATA)

#identificar los nombres de columnas que contienen las palabras mean,std,Subconj y activity
vecpru<-names(ONEDATA)
names(ONEDATA)
total<-grep("mean|std|Subconj|activity",vecpru) 
NewData<-ONEDATA[ ,total]
names(NewData)

####CREACION DE OTRA DATA CON LOS PROMEDIOS DE CADA VARIABLE PARA CADA ACTIVIDAD Y SUBCONJUNTO
install.packages("plyr")
install.packages("reshape2")
library(plyr)
library(reshape2)

nombe<-names(NewData[ ,1:79])
nombe
datosMelt<-melt(NewData,id=c("Subconj","activity"),measure.vars=nombe)
head(datosMelt,n=5)
medias<-dcast(datosMelt, activity ~ variable,mean)
medias
names(medias)

#archivo en formato txt para subirlo
#write.table(medias,file="Data_Media.txt",row.names=FALSE)
