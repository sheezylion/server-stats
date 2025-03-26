function openTab(event, tabName) {
  let tabs = document.getElementsByClassName("tabcontent");

  for (let i = 0; i < tabs.length; i++) {
    tabs[i].style.display = "none";
  }

  document.getElementById(tabName).style.display = "block";

  let tabButtons = document.getElementsByClassName("tablinks");
  for (let i = 0; i < tabButtons.length; i++) {
    tabButtons[i].classList.remove("active");
  }

  event.currentTarget.classList.add("active");
}
