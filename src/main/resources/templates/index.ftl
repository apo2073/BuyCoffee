<!DOCTYPE html>
<html lang="ko">
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

        .wrapper {
            max-width: 800px;
            margin: 0 auto;
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

        .result {
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
        }

        .box_section {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1), 0 6px 6px rgba(0, 0, 0, 0.06);
            padding: 40px 30px 50px 30px;
            margin-top: 30px;
            margin-bottom: 50px;
            color: #333D4B;
        }

        .input-container {
            display: flex;
            padding-left: 25px;
            margin-bottom: 20px; /* Space between input and button */
        }

        .input-label {
            display: block;
            margin-bottom: 8px;
            font-size: 20px; /* Adjusted to match other text styles */
            color: #4e5968;
            font-weight: bold; /* Make the text bold */
            padding-left: 10px; /* Move text 10px to the left */
        }

        .donation-input {
            padding: 8px 15px; /*12*/
            border: 1px solid #d1d6db;
            border-radius: 6px;
            font-size: 16px;
            color: #4e5968;
            width: 140px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            transition: border-color 0.2s ease, box-shadow 0.2s ease;
            margin-left: auto;
            margin-right: 25px;
        }

        .donation-input:focus {
            outline: none;
            border-color: #3182f6;
            box-shadow: 0 0 5px rgba(49, 130, 246, 0.5);
        }

        .donation-input::placeholder {
            color: #b0b8c1;
        }

        /* Player Avatar Image */
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
    <!-- 토스페이먼츠 SDK 추가 -->
    <script src="https://js.tosspayments.com/v2/standard"></script>
</head>

<body>
<#if uuid??>
    <img id="player-avatar" src="https://api.mineatar.io/face/${uuid}?scale=64" alt="Player Avatar" class="avatar"/>
<#else>
    <p class="no-uuid-message">No UUID provided</p>
</#if>


<!-- 주문서 영역 -->
<div class="wrapper">
    <div class="box_section">
        <!-- 결제 UI -->
        <div id="payment-method"></div>
        <!-- 이용약관 UI -->
        <div id="agreement"></div>
        <!-- 금액 입력 -->
        <div class="input-container">
            <label for="amount-input" class="input-label">금액 입력</label>
            <input id="amount-input" class="donation-input" type="number" min="1000" value="1000" />
        </div>
        <!-- 결제하기 버튼 -->
        <div class="result">
            <button class="button" id="payment-button">
                결제하기
            </button>
        </div>
    </div>
    <script>
        main();

        async function main() {
            const urlParams = new URLSearchParams(window.location.search);

            const userUUID = "${uuid}"
            const button = document.getElementById("payment-button");
            const amo = document.getElementById("amount-input");
            // test_gck_docs_Ovk5rk1EwkEbP0W43n07xlzm
            const tossPayments = TossPayments("test_gck_docs_Ovk5rk1EwkEbP0W43n07xlzm");
            const customerKey = generateRandomString();
            const widgets = tossPayments.widgets({ customerKey });

            // 주문서의 결제 금액 설정
            const setAmount = async () => {
                await widgets.setAmount({
                    currency: "KRW",
                    value: parseInt(amo.value, 10),
                });
            };

            await setAmount();

            // 결제 UI 렌더링
            await widgets.renderPaymentMethods({
                selector: "#payment-method",
                variantKey: "DEFAULT",
            });

            // 이용약관 UI 렌더링
            await widgets.renderAgreement({ selector: "#agreement", variantKey: "AGREEMENT" });

            // 금액 변경 시 업데이트
            amo.addEventListener("input", async function () {
                await setAmount();
            });

            // '결제하기' 버튼 클릭 시 결제 요청
            button.addEventListener("click", async function () {
                await widgets.requestPayment({
                    orderId: generateRandomString(),
                    orderName: "후원",
                    successUrl: window.location.origin + "/success?uuid=${uuid}",
                    failUrl: window.location.origin + "/fail",
                });
            });
        }

        function generateRandomString() {
            return Math.random().toString(36).substring(2, 15) + Math.random().toString(36).substring(2, 15);
        }
    </script>
</body>
</html>
