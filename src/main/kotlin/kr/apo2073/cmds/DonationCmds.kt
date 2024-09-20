package kr.apo2073.cmds

import kr.apo2073.Applications
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

class DonationCmds(plugin: JavaPlugin):CommandExecutor {
    override fun onCommand(p0: CommandSender, p1: Command, p2: String, p3: Array<out String>?): Boolean {
        if (p0 !is Player) return false
        val player= p0
        if (!player.hasPermission("buyCoffee.done")) {
            player.sendMessage(Component.text("§l[§c*§f]§r 명령어를 실행할 권한이 없습니다.")
                .hoverEvent(HoverEventSource {
                    HoverEvent.showText(Component.text("§l§a[ 클릭해서 이동 ]"))
                })
            )
            return true
        }
        val addr=Applications().getInstance().getAddr()
        player.sendMessage(Component.text("§l[§a*§f]§r [ 후원하기 ]")
            .clickEvent(ClickEvent.openUrl("${addr}/confirm?uuid=${player.uniqueId}"))
            .hoverEvent(HoverEventSource {
                HoverEvent.showText(Component.text("§l§a[ 클릭해서 이동 ]"))
            })
        )
        return true
    }
}