package kr.apo2073.plugins

import freemarker.cache.*
import io.ktor.http.*
import io.ktor.server.application.*
import io.ktor.server.freemarker.*
import io.ktor.server.http.content.*
import io.ktor.server.request.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import io.ktor.util.logging.*
import kr.apo2073.lib.Plugins.log
import org.json.simple.JSONObject
import org.json.simple.parser.JSONParser
import org.json.simple.parser.ParseException
import java.io.File
import java.io.InputStreamReader
import java.io.Reader
import java.net.HttpURLConnection
import java.net.URL
import java.nio.charset.StandardCharsets
import java.util.*



fun Application.configureTemplating() {
    install(FreeMarker) {
        templateLoader = ClassTemplateLoader(this::class.java.classLoader, "templates")
    }
    routing {
        staticFiles("/static", File("files"))
        get("/confirm") {
            try {
                val uuid = call.request.queryParameters["uuid"] ?: "default-uuid"
                call.respond(FreeMarkerContent("index.ftl", mapOf("uuid" to uuid), ""))
            } catch (e: Exception) {
                call.respondText(e.toString())
            }
        }
        post("/confirm") {
            val jsonBody=call.receiveText()
            val parser = JSONParser()
            val orderId: String
            val amount: String
            val paymentKey: String
            val userUUID:String
            try {
                // 클라이언트에서 받은 JSON 요청 바디입니다.
                val requestData: JSONObject = parser.parse(jsonBody) as JSONObject
                paymentKey = requestData.get("paymentKey").toString()
                orderId = requestData.get("orderId").toString()
                amount = requestData.get("amount").toString()
                userUUID= requestData.get("uuid").toString()
            } catch (e: ParseException) {
                throw RuntimeException(e)
            }

            val obj = JSONObject()
            obj.put("orderId", orderId)
            obj.put("amount", amount)
            obj.put("paymentKey", paymentKey)
            obj.put("uuid", userUUID)

            // TODO: 개발자센터에 로그인해서 내 결제위젯 연동 키 > 시크릿 키를 입력하세요. 시크릿 키는 외부에 공개되면 안돼요.
            // @docs https://docs.tosspayments.com/reference/using-api/api-keys
            val widgetSecretKey = "test_sk_P9BRQmyarY9DmeGEwgA2rJ07KzLN"
            //test_gsk_docs_OaPz8L5KdmQXkzRz3y47BMw6

            // 토스페이먼츠 API는 시크릿 키를 사용자 ID로 사용하고, 비밀번호는 사용하지 않습니다.
            // 비밀번호가 없다는 것을 알리기 위해 시크릿 키 뒤에 콜론을 추가합니다.
            // @docs https://docs.tosspayments.com/reference/using-api/authorization#%EC%9D%B8%EC%A6%9D
            val encoder = Base64.getEncoder()
            val encodedBytes = encoder.encode(("$widgetSecretKey:").toByteArray(StandardCharsets.UTF_8))
            val authorizations = "Basic " + String(encodedBytes)

            // 결제 승인 API를 호출하세요.
            // 결제를 승인하면 결제수단에서 금액이 차감돼요.
            // @docs https://docs.tosspayments.com/guides/v2/payment-widget/integration#3-결제-승인하기
            val url = URL("https://api.tosspayments.com/v1/payments/confirm")
            val connection = url.openConnection() as HttpURLConnection
            connection.setRequestProperty("Authorization", authorizations)
            connection.setRequestProperty("Content-Type", "application/json")
            connection.requestMethod = "POST"
            connection.doOutput = true

            val outputStream = connection.outputStream
            outputStream.write(obj.toString().toByteArray(StandardCharsets.UTF_8))

            val code = connection.responseCode
            val isSuccess = code == 200

            val responseStream = if (isSuccess) connection.inputStream else connection.errorStream

            // TODO: 결제 성공 및 실패 비즈니스 로직을 구현하세요.
            val reader: Reader = InputStreamReader(responseStream, StandardCharsets.UTF_8)
            val jsonObject: JSONObject = parser.parse(reader) as JSONObject
            responseStream.close()

            if (isSuccess) {
                print("a")
            } else {
                print("L")
            }

            call.respond(HttpStatusCode.fromValue(code), jsonObject)
        }

        get("/success") {
            val uuid = call.request.queryParameters["uuid"] ?: "default-uuid"
            call.respond(FreeMarkerContent("success.ftl", mapOf("uuid" to uuid), ""))
        }
        post("/success") {
            val requestData = call.receiveText()
        }

        get("/fail") {
            val failCode = call.request.queryParameters["code"]
            val failMessage = call.request.queryParameters["message"]
            call.respond(FreeMarkerContent("fail.ftl"
                , mapOf("code" to failCode, "message" to failMessage), ""))
        }
    }
}