package kr.apo2073.plugins

import io.ktor.server.application.*
import io.ktor.server.freemarker.*
import io.ktor.server.response.*
import io.ktor.server.routing.*

fun Application.configureRouting() {
    routing {
        get("/") {
            val model= mutableMapOf<String, Any>()
            call.respond(FreeMarkerContent("info.ftl", model, ""))
        }
    }
}
