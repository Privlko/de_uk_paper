library(sjPlot)
library(sjlabelled)
library(sjmisc)
library(ggplot2)

data(efc)
theme_set(theme_sjplot())


View(efc)

# create binary response
y <- ifelse(efc$neg_c_7 < median(na.omit(efc$neg_c_7)), 0, 1)

# create data frame for fitting model
df <- data.frame(
  y = to_factor(y),
  sex = to_factor(efc$c161sex),
  dep = to_factor(efc$e42dep),
  barthel = efc$barthtot,
  education = to_factor(efc$c172code)
)

# set variable label for response
set_label(df$y) <- "High Negative Impact"

# fit model
m1 <- glm(y ~., data = df, family = binomial(link = "logit"))


plot_model(m1, vline.color = 'darkred',
           order.terms = c(5, 6, 7, 1, 2, 3, 4),
           transform = NULL,
           show.values = TRUE,
           value.offset = 0.33,
           axis.title = "truth",
           title = "penis")
           

plot_model(fit1, vline.color = 'darkgreen',
           sort.est = TRUE)
summary(m1)

plot_model(m1, order.terms = c(5, 6, 7, 1, 2, 3, 4))


#source:
# https://cran.r-project.org/web/packages/sjPlot/vignettes/plot_model_estimates.html