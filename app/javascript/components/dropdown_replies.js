


    const dropDownReplies = () => {


  const collapsingThread = () => {
    const collapsableThread = document.querySelector(".collapsible-content");
    const collapseBtn = document.querySelectorAll(".collapsible-btn");
       for (var i = 0; i < collapseBtn.length; i++) {
      collapseBtn[i].addEventListener('click', function (event) {
        if (collapsableThread.style.display === "block") {
          collapsableThread.style.display = "none";
        } else {
          collapsableThread.style.display = "block";
        }
      });
    }
  collapsingThread();
}
}
export { dropDownReplies };

