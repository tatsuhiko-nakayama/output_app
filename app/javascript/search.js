const searchList = () => {
  const pullDownButton = document.querySelector(".search-title");
  const pullDownParents = document.getElementById("search-list");
  pullDownButton.addEventListener('click', () => {
    if (pullDownParents.getAttribute("style") == "display:block;") {
      pullDownParents.removeAttribute("style", "display:block;");
    } else {
      pullDownParents.setAttribute("style", "display:block;");
    }; 
  });
}

window.addEventListener("turbolinks:load", searchList);

const categorySearch = () => {
  const pullDownButton = document.querySelector(".category-search");
  const pullDownParents = document.getElementById("search-category-list");
  pullDownButton.addEventListener('click', () => {
    if (pullDownParents.getAttribute("style") == "display:block;") {
      pullDownParents.removeAttribute("style", "display:block;");
    } else {
      pullDownParents.setAttribute("style", "display:block;");
    }; 
  });
}

window.addEventListener("turbolinks:load", categorySearch);

const titleSearch = () => {
  const pullDownButton = document.querySelector(".title-search");
  const pullDownParents = document.getElementById("title-search-form");
  pullDownButton.addEventListener('click', () => {
    if (pullDownParents.getAttribute("style") == "display:block;") {
      pullDownParents.removeAttribute("style", "display:block;");
    } else {
      pullDownParents.setAttribute("style", "display:block;");
    }; 
  });
}

window.addEventListener("turbolinks:load", titleSearch);

const userSearch = () => {
  const pullDownButton = document.querySelector(".user-search");
  const pullDownParents = document.getElementById("user-search-form");
  pullDownButton.addEventListener('click', () => {
    if (pullDownParents.getAttribute("style") == "display:block;") {
      pullDownParents.removeAttribute("style", "display:block;");
    } else {
      pullDownParents.setAttribute("style", "display:block;");
    }; 
  });
}

window.addEventListener("turbolinks:load", userSearch);