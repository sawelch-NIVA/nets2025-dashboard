# NIVA Conference Presentations Shiny App
# Showcasing NIVA colleagues' presentations at the conference

#' @importFrom shiny fluidPage titlePanel mainPanel h3 p strong br icon downloadButton
#' @importFrom bslib bs_theme page_fluid layout_column_wrap card card_header card_body card_footer value_box
#' @importFrom htmltools tags div img

# Load required libraries
library(shiny)
library(bslib)
library(htmltools)

# ============================================================================
# DATA PREPARATION
# ============================================================================

# NIVA presentations data
niva_presentations <- data.frame(
  presenter = c(
    "Morten Jartun",
    "Walter Zobl",
    "Knut Erik Tollefsen",
    "Li Xie",
    "Sam A. Welch",
    "Knut Erik Tollefsen",
    "Li Xie"
  ),
  email = c(
    "morten.jartun@niva.no",
    "walter.zobl@niva.no",
    "knut.erik.tollefsen@niva.no",
    "li.xie@niva.no",
    "sam.welch@niva.no",
    "knut.erik.tollefsen@niva.no",
    "li.xie@niva.no"
  ),
  title = c(
    "Uncovering the National Treasures of the Norwegian Environmental Specimen Bank",
    "Integration of lines of evidence to facilitate prioritisation of plastic leachates for toxicity testing",
    "The Source To Outcome Pathway (STOP) – Next Generation Risk Assessment (NGRA) put into practice",
    "Characterization of molting disruptors using Adverse Outcome Pathway (AOP)- informed screening tests in crustaceans",
    "eData: A format and FAIRification tool for exposure data",
    "qData – a web-based FAIRification workflow for (eco)toxicological dose(concentration)-response data",
    "Integrating point of departure and structural equation modelling to AOP development: A case study of diuron toxicity in microalgae"
  ),
  type = c(
    "Oral Presentation",
    "Oral Presentation",
    "Oral Presentation",
    "Oral Presentation",
    "Poster Highlight",
    "Poster Highlight",
    "Poster Highlight"
  ),
  session = c(
    "Session 1: Chemical Pollution and Ecosystem Health",
    "Session 2: Persistent Pollutants and Emerging Contaminants",
    "Session 3: Persistent Pollutants and Risk Assessment",
    "Session 4: Omics Technologies in Environmental Toxicology",
    "Poster session",
    "Poster session",
    "Poster session"
  ),
  day_time = c(
    "Thursday 28th August, 9:30-10:40",
    "Thursday 28th August, 11:10-12:20",
    "Thursday 28th August, 14:05-15:00",
    "Thursday 28th August, 15:35-16:30",
    "Thursday 28th August, 16:40-17:10",
    "Thursday 28th August, 16:40-17:10",
    "Thursday 28th August, 16:40-17:10"
  ),
  stringsAsFactors = FALSE
)

# Session chairs data
session_chairs <- data.frame(
  name = c("Knut Erik Tollefsen", "Sam Welch"),
  email = c("knut.erik.tollefsen@niva.no", "sam.welch@niva.no"),
  session = c(
    "Session 1: Chemical Pollution and Ecosystem Health",
    "Session 3: Risk Assessment and Management"
  ),
  cochair = c("Elin Sørus", "Hans-Christian Teien"),
  stringsAsFactors = FALSE
)

# ============================================================================
# UI DEFINITION
# ============================================================================

ui <- page_fluid(
  # Custom theme with NIVA-inspired colors
  theme = bs_theme(
    version = 5,
    bg = "#ffffff",
    fg = "#333333",
    primary = "#1f5582", # NIVA blue
    secondary = "#6c757d",
    success = "#198754",
    base_font = "Arial, sans-serif",
    heading_font = "Arial, sans-serif"
  ),

  title = "NIVA at the Norwegian Symposium for Environmental",

  # Header section
  div(
    class = "text-center mb-4",
    style = "background: linear-gradient(135deg, #1f5582 0%, #2980b9 100%); color: white; padding: 2rem; margin: -1rem -1rem 2rem -1rem;",
    h1("NIVA at NETS Conference 2025", class = "display-4 mb-3"),
    p("Norwegian Institute for Water Research", class = "lead mb-2"),
    p("August 28-29, 2025 • University of Stavanger", class = "mb-0")
  ),

  br(),

  # Main content: Presentations
  h2("Our Presentations", class = "mb-4"),

  # Presentation cards using layout_column_wrap for responsive design
  layout_column_wrap(
    width = 1 / 2,
    !!!lapply(1:nrow(niva_presentations), function(i) {
      pres <- niva_presentations[i, ]

      card(
        class = "h-100",
        card_header(
          class = "d-flex justify-content-between align-items-start",
          div(
            h5(pres$presenter, class = "card-title mb-1"),
            span(
              pres$type,
              class = paste0(
                "badge ",
                if (pres$type == "Oral Presentation") {
                  "bg-primary"
                } else {
                  "bg-info"
                }
              )
            )
          ),
          div(
            class = "text-end",
            # Placeholder for attachment preview - replace with actual image when available
            div(
              style = "width: 80px; height: 60px; background: #f8f9fa; border: 2px dashed #dee2e6; display: flex; align-items: center; justify-content: center; border-radius: 4px; cursor: pointer;",
              icon("file-pdf", style = "font-size: 24px; color: #6c757d;"),
              title = "Click to download PDF (placeholder)"
            )
          )
        ),
        card_body(
          h6(pres$title, class = "text-primary mb-3"),
          p(strong("Session: "), pres$session, class = "small mb-2"),
          p(strong("Time: "), pres$day_time, class = "small mb-2"),
          p(
            strong("Contact: "),
            tags$a(
              pres$email,
              href = paste0("mailto:", pres$email),
              class = "text-decoration-none"
            ),
            class = "small mb-0"
          )
        ),
        card_footer(
          class = "text-center",
          downloadButton(
            paste0("download_", i),
            "Download PDF",
            class = "btn-sm btn-outline-primary",
            icon = icon("download")
          )
        )
      )
    })
  ),

  br(),
  br(),

  h2("Our Funders", class = "mb-4"),
  img(src = "www/expect-logo.png"),

  # Footer
  div(
    class = "text-center text-muted mt-5 pt-4",
    style = "border-top: 1px solid #dee2e6;",
    p(
      "This is not an official website of the Norwegian Institute for Water Research (NIVA).",
      class = "mb-1"
    ),
    p(
      "Please visit ",
      tags$a(
        "www.niva.no",
        href = "https://www.niva.no",
        target = "_blank",
        class = "text-decoration-none"
      ),
      class = "mb-0"
    )
  )
)

# ============================================================================
# SERVER LOGIC
# ============================================================================

server <- function(input, output, session) {
  # Download handlers for each presentation (placeholder functionality)
  lapply(1:nrow(niva_presentations), function(i) {
    output[[paste0("download_", i)]] <- downloadHandler(
      filename = function() {
        paste0(
          gsub("[^A-Za-z0-9]", "_", niva_presentations[i, "presenter"]),
          "_presentation.pdf"
        )
      },
      content = function(file) {
        # Placeholder: create a simple text file indicating this is a placeholder
        # In production, you would copy the actual PDF file here
        writeLines(
          c(
            paste("Presentation by:", niva_presentations[i, "presenter"]),
            paste("Title:", niva_presentations[i, "title"]),
            "",
            "This is a placeholder file. In production, this would be the actual PDF presentation."
          ),
          file
        )
      },
      contentType = "text/plain"
    )
  })
}

# ============================================================================
# RUN APPLICATION
# ============================================================================

shinyApp(ui = ui, server = server)
