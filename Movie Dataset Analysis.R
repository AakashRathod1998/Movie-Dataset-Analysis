# ----------------- MOVIE DATASET ------------ #

# ------------ Preparing the Data

library(ggplot2)
# import movie data
movie = read.csv(file.choose(), stringsAsFactors = T)

# checking data
head(movie)
str(movie)
summary(movie)

# Renaming Columns
colnames(movie) <- c("Film", "Genre", "CriticR", "AudienceR", "Budget_in_M", "Year")
head(movie)

# Setting Year column as FACTOR
movie$Year <- factor(movie$Year)
head(movie)
str(movie)
summary(movie)

# ------------- Visualizing data using GGPLOT()

# basic format
ggplot(data=movie, aes(x=CriticR, y=AudienceR))

# adding Points
ggplot(data=movie, aes(x=CriticR, y=AudienceR)) + 
       geom_point()

# adding Colors
ggplot(data=movie, aes(x=CriticR, y=AudienceR, color=Genre)) + 
  geom_point()

# setting size
ggplot(data=movie, aes(x=CriticR, y=AudienceR, color=Genre, size=Budget_in_M)) + 
  geom_point()

# Assigning the plotting to a variable
q = ggplot(data=movie, aes(x=CriticR, y=AudienceR, color=Genre, size=Budget_in_M))

# overriding aes
q + geom_point(aes( color=Budget_in_M, size=CriticR))
q + geom_point(aes(x=Budget_in_M)) + xlab("Budget in Millions $")

# multiple graph plotting
q + geom_line() + geom_point()
# reduce line size
q + geom_line(size=0.5) + geom_point()

# --------------- Mapping vs Setting -------------- #
# inside aes() means mapping or else setting
r <- ggplot(data=movie, aes(x=CriticR, y= AudienceR))
r + geom_point()

# -- Add Color
# Mapping
r + geom_point(aes(color=Genre))

# Setting
# ERROR: this color setting
# -->> r + geom_point(aes(colour="DarkGreen"))
r + geom_point(colour="DarkGreen")

# -- Size  
# Mapping
r + geom_point(aes(size=Budget_in_M))
# Setting
r + geom_point(size=7)


# ----------- Histogram and Density Charts ------ #

s <- ggplot(data=movie, aes(x=Budget_in_M))
s + geom_histogram(binwidth = 5)

# add color
# FILL= is used to fill color, COLOR= adds border
s + geom_histogram(binwidth = 10, aes(fill=Genre), colour="Black")

# --- Density Chart
# not used much
s + geom_density(aes(fill=Genre), position = "stack")


# ------------- Starting Layer Tips ------------- #

# dynamically creating charts
t <- ggplot(data=movie)
t + geom_histogram(binwidth = 10, aes(x=CriticR),
                   fill = "LightYellow", color = "Black")


# ----------- Statistical Transformation ------------#

# GEOM_SMOOTH()
u <- ggplot(data=movie, aes(x=CriticR, y=AudienceR, color=Genre))
u + geom_point() + geom_smooth()
u + geom_point() + geom_smooth(fill=NA)

# BOXPLOTS
u <- ggplot(data=movie, aes(x=Genre, y=AudienceR, color=Genre))
u + geom_jitter() + geom_boxplot(size=1.2, alpha=0.5)


# --------------- Using Facets -------------#
v <- ggplot(data=movie, aes(x=CriticR))
v + geom_histogram(binwidth = 10, aes(fill=Genre), color="Black")

# facets
v + geom_histogram(binwidth = 10, aes(fill=Genre), color="Black") +
  facet_grid(.~Genre)
v + geom_histogram(binwidth = 10, aes(fill=Genre), color="Black") +
  facet_grid(Genre~.)

# Variable Scale
v + geom_histogram(binwidth = 10, aes(fill=Genre), color="Black") +
  facet_grid(Genre~., scales = "free")

# Scatterplot with Facets
w <- ggplot(data=movie, aes(x=CriticR, y=AudienceR, color=Genre))
w + geom_point(aes(size=Budget_in_M)) + 
  facet_grid(Genre~Year, scales="free") +
  geom_smooth()

# ------------- Coordinates ----------- #
m <- ggplot(data=movie, aes(x=CriticR, y=AudienceR, 
                             size=Budget_in_M,
                             color=Genre))
m + geom_point()

# Limiting the Axis
m + geom_point() +
  xlim(50,100) +
  ylim(50,100)

# Wont always work well
n <- ggplot(data=movie, aes(x=Budget_in_M))
n + geom_histogram(binwidth = 10, aes(fill=Genre)) +
  ylim(0,50)

# instead we use ZOOM in
n + geom_histogram(binwidth = 10, aes(fill=Genre), color="Black") +
  coord_cartesian(ylim = c(0,50))
                  

# --- Now we apply this to scaterplot of w variable
w <- ggplot(data=movie, aes(x=CriticR, y=AudienceR, color=Genre))
w + geom_point(aes(size=Budget_in_M)) + 
  facet_grid(Genre~Year, scales="free") +
  geom_smooth() +
  coord_cartesian(ylim = c(0,100))


# ---------------- Applying Themes ------------------ # 

o <- ggplot(data=movie, aes(x=Budget_in_M))
o + geom_histogram(binwidth = 10,aes(fill="Yellow"), color="Black")

h <- o + geom_histogram(binwidth = 10,aes(fill=Genre), color="Black")

h +
  xlab("Money Axis") + 
  ylab(" No. of Movies") +
  ggtitle("Movie Budget Distribution") +
  theme(axis.title.x = element_text(color = "DarkGreen", size=30),
        axis.title.y = element_text(color = "DarkGreen", size=30),
        
        axis.text.x = element_text(size=20),
        axis.text.y = element_text(size=20),
        
        legend.title = element_text(size=30),
        legend.text = element_text(size=20),
        legend.position = c(1,1),
        legend.justification = c(1,1),
        
        plot.title = element_text(color = "DarkGreen", size=30))
