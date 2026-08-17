# ============================================================
# NETFLIX DATA ANALYSIS PROJECT
# Complete R Analysis & Visualization Script
# ============================================================

# ------------------------------------------------------------
# 1. INSTALL PACKAGES (Run once if required)
# ------------------------------------------------------------
# install.packages(c("dplyr", "ggplot2", "tidyr", "stringr",
#                    "treemapify", "scales"))

# ------------------------------------------------------------
# 2. LOAD LIBRARIES
# ------------------------------------------------------------
library(dplyr)
library(ggplot2)
library(tidyr)
library(stringr)
library(treemapify)
library(scales)

# ------------------------------------------------------------
# 3. LOAD DATASET
# ------------------------------------------------------------
# Keep netflix_titles.csv in your working directory.
netflix <- read.csv("netflix_titles.csv",
                    stringsAsFactors = FALSE)

# Basic dataset information
cat("Rows:", nrow(netflix), "\n")
cat("Columns:", ncol(netflix), "\n")
print(names(netflix))

# ------------------------------------------------------------
# 4. BASIC DATA CLEANING
# ------------------------------------------------------------

# Convert empty strings to NA
netflix[netflix == ""] <- NA

# Clean date_added
netflix$date_added <- as.Date(
  trimws(netflix$date_added),
  format = "%B %d, %Y"
)

# Extract year from date_added
netflix$added_year <- as.integer(
  format(netflix$date_added, "%Y")
)

# Extract month from date_added
netflix$added_month <- format(
  netflix$date_added,
  "%B"
)

# ------------------------------------------------------------
# 5. BASIC CONTENT TYPE ANALYSIS
# ------------------------------------------------------------

type_count <- netflix %>%
  filter(!is.na(type)) %>%
  count(type, name = "total_titles") %>%
  arrange(desc(total_titles))

print(type_count)

ggplot(type_count,
       aes(x = type,
           y = total_titles,
           fill = type)) +
  geom_col(width = 0.65) +
  geom_text(aes(label = total_titles),
            vjust = -0.4,
            size = 5) +
  labs(
    title = "Netflix Movies vs TV Shows",
    x = "Content Type",
    y = "Number of Titles"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 18, face = "bold"),
    legend.position = "none"
  )

# ------------------------------------------------------------
# 6. TOP 10 NETFLIX RATINGS
# ------------------------------------------------------------

top_ratings <- netflix %>%
  filter(!is.na(rating)) %>%
  count(rating, name = "total_titles") %>%
  arrange(desc(total_titles)) %>%
  head(10)

print(top_ratings)

ggplot(top_ratings,
       aes(x = reorder(rating, total_titles),
           y = total_titles,
           fill = total_titles)) +
  geom_col() +
  geom_text(aes(label = total_titles),
            hjust = -0.1,
            size = 4) +
  coord_flip() +
  scale_fill_gradient(
    low = "skyblue",
    high = "darkblue"
  ) +
  labs(
    title = "Top 10 Netflix Content Ratings",
    x = "Rating",
    y = "Number of Titles"
  ) +
  theme_minimal() +
  theme(
    legend.position = "none",
    plot.title = element_text(size = 18, face = "bold")
  )

# ------------------------------------------------------------
# 7. MOVIES VS TV SHOWS BY RATING
# ------------------------------------------------------------

rating_type <- netflix %>%
  filter(!is.na(rating), !is.na(type)) %>%
  group_by(rating, type) %>%
  summarise(
    total_titles = n(),
    .groups = "drop"
  )

rating_type_top <- rating_type %>%
  filter(rating %in% top_ratings$rating)

ggplot(rating_type_top,
       aes(x = reorder(rating, total_titles),
           y = total_titles,
           fill = type)) +
  geom_col(position = "dodge") +
  coord_flip() +
  labs(
    title = "Movies vs TV Shows by Rating",
    x = "Rating",
    y = "Number of Titles",
    fill = "Content Type"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 18, face = "bold")
  )

