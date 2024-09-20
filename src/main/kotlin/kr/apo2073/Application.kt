package kr.apo2073

import io.ktor.server.application.*
import io.ktor.server.engine.*
import io.ktor.server.netty.*
import kr.apo2073.cmds.DonationCmds
import kr.apo2073.plugins.*
import org.bukkit.plugin.java.JavaPlugin


class Applications:JavaPlugin() {
    private lateinit var engine:ApplicationEngine
    private var port=config.getInt("port")
    private var addr=config.getString("server-addr") ?: "127.0.0.1"
    private var protocol=config.getString("protocol") ?: "http"
    override fun onEnable() {
        if (instance!=null) return
        instance=this
        saveDefaultConfig()
        engine= embeddedServer(Netty, port = this.port, host = "0.0.0.0", module = Application::module)
            .start(wait = false)
        DonationCmds(this)
        server.logger.info("BuyCoffee By.아포칼립스")
    }

    fun getAddr():String {
        return "${protocol}://${addr}:${port}"
    }

    companion object {
        var instance:Applications?=null
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