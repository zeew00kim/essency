document.getElementById("check-username-btn").addEventListener("click", function () {
    const username = document.getElementById("username").value;

    if (!username) {
        document.getElementById("username-feedback").innerText = "아이디를 입력해주세요.";
        document.getElementById("username-feedback").style.color = "red";
        return;
    }

    fetch("/Essency/checkUsername", {
        method: "POST",
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify({ username: username }),
    })
    .then(response => response.json())
    .then(data => {
        const feedback = document.getElementById("username-feedback");
        if (data.available) {
            feedback.innerText = "사용 가능한 아이디입니다.";
            feedback.style.color = "green";
        } else {
            feedback.innerText = "이미 사용 중인 아이디입니다.";
            feedback.style.color = "red";
        }
    })
    .catch(error => {
        console.error("Error:", error);
        document.getElementById("username-feedback").innerText = "오류가 발생했습니다. 다시 시도해주세요.";
        document.getElementById("username-feedback").style.color = "red";
    });
});
