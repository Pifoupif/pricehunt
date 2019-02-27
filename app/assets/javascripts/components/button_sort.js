function button_sort() {
  const element = document.querySelector(".sort-price")
  element.addEventListener("click", (event) => {
    console.log("coucou")
    console.log(element);
    element.classList.add("color-price");
  });
};

export { button_sort };

