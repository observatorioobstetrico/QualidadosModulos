#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @noRd
#'

app_ui <- function(request) {
  library(shinyjs)
  library(shinydashboard)
  library(shiny)
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic
    useShinyjs(),
            dashboardPage(
              dashboardHeader(title = "Qualidados", titleWidth = 160),
              dashboardSidebar(
                width = 160,
                sidebarMenu(
                  style = "position: fixed; overflow: visible;",
                  menuItem(
                    "SIVEP-GRIPE" ,
                    tabname = "sivep",
                    icon = icon("table"),
                    startExpanded = TRUE,
                    menuSubItem("Incompletude",
                                tabName = "incom_sivep"),
                    menuSubItem("Implausibilidade",
                                tabName = "implau_sivep"),
                    menuSubItem("InconsistĂȘncia",
                                tabName = "incons_sivep")
                  ),
                  menuItem(
                    "SINASC" ,
                    tabname = "sinasc",
                    icon = icon("table"),
                    menuSubItem("Incompletude",
                                tabName = "incom_sinasc"),
                    menuSubItem("Implausibilidade",
                                tabName = "implau_sinasc"),
                    menuSubItem("InconsistĂȘncia",
                                tabName = "incons_sinasc")
                  ),
                  menuItem(
                    "SIM" ,
                    tabname = "sim",
                    icon = icon("table"),
                    menuSubItem("Incompletude",
                                tabName = "incom_sim"),

                    menuSubItem("Implausibilidade",
                                tabName = "implau_sim"),
                    menuSubItem("InconsistĂȘncia",
                                tabName = "incons_sim")
                  ),
                  menuItem(
                    'DICIONĂRIO',
                    tabname = 'dic',
                    icon = icon('book')
                  ),
                  actionButton('help','Ajuda',icon('question',lib="font-awesome"),
                    style =  "color: #0A1E3;
                              background-color: white;
                              border-color: #0A1E3")
                )
              ),
              dashboardBody(tabItems(
              mod_SIVEP_incompletude_ui(id = "SIVEP_incompletude",
                                        vars_incon = variaveis_incom_nomes,
                                        tabname ="incom_sivep",
                                        descricao =  desc_incom ,indicador = 'incom',
                                        municipios =dados_incom$muni_nm_clean,
                                        estados= unique(dados_incom$SG_UF)),

              mod_SIVEP_incompletude_ui(id = "SIVEP_implausibilidade",
                                        vars_incon = var_dados_implau,
                                        tabname ="implau_sivep",
                                        descricao = desc_implau,indicador = 'implau',
                                        municipios = dados_implau$muni_nm_clean,
                                        estados = unique(dados_implau$SG_UF)),

              mod_SIVEP_incompletude_ui(id = "SIVEP_inconsistencia",
                                        vars_incon = unname(vars_incon),
                                        tabname ="incons_sivep",
                                        descricao = desc_incon,indicador = 'incon',
                                        municipios = dados_incon$muni_nm_clean,
                                        estados = unique(dados_incon$SG_UF)))
                  )
                )
              )

}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )
  #includeCSS("~/inst/app/www/estilo1.css")
  tags$script(HTML("$('body').addClass('fixed');"))
  tags$head(tags$style(
    HTML(
      '
        /* logo */
        .skin-blue .main-header .logo {
                              background-color: #0A1E3C;
                              }

        /* logo when hovered */
        .skin-blue .main-header .logo:hover {
                              background-color: #0A1E3C;
                              }

        /* navbar (rest of the header) */
        .skin-blue .main-header .navbar {
                              background-color: #0A1E3C;
                              }

        /* main sidebar */
        .skin-blue .main-sidebar {
                              background-color: #0A1E3C;
                              }

        /* active selected tab in the sidebarmenu */
        .skin-blue .main-sidebar .sidebar .sidebar-menu .active a{
                              background-color: #32A0FF;
                              }

        /* other links in the sidebarmenu */
        .skin-blue .main-sidebar .sidebar .sidebar-menu a{
                              background-color: #0A1E3C;
                              color: #FFFFFF;
                              }

        /* other links in the sidebarmenu when hovered */
         .skin-blue .main-sidebar .sidebar .sidebar-menu a:hover{
                              background-color: #32A0FF;
                              }
        /* toggle button when hovered  */
         .skin-blue .main-header .navbar .sidebar-toggle:hover{
                              background-color: #32A0FF;
                              }
                              '
    ),
    tags$link(rel = "stylesheet", type = "text/css", href = "estilo1.css"),
    HTML("hr {border-top: 1px solid #0A1E3C;}")
  ))
  }
