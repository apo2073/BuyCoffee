package kr.apo2073

import io.ktor.server.application.*
import io.ktor.server.engine.*
import io.ktor.server.netty.*
import kr.apo2073.plugins.*
import org.bukkit.plugin.java.JavaPlugin


class Applications:JavaPlugin() {
    private lateinit var engine:ApplicationEngine
    private var port=config.getInt("port")
    override fun onEnable() {
        if (instance!=null) return
        instance=this
        saveDefaultConfig()
        engine= embeddedServer(Netty, port = this.port, host = "0.0.0.0", module = Application::module)
            .start(wait = false)
        server.logger.info("BuyCoffee By.아포칼립스")
    }

    fun getInstance(): Applications {
        return instance!!
    }

    companion object {
        var instance:Applications?=null
            private set
    }

    override fun onDisable() {
        if (::engine.isInitialized) {
            engine.stop(/*gracePeriodMillis = 1000, timeoutMillis = 10000*/)
        }
    }
}

fun main() {
    embeddedServer(Netty, port = 2074, host = "0.0.0.0", module = Application::module)
        .start(wait = true)
}

fun Application.module() {
    configureTemplating()
    configureRouting()
}