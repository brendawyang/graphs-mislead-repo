library(scales)
g <- ggplot() + 
  geom_bar(data = graph_data, 
           aes(x = reorder(Variable, as.numeric(Variable)),
               y = Value),stat = "identity", fill=rgb(0,0,0, maxColorValue = 255), width = 0.8) +
  coord_cartesian(xlim=c(1, nrow(graph_data)))+
  ylab(graph_data$Y.axis.label)+
  xlab(graph_data$X.axis.label)+
  ggtitle(str_wrap(graph_data$Graph.Title, width = 200))+ 
  #ggtitle(graph_data$Graph.Title) + 
  scale_x_discrete(labels = function(x) str_wrap(x, width = 12)) +
  scale_y_continuous(oob = squish, limits = c(500,max(graph_data$Value))) 

g <- g +  annotate('rect', xmin=0, xmax=0.5, ymin=500, ymax=max(graph_data$Value), fill='blue', alpha=1/3)
# Convert into a gical object -- a grob
g <- ggplotGrob(g)
i <- which(g$layout$name == 'panel')
g$layout[i,'clip'] <- 'off'
i <- which(g$layout$name == 'axis-t')
g$layout[i,'clip'] <- 'on'
#grid.newpage()
grid.draw(g)
#ggsave("createimages_trial.png", plot = g, width = 10, height = 5)