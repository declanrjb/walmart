plot_usmap(data = state_counts, values = "count", color = "black") + 
  theme(legend.position = "right", legend.key.height=unit(1,'cm')) + 
  scale_fill_continuous(name = "Walmarts (2023)",low="white",high="red") +
  labs(title = "United Walmarts of America",
       subtitle = "U.S. states by number of Walmarts, 2023.")