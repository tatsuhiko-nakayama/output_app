const usernameRule = () => {
  const pullDownButton = document.getElementById("username");
  const pullDownParents = document.getElementById("username-rule");
  pullDownButton.addEventListener('focus', () => {
    pullDownParents.setAttribute("style", "display:block;");
  });
}

window.addEventListener("turbolinks:load", usernameRule);

const passwordRule = () => {
  const pullDownButton = document.getElementById("password");
  const pullDownParents = document.getElementById("password-rule");
  pullDownButton.addEventListener('focus', () => {
    pullDownParents.setAttribute("style", "display:block;");
  });
}

window.addEventListener("turbolinks:load", passwordRule);