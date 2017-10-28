library(shiny)
library(shinymaterial)
library(dplyr)
library(ggplot2)

# Wrap shinymaterial apps in material_page
ui <- material_page(
  title = "Full Featured Dashboard Example",
  nav_bar_color = "blue",
  # Place side-nav in the beginning of the UI
  material_side_nav(
    fixed = TRUE,
    image_source = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8sc3P0feYEBr53Bou3z5a0a-oE_A_nggnbRGX0WIGT12gDi3Ifg",
    # Place side-nav tabs within side-nav
    material_side_nav_tabs(
      side_nav_tabs = c(
        "Visualize" = "example_side_nav_tab_1",
        "Explore" = "example_side_nav_tab_2",
        "Export" = "example_side_nav_tab_3"
      ),
      icons = c("insert_chart", "cast", "cloud")
    )
  ),
  # Define side-nav tab content
  material_side_nav_tab_content(
    side_nav_tab_id = "example_side_nav_tab_1",
    tags$br(),
    material_row(
      material_column(
        width = 10,
        offset = 1,
        material_card(
          plotOutput('mtcarsplot')
        )
      )
    )
  ),
  material_side_nav_tab_content(
    side_nav_tab_id = "example_side_nav_tab_2",
    tags$br(),
    material_row(
      material_column(
        width = 10,
        offset = 1,
        material_card(
          dataTableOutput('mtcarsdata')
        )
      )
    )
  )
)

server <- function(input, output) {
  output$mtcarsplot <- renderPlot({
    ggplot(tibble::rownames_to_column(mtcars),
           aes(x = wt, y = mpg, color = rowname)) +
      geom_point(size = 10, alpha = .5) +
      theme(legend.position = "none")
  })
}
shinyApp(ui = ui, server = server)