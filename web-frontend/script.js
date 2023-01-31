const URL = "https://7695-80-112-148-91.eu.ngrok.io/people"

function addHuman() {
  const name = document.getElementById("name").value;
  const age = document.getElementById("age").value;
  const data = { name, age };

  fetch(URL, {
    method: "POST",
    headers: {
      "Content-Type": "application/json"
    },
    body: JSON.stringify(data)
  })
    .then(response => console.log(response.text()))
    .then(data => {
      if (data) {
        localStorage.setItem("response", data);
        window.location.href = "response.html";
      }
    })
    .catch(error => {
      console.error("Error:", error);
    });

}


function showHumans() {
  fetch(URL)
    .then(response => response.json())
    .then(data => {
      if (data && data.humans && data.humans.length) {
        localStorage.setItem("humans", JSON.stringify(data.humans));
        window.location.href = "show_humans.html";
      }
    })
    .catch(error => {
      console.error("Error:", error);
    });
}
