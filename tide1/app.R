# vim:textwidth=128:expandtab:shiftwidth=2:softtabstop=2

library(shiny)
data(tidedata, package="oce") # for frequencies

## constitutents for Minas Basin, inferred from webtide, with added M6
const <- list(O1=list(amp=0.121025, phase=184.886933, freq=tidedata$const$freq[tidedata$const$name=="O1"]),
              K1=list(amp=0.168322, phase=199.414863, freq=tidedata$const$freq[tidedata$const$name=="K1"]),
              N2=list(amp=1.041943, phase=103.887159, freq=tidedata$const$freq[tidedata$const$name=="N2"]),
              M2=list(amp=5.169948, phase=119.538393, freq=tidedata$const$freq[tidedata$const$name=="M2"]),
              S2=list(amp=0.850774, phase=174.846890, freq=tidedata$const$freq[tidedata$const$name=="S2"]),
              M6=list(amp=0.000000, phase=000.000000, freq=tidedata$const$freq[tidedata$const$name=="M6"]))

ui <- fluidPage(tags$script('$(document).on("keypress", function (e)
                            {
                              Shiny.onInputChange("keypress", e.which);
                              Shiny.onInputChange("keypressTrigger", Math.random());
                            });'),
fluidRow(column(6, sliderInput(inputId="tmax", label=h6("Simulation Time [days]"),
                               value=7, min=1, max=365, step=1))),
                fluidRow(column(2, sliderInput(inputId="O1a", label=h6("O1 amplitude [m]"),
                                               value=const$O1$amp, min=0, max=6, step=0.01)),
                         column(2, sliderInput(inputId="K1a", label=h6("K1 amplitude [m]"),
                                               value=const$K1$amp, min=0, max=6, step=0.01)),
                         column(2, sliderInput(inputId="N2a", label=h6("N2 amplitude [m]"),
                                               value=const$N2$amp, min=0, max=6, step=0.01)),
                         column(2, sliderInput(inputId="M2a", label=h6("M2 amplitude [m]"),
                                               value=const$M2$amp, min=0, max=6, step=0.01)),
                         column(2, sliderInput(inputId="S2a", label=h6("S2 amplitude [m]"),
                                               value=const$S2$amp, min=0, max=6, step=0.01)),
                         column(2, sliderInput(inputId="M6a", label=h6("M6 amplitude [m]"),
                                               value=const$M6$amp, min=0, max=6, step=0.01))),
                fluidRow(column(2, sliderInput(inputId="O1p", label=h6("O1 phase"),
                                               value=const$O1$phase, min=0, max=360)),
                         column(2, sliderInput(inputId="K1p", label=h6("K1 phase"),
                                               value=const$K1$phase, min=0, max=360)),
                         column(2, sliderInput(inputId="N2p", label=h6("N2 phase"),
                                               value=const$N2$phase, min=0, max=360)),
                         column(2, sliderInput(inputId="M2p", label=h6("M2 phase"),
                                               value=const$M2$phase, min=0, max=360)),
                         column(2, sliderInput(inputId="S2p", label=h6("S2 phase"),
                                               value=const$S2$phase, min=0, max=360)),
                         column(2, sliderInput(inputId="M6p", label=h6("M6 phase"),
                                               value=const$M6$phase, min=0, max=360))),
                fluidRow(plotOutput("plot")))

server <- function(input, output, session)
{
  output$plot <- renderPlot({
    day <- seq(0, input$tmax, 10 * 60 / 96400) # a point every 10 minutes
    h2pi <- 2 * pi * 24 * day
    par(mar=c(3, 3, 1, 1), mgp=c(2, 0.7, 0))
    eta <-
      input$O1a*sin(h2pi*const$O1$freq-input$O1p*pi/180) +
      input$K1a*sin(h2pi*const$K1$freq-input$K1p*pi/180) +
      input$N2a*sin(h2pi*const$N2$freq-input$N2p*pi/180) +
      input$M2a*sin(h2pi*const$M2$freq-input$M2p*pi/180) +
      input$S2a*sin(h2pi*const$S2$freq-input$S2p*pi/180) +
      input$M6a*sin(h2pi*const$M6$freq-input$M6p*pi/180)
      plot(day, eta, type='l', xlab="Time [days]", ylab="Sea Level [m]", xaxs="i", lwd=1.4)
      grid()
      lines(day, eta, lwd=1.4) # the grid otherwise obscures the data
  })
  observeEvent(input$keypressTrigger, {
               key <- intToUtf8(input$keypress)
               if (key == "d") {
                 updateNumericInput(session, "tmax", value=1)
               } else if (key == "w") {
                 updateNumericInput(session, "tmax", value=7)
               } else if (key == "m") {
                 updateNumericInput(session, "tmax", value=30)
               } else if (key == "y") {
                 updateNumericInput(session, "tmax", value=365)
               } else if (key == "M") {
                 updateNumericInput(session, "O1a", value=const$O1$amp)
                 updateNumericInput(session, "O1p", value=const$O1$phase)
                 updateNumericInput(session, "K1a", value=const$K1$amp)
                 updateNumericInput(session, "K1p", value=const$K1$phase)
                 updateNumericInput(session, "N2a", value=const$N2$amp)
                 updateNumericInput(session, "N2p", value=const$N2$phase)
                 updateNumericInput(session, "M2a", value=const$M2$amp)
                 updateNumericInput(session, "M2p", value=const$M2$phase)
                 updateNumericInput(session, "S2a", value=const$S2$amp)
                 updateNumericInput(session, "S2p", value=const$S2$phase)
                 updateNumericInput(session, "M6a", value=const$M6$amp)
                 updateNumericInput(session, "M6p", value=const$M6$phase)
               } else if (key == "S") {
                 updateNumericInput(session, "O1a", value=0)
                 updateNumericInput(session, "O1p", value=0)
                 updateNumericInput(session, "K1a", value=0)
                 updateNumericInput(session, "K1p", value=0)
                 updateNumericInput(session, "N2a", value=0)
                 updateNumericInput(session, "N2p", value=0)
                 updateNumericInput(session, "M2a", value=1)
                 updateNumericInput(session, "M2p", value=0)
                 updateNumericInput(session, "S2a", value=0)
                 updateNumericInput(session, "S2p", value=0)
                 updateNumericInput(session, "M6a", value=0)
                 updateNumericInput(session, "M6p", value=0)
               } else if (key == '?') {
                 showModal(modalDialog(title="Key-stroke commands",
                                       HTML("<ul>
                                            <li> '<b>d</b>': <b>d</b>ay view
                                            <li> '<b>m</b>': <b>m</b>onth view
                                            <li> '<b>y</b>': <b>y</b>ear view
                                            <li> '<b>M</b>`: <b>M</b>inas Basin tide
                                            <li> '<b>S</b>`: <b>S</b>imple M2 tide
                                            <li> '<b>?</b>': display this message
                                            </ul>"), easyClose=TRUE))
               }
  })
}

shinyApp(ui=ui, server=server)

