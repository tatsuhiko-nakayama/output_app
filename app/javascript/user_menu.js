const userMenu = () => {
  const pullDownButton = document.getElementById("user-menu-btn");
  const pullDownList = document.getElementById("user-menu");
  pullDownButton.addEventListener('click', () => {
    if (pullDownList.getAttribute("style") == "display:block;") {
      pullDownList.removeAttribute("style", "display:block;");
      pullDownButton.setAttribute("style", "color: #4a4a4a");
    } else {
      pullDownList.setAttribute("style", "display:block;");
      pullDownButton.setAttribute("style", "color: orange");
    };
  });
};

window.addEventListener("turbolinks:load", userMenu);