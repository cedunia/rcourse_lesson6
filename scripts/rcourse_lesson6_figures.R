## READ IN DATA ##
source("scripts/rcourse_lesson6_cleaning.R")

## LOAD PACKAGES ##
library(ggplot2)
library(RColorBrewer)

## ORGANIZE DATA ##
# Accuracy data
data_accuracy_figs <- data_accuracy_clean %>%
  group_by(subject_id, congruency, half) %>%
  summarise(perc_correct = mean(accuracy)*100) %>%
  ungroup() %>%
  mutate(congruency = factor(congruency, 
                             levels = c("con", "incon"),
                             labels = c("congruent", "incongruent")))

# RT data
data_rt_figs <- data_rt_clean %>%
  mutate(congruency = factor(congruency, 
                             levels = c("con", "incon"),
                             labels = c("congruent", "incongruent")))

## SET COLORS FOR FIGURES ##
cols <- brewer.pal(5, "PuOr")
col_con <- cols[1]
col_incon <- cols[5]

## MAKE FIGURES ##

# Accuracy figure
accuracy.plot <- ggplot(data_accuracy_figs, aes(x = half,
                                                y = perc_correct,
                                                fill = congruency)) +
  geom_boxplot() +
  ylim(0,100) +
  geom_hline(yintercept = 50) +
  scale_fill_manual(values = c(col_con, col_incon)) +
  ggtitle("Accuracy on Stroop Task\n by Experiment Half and Trial Congruency") +
  xlab("Experiment half") +
  ylab("Percent correct") +
  theme_classic() +
  theme(text = element_text(size=18),
        title = element_text(size=18),
        legend.position = "top")

pdf("figures/accuracy.pdf")
accuracy.plot
dev.off()

# RT histogram
rt_histogram.plot <- ggplot(data_rt_figs, aes(x = rt,
                                              fill = congruency)) +
  geom_histogram(bins = 30) +
  facet_grid(half ~ congruency) +
  scale_fill_manual(values = c(col_con, col_incon)) +
  ggtitle("Reactions Time by\nExperiment Half and Trial Congruency") +
  xlab("Experiment half and trial congruency") +
  ylab("Reaction times (ms)") +
  theme_classic() +
  theme(text=element_text(size=18), title=element_text(size=18),
        legend.position="none",
        strip.background = element_rect(color="white", fill="white"))

pdf("figures/rt_histogram.pdf")
rt_histogram.plot
dev.off()

# RT log10 histogram
rt_log10_histogram.plot <- ggplot(data_rt_figs, aes(x = rt_log10,
                                              fill = congruency)) +
  geom_histogram(bins = 30) +
  facet_grid(half ~ congruency) +
  scale_fill_manual(values = c(col_con, col_incon)) +
ggtitle("Reaction Times Log 10 Tranformed by\nExperiment Half and Trial Congruency") +
  xlab("Experiment half and trial congruency") +
  ylab("Reaction times (log 10)") +
  theme_classic() +
  theme(text=element_text(size=18), title=element_text(size=18),
        legend.position="none",
        strip.background = element_rect(color="white", fill="white"))
pdf("figures/rt_log10_histogram.pdf")
rt_log10_histogram.plot
dev.off()

# RT log10 boxplot
rt_log10_boxplot.plot <- ggplot(data_rt_figs, 
                                aes(x = half, 
                                    y = rt_log10,
                                    fill = congruency)) +
  geom_boxplot() +
  scale_fill_manual(values = c(col_con, col_incon)) +
  # Add a title
  ggtitle("Reaction Times Log 10 Tranformed by\nExperiment Half and Trial Congruency") +
  # Customize the x-axis
  xlab("Experiment half and trial congruency") +
  # Customize the y-axis
  ylab("Reaction times (log 10)") +
  # Remove dark background
  theme_classic() +
  # Additional paramaters for displaying plot
  theme(text=element_text(size=18), title=element_text(size=18),
        legend.position="none",
        strip.background = element_rect(color="white", fill="white"))
pdf("figures/rt_log10.pdf")
rt_log10_boxplot.plot
dev.off()

