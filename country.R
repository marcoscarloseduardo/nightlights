#########################################
# Visualize night light comparison with R
# by country
# Carlos Marcos 2023-oct
# based on Milos Popovic's tutorial
#########################################
libs <- c(
  "tidyverse", "terra", "sf",
  "giscoR","shiny"
)

installed_libraries <- libs %in% rownames(
  installed.packages()
)

if (any(installed_libraries == F)){
  install.packages(
    libs[!installed_libraries]
  )
}

invisible(lapply(
  libs, library, character.only = T
))

# 1. GET COUNTRY MAP
#-------------------

country_code <- c("AR", "FK")

country_sf <- giscoR::gisco_get_countries(
  country = country_code,
  resolution = "3"
)

# 2. GET DATA
#------------

urls <- c(
  "https://eogdata.mines.edu/nighttime_light/annual/v22/2022/VNL_v22_npp-j01_2022_global_vcmslcfg_c202303062300.average_masked.dat.tif.gz",
  "https://eogdata.mines.edu/nighttime_light/annual/v21/2012/VNL_v21_npp_201204-201212_global_vcmcfg_c202205302300.average_masked.dat.tif.gz"
)


raster_files <- list.files(
  path = "data/",
  pattern = "npp",
  full.names = T
)

# 3. LOAD DATA
#-------------

globe_lights <- lapply(
  paste0("/vsigzip/", raster_files),
  terra::rast
)

# 4. CROP DATA
#-------------

country_lights_list <- lapply(
  globe_lights,
  function(x){
    terra::crop(
      x,
      terra::vect(country_sf),
      snap = "in",
      mask = T
    )
  }
)

# 5. REMOVE 0S AND SUBZEROS
#--------------------------

country_lights_final <- lapply(
  country_lights_list,
  function(x){
    terra::ifel(
      x <= 0,
      NA,
      x
    )
  }
)

# 6. RASTER TO DATAFRAME
#-----------------------

country_lights_df <- lapply(
  country_lights_final,
  function(x){
    as.data.frame(
      x,
      xy = T,
      na.rm = T
    )
  }
)

col_names <- c("x", "y", "value")
country_lights_df <- lapply(
  country_lights_df,
  setNames,
  col_names
)

# 7. MAP
#-------

cols <- c("#1f4762", "#FFD966", "white")
pal <- colorRampPalette(
  cols, bias = 8
)(512)

years <- c(2012, 2022)
names(country_lights_df) <- years

map <- lapply(
  names(country_lights_df),
  function(df){
    ggplot(
      data = country_lights_df[[df]]
    ) +
      geom_sf(
        data = country_sf,
        fill = NA,
        color = cols[[1]],
        size = .05
      ) +
      geom_tile(
        aes(
          x = x,
          y = y,
          fill = value
        )
      ) +
      scale_fill_gradientn(
        name = "",
        colors = pal
      ) +
    theme_void() +
      theme(
        legend.position = "none",
        plot.title = element_text(
          size = 40,
          color = "white",
          hjust = .5,
          vjust = 0
        ),
        plot.margin = unit(
          c(
            t = 0, r = 0,
            l = 0, b = 0
          ), "lines"
        )
      ) +
      labs(title = df)
  }
)

for (i in 1:2) {
  file_name = paste0(
    country_code, "_map_", i, years[1],
    ".png")
  png(
    file_name,
    width = 1200,
    height = 1200,
    units = "px",
    bg = "#182833"
  )
  
  print(map[[i]])
  dev.off() 
}
