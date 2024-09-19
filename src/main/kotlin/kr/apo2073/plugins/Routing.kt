package kr.apo2073.plugins

import io.ktor.server.application.*
import io.ktor.server.response.*
import io.ktor.server.routing.*

fun Application.configureRouting() {
    routing {
        get("/") {
            call.respondText("BuyCoffee By.아포칼립스")
        }
    }
}
