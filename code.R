library('dplyr')
library('jsonlite')
httr::GET("http://data.nashville.gov/resource/geur-py3i.json") %>%
  httr::content("parsed") %>%
  purrr::map_df(as.data.frame) -> dat_df


dat_df %>%
  group_by(park_name) %>% 
  summarise_each(funs(list)) %>% 
  toJSON(pretty=TRUE) -> dat_json

write(dat_json,file = "park_dat_json.txt")
write.csv(dat_df, file = "park_dat.csv")