# ------------------------------------------------------------
# 8. GENRE ANALYSIS
# ------------------------------------------------------------

# Split multiple genres from listed_in
genre_data <- netflix %>%
  filter(!is.na(listed_in)) %>%
  separate_rows(listed_in, sep = ",\\s*")

genre_analysis <- genre_data %>%
  group_by(listed_in) %>%
  summarise(
    total_titles = n(),
    .groups = "drop"
  ) %>%
  arrange(desc(total_titles))

top_20_genres <- genre_analysis %>%
  head(20)

print(top_20_genres)

# ------------------------------------------------------------
# 9. TOP 20 GENRES BAR CHART
# ------------------------------------------------------------

ggplot(top_20_genres,
       aes(x = reorder(listed_in, total_titles),
           y = total_titles,
           fill = total_titles)) +
  geom_col() +
  geom_text(
    aes(label = total_titles),
    hjust = -0.1,
    size = 4
  ) +
  coord_flip() +
  scale_fill_gradient(
    low = "skyblue",
    high = "darkblue"
  ) +
  labs(
    title = "Top 20 Content Genres on Netflix",
    x = "Genre",
    y = "Number of Titles"
  ) +
  theme_minimal() +
  theme(
    legend.position = "none",
    plot.title = element_text(size = 18, face = "bold"),
    axis.text = element_text(size = 10)
  )

# ------------------------------------------------------------
# 10. GENRE TREEMAP
# ------------------------------------------------------------

ggplot(top_20_genres,
       aes(
         area = total_titles,
         fill = listed_in,
         label = paste0(
           listed_in,
           "\n",
           total_titles,
           " Titles"
         )
       )) +
  geom_treemap() +
  geom_treemap_text(
    colour = "white",
    place = "centre",
    grow = TRUE,
    reflow = TRUE
  ) +
  labs(
    title = "Netflix Content Distribution by Genre",
    subtitle = "Top 20 Genres"
  ) +
  theme_minimal() +
  theme(
    legend.position = "none",
    plot.title = element_text(size = 18, face = "bold")
  )

# ------------------------------------------------------------
# 11. YEAR-WISE CONTENT ADDITION
# ------------------------------------------------------------

yearly_content <- netflix %>%
  filter(!is.na(added_year)) %>%
  count(added_year, name = "total_titles") %>%
  arrange(added_year)

print(yearly_content)

ggplot(yearly_content,
       aes(x = added_year,
           y = total_titles)) +
  geom_line(
    linewidth = 1.3,
    color = "darkblue"
  ) +
  geom_point(
    size = 3.5,
    color = "orange"
  ) +
  labs(
    title = "Netflix Content Added by Year",
    x = "Year",
    y = "Number of Titles Added"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 18, face = "bold")
  )

# ------------------------------------------------------------
# 12. YEAR-WISE MOVIE VS TV SHOW TREND
# ------------------------------------------------------------

year_type <- netflix %>%
  filter(!is.na(added_year), !is.na(type)) %>%
  count(added_year, type, name = "total_titles")

ggplot(year_type,
       aes(x = added_year,
           y = total_titles,
           color = type)) +
  geom_line(linewidth = 1.2) +
  geom_point(size = 2.8) +
  labs(
    title = "Netflix Movies vs TV Shows Over Time",
    x = "Year",
    y = "Number of Titles Added",
    color = "Content Type"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 18, face = "bold")
  )

# ------------------------------------------------------------
# 13. LAST AVAILABLE YEAR - MONTHLY CONTENT ADDITION
# ------------------------------------------------------------

last_year <- max(
  netflix$added_year,
  na.rm = TRUE
)

last_year_data <- netflix %>%
  filter(
    !is.na(date_added),
    added_year == last_year
  ) %>%
  mutate(
    month = factor(
      format(date_added, "%B"),
      levels = month.name
    )
  ) %>%
  group_by(month) %>%
  summarise(
    total_titles = n(),
    .groups = "drop"
  )

