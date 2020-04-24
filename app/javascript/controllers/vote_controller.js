import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ 'score' ]

  connect() {
    const elementClass = this.scoreTarget.classList.value
    const elementId = parseInt(elementClass.replace(/\D/g,''),10);
    console.log(elementId);
  }

  // upvote = () => {
  //   console.log(this.scoreTarget.innerHTML) 
  // }

// the goal is to create the vote from a fetch.  
// I also could try to create a vote from a link, preventDefault
// use the data action from the click to update the view. 

 
  upvote_post = () => {
    
    fetch("/vote", {
      method: "POST", 
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json"
      },
      credentials: 'same-origin',
      body: JSON.stringify({ vote: { votable_id: elementId, votable_type: 'Post', user_id:  }})
    })
      .then(response => response.json())
      .then((data) => {
        // handle JSON response from server
      })
    }
  };

  
