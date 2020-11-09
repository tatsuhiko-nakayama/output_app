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

const categoryList = () => {
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

window.addEventListener("turbolinks:load", categoryList);