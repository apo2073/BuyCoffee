<!DOCTYPE html>
<html lang="kr">
<head>
  <meta charset="utf-8" />
  <link rel="icon" href="https://static.toss.im/icons/png/4x/icon-toss-logo.png" />
  <#--<link rel="stylesheet" type="text/css" href="style.css" />-->
  <style>
    :root {
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
  <title>토스페이먼츠 샘플 프로젝트</title>
</head>

<body>
<#if uuid??>
  <img id="player-avatar" src="https://api.mineatar.io/face/${uuid}?scale=64" alt="Player Avatar" class="avatar"/>
<#else>
  <p class="no-uuid-message">No UUID provided</p>
</#if>
<div id="info" class="box_section" style="width: 600px">
  <img width="100px" src="https://static.toss.im/lotties/error-spot-no-loop-space-apng.png" />
  <h2>결제를 실패했어요</h2>

  <div class="p-grid typography--p" style="margin-top: 50px">
    <div class="p-grid-col text--left"><b>에러메시지</b></div>
    <div class="p-grid-col text--right" id="message">${message}</div>
  </div>
  <div class="p-grid typography--p" style="margin-top: 10px">
    <div class="p-grid-col text--left"><b>에러코드</b></div>
    <div class="p-grid-col text--right" id="code">${code}</div>
  </div>
  <div class="p-grid">
    <button class="button p-grid-col5" onclick="location.href='https://docs.tosspayments.com/guides/v2/payment-widget/integration';">연동 문서</button>
    <button class="button p-grid-col5" onclick="location.href='${helpME}';" style="background-color: #e8f3ff; color: #1b64da">실시간 문의</button>
  </div>
</div>

<#--<script>
  const urlParams = new URLSearchParams(window.location.search);

  const codeElement = document.getElementById("code");
  const messageElement = document.getElementById("message");

  codeElement.textContent = urlParams.get("code");
  messageElement.textContent = urlParams.get("message");
</script>-->
</body>
</html>
