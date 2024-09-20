<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8" />
  <link rel="icon" href="https://static.toss.im/icons/png/4x/icon-toss-logo.png" />
  <#--link rel="stylesheet" type="text/css" href="style.css" />-->
  <style>:root {
      --white: #ffffff;
      --black: #000000;
      --grey100: #f2f4f6;
      --grey200: #e5e8eb;
      --grey400: #b0b8c1;
      --grey700: #4e5968;
      --greyOpacity50: rgba(0, 23, 51, 0.02);
      --blue600: #3182f6;
      --blue700: #1b64da;
    }

    body {
      background-image: url('https://static.toss.im/ml-illust/img-back_002.jpg');
      font-family: Toss Product Sans, -apple-system, BlinkMacSystemFont,
      Bazier Square, Noto Sans KR, Segoe UI, Apple SD Gothic Neo, Roboto,
      Helvetica Neue, Arial, sans-serif, Apple Color Emoji, Segoe UI Emoji,
      Segoe UI Symbol, Noto Color Emoji;
      color: #4e5968;
      word-break: keep-all;
      overflow-wrap: break-word;
    }
    .button {
      color: #f9fafb;
      background-color: #3182f6;
      font-size: 15px;
      font-weight: 400;
      line-height: 18px;
      white-space: nowrap;
      text-align: center;
      cursor: pointer;
      border: 0 solid transparent;
      user-select: none;
      transition: background 0.2s ease, color 0.1s ease;
      text-decoration: none;
      border-radius: 7px;
      padding: 11px 16px;
      margin: 30px 0; /* Adjust margin for spacing */
    }

    .button:hover {
      color: #fff;
      background-color: #1b64da;
    }
    .box_section {
      background-color: white;
      border-radius: 10px;
      box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1), 0 6px 6px rgba(0, 0, 0, 0.06);
      padding: 40px 30px 50px 30px;
      /*margin-top: 30px;
      margin-bottom: 50px;*/
      margin: 0 auto;
      color: #333D4B;
    }

    #player-avatar {
      width: 100px; /* Set the width of the avatar */
      height: 100px; /* Set the height of the avatar */
      border-radius: 50%; /* Make the image circular */
      border: 3px solid #3182f6; /* Add a blue border around the avatar */
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Add a subtle shadow */
      margin: 20px auto; /* Center the avatar and add margin */
      display: block; /* Center the image block */
    }

    /* No UUID message */
    .no-uuid-message {
      font-size: 18px; /* Font size for the message */
      color: #ff0000; /* Red color for the message */
      text-align: center; /* Center align the text */
      margin-top: 20px; /* Add some space above the text */
    }

  </style>
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>후원</title>
</head>

<body>

<#if uuid??>
  <img id="player-avatar" src="https://api.mineatar.io/face/${uuid}?scale=64" alt="Player Avatar" class="avatar"/>
<#else>
  <p class="no-uuid-message">No UUID provided</p>
</#if>

<div class="box_section" style="width: 600px">
  <img width="100px" src="https://static.toss.im/illusts/check-blue-spot-ending-frame.png" />
  <h2>결제를 완료했어요</h2>

  <div class="p-grid typography--p" style="margin-top: 50px">
    <div class="p-grid-col text--left"><b>결제금액</b></div>
    <div class="p-grid-col text--right" id="amount"></div>
  </div>
  <div class="p-grid typography--p" style="margin-top: 10px">
    <div class="p-grid-col text--left"><b>주문번호</b></div>
    <div class="p-grid-col text--right" id="orderId"></div>
  </div>
  <div class="p-grid typography--p" style="margin-top: 10px">
    <div class="p-grid-col text--left"><b>UUID</b></div>
    <div class="p-grid-col text--right" id="userUUID" style="white-space: initial; width: 250px">${uuid}</div>
  </div>

  <#--<div class="p-grid typography--p" style="margin-top: 10px">
    <div class="p-grid-col text--left"><b>paymentKey</b></div>
    <div class="p-grid-col text--right" id="paymentKey" style="white-space: initial; width: 250px"></div>
  </div>-->
  <div class="p-grid" style="margin-top: 30px">
    <button class="button p-grid-col5" onclick="location.href='https://docs.tosspayments.com/guides/v2/payment-widget/integration';">연동 문서</button>
    <button class="button p-grid-col5" onclick="location.href='https://discordapp.com/users/715806802817712148';" style="background-color: #e8f3ff; color: #1b64da">실시간 문의</button>
  </div>
</div>

<!--<div class="box_section" style="width: 600px; text-align: left">
  <b>Response Data :</b>
  <div id="response" style="white-space: initial"></div>
</div>-->

<script>
  // 쿼리 파라미터 값이 결제 요청할 때 보낸 데이터와 동일한지 반드시 확인하세요.
  // 클라이언트에서 결제 금액을 조작하는 행위를 방지할 수 있습니다.
  const urlParams = new URLSearchParams(window.location.search);
  const paymentKey = urlParams.get("paymentKey");
  const orderId = urlParams.get("orderId");
  const amount = urlParams.get("amount");
  const uuid=urlParams.get("uuid")

  // 서버로 결제 승인에 필요한 결제 정보를 보내세요.
  async function confirm() {
    const requestData = {
      paymentKey: paymentKey,
      orderId: orderId,
      amount: amount,
      uuid: uuid,
    };

    const response = await fetch("/confirm", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(requestData),
    });

    const json = await response.json();

    if (!response.ok) {
      // TODO: 결제 실패 비즈니스 로직을 구현하세요.
      console.log(json);
      window.location.href = `/fail?message={json.message}&code={json.code}`;
    }

    // TODO: 결제 성공 비즈니스 로직을 구현하세요.
    console.log(json);
    return json;
  }
 /* confirm().then(function (data) {
    document.getElementById("response").innerHTML = `<pre>{JSON.stringify(data, null, 4)}</pre>`;
  });*/


  const paymentKeyElement = document.getElementById("paymentKey");
  const orderIdElement = document.getElementById("orderId");
  const amountElement = document.getElementById("amount");
  const uuidElement=document.getElementById("userUUID");

  orderIdElement.textContent = urlParams.get("orderId");
  amountElement.textContent = urlParams.get("amount") + "원";
  paymentKeyElement.textContent = urlParams.get("paymentKey");
</script>
</body>
</html>
