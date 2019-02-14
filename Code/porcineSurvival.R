# - - - - - - - - - - - - - - - - - - - - -#
# File: 	porcineSurvival.R
# Descripion: 	Identify probability of death at 24 hour for patients treated with prFVIII
# Created by: 	C.K.
# Created on: 	2/10/2019
# Modified by:	C.K. 
# Modified on:	2/10/2019
# - - - - - - - - - - - - - - - - - - - - -#

# Create dataset
library("dplyr")
library("flexsurv")
dfp <- data.frame(
		  id = seq(1,25),
		  #time = c(rep(6,25-7), 
		  time = c(rep(6+34,25-7),  # we use maximum time here
			   6+6, 6+1, 6+2, 6+34, 6+23,6+7, 6+4
			   ),
		  status = c(rep(0,25-7),
			     rep(1,7)
			     )
		  ) 

# Analyze
library("survival")
fit <- survfit(Surv(time, status) ~ 1, data = dfp)
fitcph <- coxph(Surv(time, status) ~ 1, data = dfp)
fitexp <- flexsurvreg(Surv(time, status) ~ 1, data = dfp, dist="exponential")
fitexp2 <- survreg(Surv(time, status) ~ 1, data = dfp, dist="exponential")

survest <- stepfun(fit$time, c(1, fit$surv))
print(
      survest(0:10)
      )

print(
      getwd()
      )

print(
      c(fitexp$coefficients, fitexp$coefficients)
      )

(CI_summary <- summary(survfit(fitcph, type="aalen", se.fit=TRUE, conf.int = 0.95), times=50))
print(
      CI_summary$table
      )

# probability of death at t=1
print(
      paste0("Death probability at day 1 = ",
      round(pexp(1, exp(fitexp$coefficients)), 5)
      )
      )
x = 1:40

# save plot
pdf("../Figure/survplot.pdf")
plot(fit)
plot(fitexp)
plot(x, pexp(x, rate= exp(fitexp$coefficients), lower.tail = FALSE ), ylim=c(0,1))
dev.off()