# Add missing months as zero
last_year_data <- data.frame(
  month = factor(month.name, levels = month.name)
) %>%
  left_join(last_year_data, by = "month") %>%
  mutate(
    total_titles = replace_na(total_titles, 0)
  )

print(last_year_data)

ggplot(
  last_year_data,
  aes(
    x = month,
    y = total_titles,
    group = 1,
    color = total_titles
  )
) +
  geom_line(linewidth = 1.5) +
  geom_point(
    size = 4,
    color = "orange"
  ) +
  geom_text(
    aes(label = total_titles),
    vjust = -0.8,
    size = 4,
    color = "black"
  ) +
  scale_color_gradient(
    low = "skyblue",
    high = "darkblue"
  ) +
  labs(
    title = paste(
      "Netflix Content Added -",
      last_year
    ),
    subtitle = "Monthly Content Addition Trend",
    x = "Month",
    y = "Number of Titles Added"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(
      size = 20,
      face = "bold"
    ),
    plot.subtitle = element_text(size = 13),
    axis.text.x = element_text(
      angle = 45,
      hjust = 1
    ),
    legend.position = "none"
  )

# ------------------------------------------------------------
# 14. TOP COUNTRIES
# ------------------------------------------------------------

country_data <- netflix %>%
  filter(!is.na(country)) %>%
  separate_rows(country, sep = ",\\s*") %>%
  count(country, name = "total_titles") %>%
  arrange(desc(total_titles))

top_15_countries <- country_data %>%
  head(15)

print(top_15_countries)

ggplot(
  top_15_countries,
  aes(
    x = reorder(country, total_titles),
    y = total_titles,
    fill = total_titles
  )
) +
  geom_col() +
  geom_text(
    aes(label = total_titles),
    hjust = -0.1,
    size = 3.8
  ) +
  coord_flip() +
  scale_fill_gradient(
    low = "lightgreen",
    high = "darkgreen"
  ) +
  labs(
    title = "Top 15 Countries by Netflix Content",
    x = "Country",
    y = "Number of Titles"
  ) +
  theme_minimal() +
  theme(
    legend.position = "none",
    plot.title = element_text(size = 18, face = "bold")
  )

# ------------------------------------------------------------
# 15. TOP DIRECTORS
# ------------------------------------------------------------

director_data <- netflix %>%
  filter(!is.na(director)) %>%
  separate_rows(director, sep = ",\\s*") %>%
  count(director, name = "total_titles") %>%
  arrange(desc(total_titles))

top_10_directors <- director_data %>%
  head(10)

print(top_10_directors)

ggplot(
  top_10_directors,
  aes(
    x = reorder(director, total_titles),
    y = total_titles,
    fill = total_titles
  )
) +
  geom_col() +
  geom_text(
    aes(label = total_titles),
    hjust = -0.1,
    size = 4
  ) +
  coord_flip() +
  scale_fill_gradient(
    low = "plum",
    high = "purple"
  ) +
  labs(
    title = "Top 10 Directors on Netflix",
    x = "Director",
    y = "Number of Titles"
  ) +
  theme_minimal() +
  theme(
    legend.position = "none",
    plot.title = element_text(size = 18, face = "bold")
  )

# ------------------------------------------------------------
# 16. TV SHOW SEASON ANALYSIS
# ------------------------------------------------------------

season_data <- netflix %>%
  filter(
    type == "TV Show",
    !is.na(duration)
  ) %>%
  mutate(
    seasons = as.numeric(
      str_extract(duration, "\\d+")
    )
  ) %>%
  filter(!is.na(seasons)) %>%
  count(seasons, name = "total_shows")

print(season_data)

