function button_sort() {
  const element = document.querySelector(".sort_price")
  element.addEventListener("click", (event) => {
    element.classList.add("color_price");
  });
};

export { button_sort };
