const searchBar = () => {
  const searchMenu = document.getElementById("search-menu");
  const searchInput = document.getElementById("search-input");
  const searchForm = document.getElementById("search-form");

  searchMenu.addEventListener('change', () => {
    if (searchMenu.value == "0") {
      searchInput.placeholder = "ハッシュタグを検索";
      searchForm.action = "/hashtags";
    } else if (searchMenu.value == "1") {
      searchInput.placeholder = "タイトルを検索";
      searchForm.action = "/items/search";
    } else if (searchMenu.value == "2") {
      searchInput.placeholder = "ユーザーを検索";
      searchForm.action = "/users/search";
    };
  });
};

window.addEventListener("turbolinks:load", searchBar);