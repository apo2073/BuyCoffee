package kr.apo2073.util

import kr.apo2073.plugins.app
import org.bukkit.configuration.file.FileConfiguration
import org.bukkit.configuration.file.YamlConfiguration
import java.io.File

val file=File("${app.dataFolder}","orderInfo.yml")
val Dconfig=YamlConfiguration.loadConfiguration(file)
fun saveDconfig()= Dconfig.save(file)