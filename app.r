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
    "Li Xie",
    "Sam A. Welch"
  ),
  email = c(
    "morten.jartun@niva.no",
    "walter.zobl@niva.no",
    "knut.erik.tollefsen@niva.no",
    "li.xie@niva.no",
    "sam.welch@niva.no",
    "knut.erik.tollefsen@niva.no",
    "li.xie@niva.no",
    "sam.welch@niva.no"
  ),
  title = c(
    "Uncovering the National Treasures of the Norwegian Environmental Specimen Bank",
    "Integration of lines of evidence to facilitate prioritisation of plastic leachates for toxicity testing",
    "The Source To Outcome Pathway (STOP) – Next Generation Risk Assessment (NGRA) put into practice",
    "Characterization of molting disruptors using Adverse Outcome Pathway (AOP)- informed screening tests in crustaceans",
    "eData: A format and FAIRification tool for exposure data",
    "qData – a web-based FAIRification workflow for (eco)toxicological dose(concentration)-response data",
    "Integrating point of departure and structural equation modelling to AOP development: A case study of diuron toxicity in microalgae",
    "Developing an Aggregate Exposure Pathway for Arctic Copper Pollution: Protocol and First Steps"
  ),
  type = c(
    "Oral Presentation",
    "Oral Presentation",
    "Oral Presentation",
    "Oral Presentation",
    "Poster Highlight",
    "Poster Highlight",
    "Poster Highlight",
    "Poster"
  ),
  session = c(
    "Session 1: Chemical Pollution and Ecosystem Health",
    "Session 2: Persistent Pollutants and Emerging Contaminants",
    "Session 3: Persistent Pollutants and Risk Assessment",
    "Session 4: Omics Technologies in Environmental Toxicology",
    "Poster session",
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
    "Thursday 28th August, 16:40-17:10",
    "Thursday 28th August, 16:30-18:00"
  ),
  pdf_file = c(
    NA,
    NA,
    NA,
    NA,
    NA,
    NA,
    NA,
    "www/pdf/2025_NETS_AEP_poster.pdf"
  ),
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
          class = "d-flex justify-content-between align-items-center",
          div(
            h5(
              pres$title,
              class = "card-title mb-1",
              style = "font-size: 1rem; line-height: 1.3;"
            ),
            span(
              pres$type,
              class = paste0(
                "badge ",
                if (pres$type == "Oral Presentation") {
                  "bg-primary"
                } else if (pres$type == "Poster Highlight") {
                  "bg-info"
                } else {
                  "bg-secondary"
                }
              )
            )
          ),
          # Author photo placeholder
          div(
            class = "text-end ms-3",
            img(
              src = paste0(
                "photos/",
                gsub("[^A-Za-z0-9]", "_", tolower(pres$presenter)),
                ".jpg"
              ),
              alt = paste("Photo of", pres$presenter),
              style = "width: 50px; height: 50px; border-radius: 50%; object-fit: cover; border: 2px solid #dee2e6; flex-shrink: 0;",
              onerror = "this.src='data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNTAiIGhlaWdodD0iNTAiIHZpZXdCb3g9IjAgMCA1MCA1MCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPGNpcmNsZSBjeD0iMjUiIGN5PSIyNSIgcj0iMjUiIGZpbGw9IiNmOGY5ZmEiLz4KPHN2ZyB4PSIxNSIgeT0iMTUiIHdpZHRoPSIyMCIgaGVpZ2h0PSIyMCIgdmlld0JveD0iMCAwIDI0IDI0IiBmaWxsPSIjNmM3NTdkIj4KICA8cGF0aCBkPSJNMTIgMTJjMi4yMSAwIDQtMS43OSA0LTRzLTEuNzktNC00LTQtNCAxLjc5LTQgNCAxLjc5IDQgNCA0em0wIDJjLTIuNjcgMC04IDEuMzQtOCA0djJoMTZ2LTJjMC0yLjY2LTUuMzMtNC04LTR6Ii8+Cjwvc3ZnPgo8L3N2Zz4K'"
            )
          )
        ),
        card_body(
          # Author name (moved from header)
          h6(
            paste("by", pres$presenter),
            class = "text-muted mb-3",
            style = "font-style: italic;"
          ),

          # Presentation preview area
          div(
            class = "mb-3 text-center",
            if (!is.na(pres$pdf_file)) {
              # Show actual preview for presentations with PDFs
              div(
                style = "width: 100%; height: 120px; background: #f8f9fa; border: 2px solid #dee2e6; display: flex; align-items: center; justify-content: center; border-radius: 4px; cursor: pointer; background-image: linear-gradient(45deg, #f8f9fa 25%, transparent 25%), linear-gradient(-45deg, #f8f9fa 25%, transparent 25%), linear-gradient(45deg, transparent 75%, #f8f9fa 75%), linear-gradient(-45deg, transparent 75%, #f8f9fa 75%); background-size: 10px 10px; background-position: 0 0, 0 5px, 5px -5px, -5px 0px;",
                div(
                  icon(
                    "file-image",
                    style = "font-size: 32px; color: #1f5582; margin-bottom: 8px;"
                  ),
                  br(),
                  span(
                    "PDF Preview",
                    style = "font-size: 12px; color: #6c757d;"
                  )
                ),
                title = "Click to download PDF",
                onclick = paste0(
                  "document.getElementById('download_",
                  i,
                  "').click()"
                )
              )
            } else {
              # Placeholder for presentations without PDFs
              div(
                style = "width: 100%; height: 120px; background: #f8f9fa; border: 2px dashed #dee2e6; display: flex; align-items: center; justify-content: center; border-radius: 4px;",
                div(
                  icon(
                    "file-pdf",
                    style = "font-size: 32px; color: #6c757d; margin-bottom: 8px;"
                  ),
                  br(),
                  span(
                    "PDF Coming Soon",
                    style = "font-size: 12px; color: #6c757d;"
                  )
                )
              )
            }
          ),

          # Session and time info
          p(
            strong("Session: "),
            gsub("^Session \\d+: ", "", pres$session),
            class = "small mb-2"
          ),
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
          if (!is.na(pres$pdf_file)) {
            downloadButton(
              paste0("download_", i),
              "Download PDF",
              class = "btn-sm btn-primary",
              icon = icon("download")
            )
          } else {
            tags$button(
              "PDF Coming Soon",
              class = "btn btn-sm btn-outline-secondary",
              disabled = "disabled",
              icon("clock")
            )
          }
        )
      )
    })
  ),

  br(),
  br(),

  h2("Projects", class = "mb-4"),

  # Funder logos section
  div(
    class = "text-center mb-5",
    style = "background: #f8f9fa; padding: 2rem; border-radius: 8px;",

    # First row: PARC logo (likely larger)
    div(
      class = "mb-4",
      img(
        src = "parc-logo.png",
        alt = "PARC Logo",
        style = "max-height: 80px; max-width: 300px; height: auto; width: auto;"
      )
    ),

    # Second row: EXPECT and NIVA logos in responsive grid
    layout_column_wrap(
      width = 1 / 4,
      min_width = "200px",

      # EXPECT logos
      div(
        class = "d-flex flex-column align-items-center",
        tags$img(
          src = "expect-logo.png",
          alt = "EXPECT Logo",
          style = "max-height: 60px; max-width: 180px; height: auto; width: auto; margin-bottom: 10px;"
        )
      ),

      # NIVA logos
      div(
        class = "d-flex flex-column align-items-center",
        img(
          src = "niva-logo.png",
          alt = "NIVA Logo",
          style = "max-height: 60px; max-width: 180px; height: auto; width: auto; margin-bottom: 10px;"
        )
      )
    ),

    # JavaScript to hide images that fail to load
    tags$script(
      "
      document.addEventListener('DOMContentLoaded', function() {
        const images = document.querySelectorAll('img[src*=\"expect-\"], img[src*=\"niva-\"], img[src*=\"parc-\"]');
        images.forEach(img => {
          img.onerror = function() {
            this.style.display = 'none';
          };
        });
      });
    "
    )
  ),

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
  print(getwd())

  # Static download handlers for each presentation

  # 1. Morten Jartun
  output$download_1 <- downloadHandler(
    filename = "Morten_Jartun_presentation.pdf",
    content = function(file) {
      writeLines(
        c(
          "Presentation by: Morten Jartun",
          "Title: Uncovering the National Treasures of the Norwegian Environmental Specimen Bank",
          "",
          "PDF coming soon."
        ),
        file
      )
    },
    contentType = "text/plain"
  )

  # 2. Walter Zobl
  output$download_2 <- downloadHandler(
    filename = "Walter_Zobl_presentation.pdf",
    content = function(file) {
      writeLines(
        c(
          "Presentation by: Walter Zobl",
          "Title: Integration of lines of evidence to facilitate prioritisation of plastic leachates for toxicity testing",
          "",
          "PDF coming soon."
        ),
        file
      )
    },
    contentType = "text/plain"
  )

  # 3. Knut Erik Tollefsen (oral)
  output$download_3 <- downloadHandler(
    filename = "Knut_Erik_Tollefsen_oral_presentation.pdf",
    content = function(file) {
      writeLines(
        c(
          "Presentation by: Knut Erik Tollefsen",
          "Title: The Source To Outcome Pathway (STOP) – Next Generation Risk Assessment (NGRA) put into practice",
          "",
          "PDF coming soon."
        ),
        file
      )
    },
    contentType = "text/plain"
  )

  # 4. Li Xie (oral)
  output$download_4 <- downloadHandler(
    filename = "Li_Xie_oral_presentation.pdf",
    content = function(file) {
      writeLines(
        c(
          "Presentation by: Li Xie",
          "Title: Characterization of molting disruptors using Adverse Outcome Pathway (AOP)- informed screening tests in crustaceans",
          "",
          "PDF coming soon."
        ),
        file
      )
    },
    contentType = "text/plain"
  )

  # 5. Sam A. Welch (poster highlight 1)
  output$download_5 <- downloadHandler(
    filename = "Sam_Welch_eData_poster.pdf",
    content = function(file) {
      writeLines(
        c(
          "Presentation by: Sam A. Welch",
          "Title: eData: A format and FAIRification tool for exposure data",
          "",
          "PDF coming soon."
        ),
        file
      )
    },
    contentType = "text/plain"
  )

  # 6. Knut Erik Tollefsen (poster highlight)
  output$download_6 <- downloadHandler(
    filename = "Knut_Erik_Tollefsen_qData_poster.pdf",
    content = function(file) {
      writeLines(
        c(
          "Presentation by: Knut Erik Tollefsen",
          "Title: qData – a web-based FAIRification workflow for (eco)toxicological dose(concentration)-response data",
          "",
          "PDF coming soon."
        ),
        file
      )
    },
    contentType = "text/plain"
  )

  # 7. Li Xie (poster highlight)
  output$download_7 <- downloadHandler(
    filename = "Li_Xie_AOP_poster.pdf",
    content = function(file) {
      writeLines(
        c(
          "Presentation by: Li Xie",
          "Title: Integrating point of departure and structural equation modelling to AOP development: A case study of diuron toxicity in microalgae",
          "",
          "PDF coming soon."
        ),
        file
      )
    },
    contentType = "text/plain"
  )

  # 8. Sam A. Welch (AEP poster) - ACTUAL PDF
  output$download_8 <- downloadHandler(
    filename = "2025_NETS_AEP_Poster.pdf",
    content = function(file) {
      file.copy("www/pdf/2025_NETS_AEP_Poster.pdf", file)
    },
    contentType = "application/pdf"
  )
}

# ============================================================================
# RUN APPLICATION
# ============================================================================

app <- shinyApp(ui = ui, server = server)
