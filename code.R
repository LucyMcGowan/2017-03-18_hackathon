library('dplyr')
library('jsonlite')
httr::GET("http://data.nashville.gov/resource/geur-py3i.json") %>%
  httr::content("parsed") %>%
  purrr::map_df(as.data.frame) -> dat_df


dat_df %>%
  group_by(park_name) %>% 
  summarise_each(funs(list)) %>% 
  toJSON(pretty=TRUE) -> dat_json

dat_json <- gsub('\\[\\"', '\\"',dat_json)
dat_json <- gsub('\\"\\]', '\\"',dat_json)
dat_json <- gsub('\\[false\\]',"false",dat_json)
dat_json <- gsub('\\[null\\]',"null",dat_json)
dat_json <- gsub('\\[true\\]',"true",dat_json)
dat_json <- gsub('\\.latitude',"_latitude",dat_json)
dat_json <- gsub('\\.longitude',"_longitude",dat_json)
dat_json <- gsub('\\.needs_recording',"_needs_recording",dat_json)
dat_json <- gsub('\\.human_address',"_human_address",dat_json)

write(dat_json,file = "park_dat_json.txt")
write.csv(dat_df, file = "park_dat.csv")