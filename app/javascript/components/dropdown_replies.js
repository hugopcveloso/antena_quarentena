

  /*collapsable section*/
  /* para cada secção collapsablle*/
  /* seleccionar e encontrar label. e filtrar pela primeira.*/
  /* seleccionar */



    const dropDownReplies = () => {

/*    const coll = document.querySelectorAll('.collapsible-btn');
    const contentFunction = (contentComment) => {
      if (contentComment.style.display === "block") {
        contentComment.style.display = "none";
      } else {
        contentComment.style.display = "block";
      }
    }
    const collapsibleFunction = (button) => {
        button.addEventListener("click", function() {
        button.classList.toggle("active");
        const content = document.querySelectorAll('.collapsible-content');
          content.forEach(contentFunction);
      });
    }


    coll.forEach(collapsibleFunction);
    }*/

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
/*const filterDashboard = () => {
  var x = document.getElementById("pending-cards");
  var pieActive = document.querySelector(".stats-card-cool");
  pieActive.addEventListener('click', function() {
    if (!pieActive.classList.contains('clicked')) {
      pieActive.classList.toggle('box-shadow');
      x.style.display = "none";
      pieActive.classList.add("clicked");
    } else {
      x.style.display = "block";
      pieActive.classList.remove("clicked");
      pieActive.classList.remove('box-shadow');
    }
  });
}
*/