ggplot(
  season_data,
  aes(
    x = seasons,
    y = total_shows
  )
) +
  geom_col(
    fill = "steelblue"
  ) +
  geom_text(
    aes(label = total_shows),
    vjust = -0.3,
    size = 3.5
  ) +
  labs(
    title = "Netflix TV Shows by Number of Seasons",
    x = "Number of Seasons",
    y = "Number of TV Shows"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 18, face = "bold")
  )

# ------------------------------------------------------------
# 17. MOVIE DURATION DISTRIBUTION
# ------------------------------------------------------------

movie_duration <- netflix %>%
  filter(
    type == "Movie",
    !is.na(duration)
  ) %>%
  mutate(
    duration_minutes = as.numeric(
      str_extract(duration, "\\d+")
    )
  ) %>%
  filter(!is.na(duration_minutes))

ggplot(
  movie_duration,
  aes(x = duration_minutes)
) +
  geom_histogram(
    bins = 30,
    fill = "skyblue",
    color = "white"
  ) +
  labs(
    title = "Netflix Movie Duration Distribution",
    x = "Duration (Minutes)",
    y = "Number of Movies"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 18, face = "bold")
  )

# ------------------------------------------------------------
# 18. GENRE VS AVERAGE MOVIE DURATION
# ------------------------------------------------------------

genre_duration <- genre_data %>%
  inner_join(
    movie_duration %>%
      select(show_id, duration_minutes),
    by = "show_id"
  ) %>%
  group_by(listed_in) %>%
  summarise(
    avg_duration = mean(
      duration_minutes,
      na.rm = TRUE
    ),
    total_movies = n(),
    .groups = "drop"
  ) %>%
  filter(total_movies >= 20) %>%
  arrange(desc(avg_duration)) %>%
  head(15)

print(genre_duration)

ggplot(
  genre_duration,
  aes(
    x = reorder(listed_in, avg_duration),
    y = avg_duration,
    fill = avg_duration
  )
) +
  geom_col() +
  coord_flip() +
  scale_fill_gradient(
    low = "gold",
    high = "red"
  ) +
  labs(
    title = "Average Movie Duration by Genre",
    x = "Genre",
    y = "Average Duration (Minutes)"
  ) +
  theme_minimal() +
  theme(
    legend.position = "none",
    plot.title = element_text(size = 18, face = "bold")
  )

# ------------------------------------------------------------
# 19. MISSING VALUES ANALYSIS
# ------------------------------------------------------------

missing_data <- data.frame(
  column = names(netflix),
  missing_values = sapply(
    netflix,
    function(x) sum(is.na(x))
  )
) %>%
  arrange(desc(missing_values))

print(missing_data)

ggplot(
  missing_data,
  aes(
    x = reorder(column, missing_values),
    y = missing_values,
    fill = missing_values
  )
) +
  geom_col() +
  coord_flip() +
  scale_fill_gradient(
    low = "lightcoral",
    high = "darkred"
  ) +
  labs(
    title = "Missing Values in Netflix Dataset",
    x = "Column",
    y = "Number of Missing Values"
  ) +
  theme_minimal() +
  theme(
    legend.position = "none",
    plot.title = element_text(size = 18, face = "bold")
  )

# ------------------------------------------------------------
# 20. PROJECT SUMMARY
# ------------------------------------------------------------

cat("\n============================================\n")
cat("       NETFLIX DATA ANALYSIS COMPLETE\n")
cat("============================================\n")
cat("Total Titles:", nrow(netflix), "\n")
cat("Movies:", sum(netflix$type == "Movie", na.rm = TRUE), "\n")
cat("TV Shows:", sum(netflix$type == "TV Show", na.rm = TRUE), "\n")
cat("Unique Ratings:", n_distinct(netflix$rating, na.rm = TRUE), "\n")
cat("Unique Genres:", n_distinct(genre_data$listed_in, na.rm = TRUE), "\n")
cat("Latest Content Addition Year:", last_year, "\n")
cat("============================================\n")
