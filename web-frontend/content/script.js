const URL = "http://rest-api:5001/people"

function addHuman() {
  const name = document.getElementById("name").value;
  const age = Number(document.getElementById("age").value);
  const data = { 'name': name, "age": age };

  let request = new Request(URL, {
    method: 'POST',
    body: JSON.stringify(data),
    headers: new Headers({
      'Content-Type': 'application/json; charset=UTF-8'
    })
  });

  fetch(request)
  .then((response) => {
    return response.text();
  }).then((data) => {
    console.log(data);
    localStorage.setItem("response", data);
    window.location.href = "response.html";
  }).catch(function(error) {
    console.log(error);
  });

}
