<!DOCTYPE html>
<html lang="utf-8">

<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>NaverLoginSDK</title>
</head>

<body>
<script>
		window.addEventListener('load', function () {
			naverLogin.getLoginStatus(function (status) {
	window.location.replace("http://10.10.10.94:8080/board/list");
				} else {
					console.log("callback 처리에 실패하였습니다.");
				}
			});
		});
	</script>
</body>

</html>