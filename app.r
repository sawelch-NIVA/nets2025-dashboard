# NIVA Conference Presentations Shiny App
# Showcasing NIVA colleagues' presentations at the conference

#' @importFrom shiny fluidPage titlePanel mainPanel h3 p strong br icon downloadButton
#' @importFrom bslib bs_theme page_fluid layout_column_wrap card card_header card_body card_footer value_box
#' @importFrom htmltools tags div img

# Load required libraries ----
library(shiny)
library(bslib)
library(htmltools)

# ============================================================================
# DATA PREPARATION ----
# ============================================================================

# NIVA presentations data
niva_presentations <- read.csv("presentation_details.csv")

# ============================================================================
# UI DEFINITION ----
# ============================================================================

ui <- page_fluid(
  # Custom theme with NIVA-inspired colors ----
  theme = bs_theme(
    version = 5,
    base_font = "Sarabun, sans-serif",
    heading_font = "Sarabun, sans-serif"
  ),
  tags$style(
    HTML(".bslib-gap-spacing {gap: 0px !important;}")
  ),

  title = "NIVA at NETS 2025",

  # Header section ----
  div(
    class = "text-center mb-4",
    style = "background: linear-gradient(135deg, #1f5582 0%, #2980b9 100%); color: white; padding: 2rem; margin: -1rem -1rem 2rem -1rem;",
    h1(
      "NIVA at the Norwegian Symposium for Environmental Toxicology 2025",
      style = "font-weight: bold;",
      class = "display-4 mb-3"
    ),
    p("Norwegian Institute for Water Research", class = "lead mb-2"),
    p("August 28-29, 2025 • University of Stavanger", class = "mb-0")
  ),

  br(),

  # Main content: Presentations ----
  h2("Our Presentations", class = "mb-4"),

  # Presentation cards using layout_column_wrap for responsive design ----
  layout_column_wrap(
    heights_equal = "row",
    width = "500px",
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
              style = "font-size: 1rem; line-height: 1.3; font-weight: bold;"
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
          # Author photo using actual filenames ----
          div(
            class = "text-end ms-3",
            if (!is.na(pres$profile_photo)) {
              img(
                src = paste0("profile/", pres$profile_photo),
                alt = paste("Photo of", pres$presenter),
                style = "width: 50px; height: 50px; border-radius: 50%; object-fit: cover; border: 2px solid #dee2e6; flex-shrink: 0;",
                onerror = "this.src='data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNTAiIGhlaWdodD0iNTAiIHZpZXdCb3g9IjAgMCA1MCA1MCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPGNpcmNsZSBjeD0iMjUiIGN5PSIyNSIgcj0iMjUiIGZpbGw9IiNmOGY5ZmEiLz4KPHN2ZyB4PSIxNSIgeT0iMTUiIHdpZHRoPSIyMCIgaGVpZ2h0PSIyMCIgdmlld0JveD0iMCAwIDI0IDI0IiBmaWxsPSIjNmM3NTdkIj4KICA8cGF0aCBkPSJNMTIgMTJjMi4yMSAwIDQtMS43OSA0LTRzLTEuNzktNC00LTQtNCAxLjc5LTQgNCAxLjc5IDQgNCA0em0wIDJjLTIuNjcgMC04IDEuMzQtOCA0djJoMTZ2LTJjMC0yLjY2LTUuMzMtNC04LTR6Ii8+Cjwvc3ZnPgo8L3N2Zz4K'"
              )
            } else {
              # Fallback avatar for presenters without photos
              img(
                src = "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNTAiIGhlaWdodD0iNTAiIHZpZXdCb3g9IjAgMCA1MCA1MCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPGNpcmNsZSBjeD0iMjUiIGN5PSIyNSIgcj0iMjUiIGZpbGw9IiNmOGY5ZmEiLz4KPHN2ZyB4PSIxNSIgeT0iMTUiIHdpZHRoPSIyMCIgaGVpZ2h0PSIyMCIgdmlld0JveD0iMCAwIDI0IDI0IiBmaWxsPSIjNmM3NTdkIj4KICA8cGF0aCBkPSJNMTIgMTJjMi4yMSAwIDQtMS43OSA0LTRzLTEuNzktNC00LTQtNCAxLjc5LTQgNCAxLjc5IDQgNCA0em0wIDJjLTIuNjcgMC04IDEuMzQtOCA0djJoMTZ2LTJjMC0yLjY2LTUuMzMtNC04LTR6Ii8+Cjwvc3ZnPgo8L3N2Zz4K",
                alt = paste("Avatar for", pres$presenter),
                style = "width: 50px; height: 50px; border-radius: 50%; object-fit: cover; border: 2px solid #dee2e6; flex-shrink: 0;"
              )
            }
          )
        ),
        card_body(
          # Author name ----
          h6(
            paste("Presenter:", pres$presenter),
            class = "text-muted mb-3",
            style = "font-style: italic;"
          ),

          # Presentation preview area using actual preview images ----
          div(
            class = "mb-3 text-center",
            if (!is.na(pres$preview_image) && pres$preview_image != "") {
              # Show actual preview image for posters
              div(
                style = "width: 100%; cursor: pointer;",
                img(
                  src = paste0("preview/", pres$preview_image),
                  alt = paste("Preview of", pres$title),
                  style = "width: 100%; max-height: 800px; object-fit: contain; border: 2px solid #dee2e6; border-radius: 4px; margin: auto;",
                  title = "Click to download PDF"
                ),
                onclick = if (!is.na(pres$pdf_file)) {
                  paste0("document.getElementById('download_", i, "').click()")
                } else {
                  NULL
                }
              )
            } else if (!is.na(pres$pdf_file)) {
              # Show PDF icon for presentations with PDFs but no preview
              div(
                style = "width: 100%; height: 120px; background: #f8f9fa; border: 2px solid #dee2e6; display: flex; align-items: center; justify-content: center; border-radius: 4px; cursor: pointer;",
                div(
                  icon(
                    "file-pdf",
                    style = "font-size: 32px; color: #1f5582; margin-bottom: 8px;"
                  ),
                  br(),
                  span(
                    "Check back later for PDF!",
                    style = "font-size: 12px; color: #6c757d;"
                  )
                )
              )
            } else {
              # Placeholder for oral presentations without PDFs
              div(
                style = "width: 100%; height: 120px; background: #f8f9fa; border: 2px dashed #dee2e6; display: flex; align-items: center; justify-content: center; border-radius: 4px;",
                div(
                  icon(
                    "microphone",
                    style = "font-size: 32px; color: #6c757d; margin-bottom: 8px;"
                  ),
                  br(),
                  span(
                    "Oral Presentation",
                    style = "font-size: 12px; color: #6c757d;"
                  )
                )
              )
            }
          ),

          # Session and time info ----
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
              "Oral Presentation",
              class = "btn btn-sm btn-outline-secondary",
              disabled = "disabled",
              icon("microphone")
            )
          }
        )
      )
    })
  ),

  br(),
  br(),

  # Projects section ----
  h2("Projects", class = "mb-4"),

  # Funder logos section ----
  div(
    class = "text-center mb-5",
    style = "background: #f8f9fa; padding: 2rem; border-radius: 8px;",

    # First row: PARC logo
    layout_column_wrap(
      width = "300px",
      img(
        src = "logo/parc-logo.png",
        alt = "PARC Logo",
        style = "max-width: 400px; margin: auto auto;"
      ),

      # EXPECT logo
      img(
        src = "logo/expect-logo.png",
        alt = "EXPECT Logo",
        style = "max-width: 400px; margin: auto auto;",
        onerror = "this.style.display='none'"
      )
    )
  ),

  # Footer ----
  div(
    class = "text-center text-muted mt-5 pt-4",
    style = "border-top: 1px solid #dee2e6;",
    img(
      src = "logo/niva-logo.png",
      alt = "NIVA Logo",
      style = "max-width: 300px; margin: 0px auto;"
    ),
    p(
      "This is not the official website of the Norwegian Institute for Water Research (NIVA).",
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
# SERVER LOGIC ----
# ============================================================================

server <- function(input, output, session) {
  # Static download handlers for each presentation ----

  # 1. Morten Jartun (Oral - no PDF)
  output$download_1 <- downloadHandler(
    filename = "placeholder.pdf",
    content = function(file) {
      file.copy("www/pdf/placeholder.pdf", file)
    },
    contentType = "application/pdf"
  )

  # 2. Walter Zobl (Oral PlasticLeach)
  output$download_2 <- downloadHandler(
    filename = "2025_NETS_PlasticLeach_Presentation.pdf",
    content = function(file) {
      file.copy("www/pdf/2025_NETS_PlasticLeach_Presentation.pdf", file)
    },
    contentType = "application/pdf"
  )

  # 3. Knut Erik Tollefsen (halibut PBPK poster)
  output$download_3 <- downloadHandler(
    filename = "placeholder.pdf",
    content = function(file) {
      file.copy("www/pdf/STOP_presentation_Tollefsen_final.pdf", file)
    },
    contentType = "application/pdf"
  )

  # 4. Knut Erik Tollefsen (halibut PBPK poster)
  output$download_4 <- downloadHandler(
    filename = "halibut_PBPK_model_poster_Tollefsen_final.pdf",
    content = function(file) {
      file.copy("www/pdf/halibut_PBPK_model_poster_Tollefsen_final.pdf", file)
    },
    contentType = "application/pdf"
  )

  # 5. Li Xie (molting disruption poster)
  output$download_5 <- downloadHandler(
    filename = "cfi_molting disruption_poster_Tollefsen_final.pdf",
    content = function(file) {
      file.copy(
        "www/pdf/cfi_molting disruption_poster_Tollefsen_final.pdf",
        file
      )
    },
    contentType = "application/pdf"
  )

  # 6. Sam A. Welch (eData poster)
  output$download_6 <- downloadHandler(
    filename = "SAW_eData_Poster_NETS.pdf",
    content = function(file) {
      file.copy("www/pdf/SAW_eData_Poster_NETS.pdf", file)
    },
    contentType = "application/pdf"
  )

  # 7. Knut Erik Tollefsen (qData poster)
  output$download_7 <- downloadHandler(
    filename = "qData_poster_tollefsen_final.pdf",
    content = function(file) {
      file.copy("www/pdf/qData_poster_tollefsen_final.pdf", file)
    },
    contentType = "application/pdf"
  )

  # 8. Li Xie (AOP diuron poster)
  output$download_8 <- downloadHandler(
    filename = "AOP diuron_Poster_LIX_PARC Template_Final.pdf",
    content = function(file) {
      file.copy("www/pdf/AOP diuron_Poster_LIX_PARC Template_Final.pdf", file)
    },
    contentType = "application/pdf"
  )

  # 9. Sam A. Welch (AEP poster)
  output$download_9 <- downloadHandler(
    filename = "SAW_AEP_Poster_NETS.pdf",
    content = function(file) {
      file.copy("www/pdf/SAW_AEP_Poster_NETS.pdf", file)
    },
    contentType = "application/pdf"
  )
}

# ============================================================================
# RUN APPLICATION ----
# ============================================================================

app <- shinyApp(ui = ui, server = server)
