// import { csrfToken } from "rails-ujs";
// import { Controller } from "stimulus";

// export default class extends Controller {
//   static targets = [ 'count' ];

//   connect() {
//     setInterval(this.refresh, 5000);
//   }

//   refresh = () => {
//      fetch('/communities', {
//        headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//         'X-CSRF-Token': csrfToken(),
//       }})
//       .then(response => response.json())
//       .then((data) => {
//         this.countTarget.innerText = data.communities.length
//       });
//   }
// }