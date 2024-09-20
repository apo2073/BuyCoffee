package kr.apo2073.cmds

import io.ktor.http.*
import kr.apo2073.Applications
import kr.apo2073.lib.Plugins.PermissionMessenger
import net.kyori.adventure.text.Component
import net.kyori.adventure.text.TextComponent
import net.kyori.adventure.text.event.ClickEvent
import net.kyori.adventure.text.event.HoverEvent
import net.kyori.adventure.text.event.HoverEventSource
import org.bukkit.command.Command
import org.bukkit.command.CommandExecutor
import org.bukkit.command.CommandSender
import org.bukkit.entity.Player
import org.bukkit.plugin.java.JavaPlugin
import java.net.URL

class DonationCmds(plugin: JavaPlugin):CommandExecutor {
    init {
        plugin.getCommand("후원")?.apply {
            setExecutor(this@DonationCmds::onCommand)
        }
    }
    private var ins=Applications.instance!!
    override fun onCommand(p0: CommandSender, p1: Command, p2: String, p3: Array<out String>?): Boolean {
        if (p0 !is Player) return false
        val player= p0
        PermissionMessenger(player, "buyCoffee.done")
        val addr=ins.getAddr()
        player.sendMessage(Component.text("§l[§a*§f]§r [ 후원하기 ]")
            .clickEvent(ClickEvent.openUrl(URL("${addr}/confirm?uuid=${player.uniqueId}")))
            .hoverEvent(HoverEventSource {
                HoverEvent.showText(Component.text("§l[ §a클릭§f해서 이동 §f]"))
            })
        )
        return true
    }
}