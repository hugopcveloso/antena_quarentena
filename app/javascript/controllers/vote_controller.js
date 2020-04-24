import { csrfToken } from "rails-ujs";

import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ 'score' ]

  connect() {

  }

  // upvote = () => {
  //   console.log(this.scoreTarget.innerHTML) 
  // }

// the goal is to create the vote from a fetch.  
// I also could try to create a vote from a link, preventDefault
// use the data action from the click to update the view. 
 
 
  upvote = (event) => {
    event.preventDefault()
    const elementClass = this.scoreTarget.classList.value
    const elementId = parseInt(elementClass.replace(/\D/g,''),10);

    fetch("/votes", {
      method: "POST", 
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        'X-CSRF-Token': csrfToken(),
      },
      // credentials: "same-origin",
      body: JSON.stringify({ votable_id: elementId, votable_type: "Post", upvote: true })
    })
    .then(response => response.json())
    .then((data) => {
      console.log(data.success.test)
      console.log(this.scoreTarget.innerHTML ++)
      
    })
  }
  downvote = (event) => {
    event.preventDefault()

    const elementClass = this.scoreTarget.classList.value
    const elementId = parseInt(elementClass.replace(/\D/g,''),10);

    fetch("/votes", {
      method: "POST", 
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        'X-CSRF-Token': csrfToken(),
      },
      // credentials: "same-origin",
      body: JSON.stringify({ votable_id: elementId, votable_type: "Post", upvote: false })
    })
    .then(response => response.json())
    .then((data) => {
      console.log(data.success)
      console.log(this.scoreTarget.innerHTML ++)
    })
  }
};

  
    

    
  // $("#vote-actions-<%= @post.id %> .score").text("<%= @post.score %>");
  // $("#vote-actions-<%= @post.id %> .downvote, #vote-actions-<%= @post.id%> .upvote").removeClass("active");
  // <% if @new_vote %>
  //   <% if @is_upvote == "true" %>
  //     $("#vote-actions-<%= @post.id %> .upvote").addClass("active");
  //   <% else %>
  //     $("#vote-actions-<%= @post.id %> .downvote").addClass("active");	
  //   <% end %>
  // <% end %>
  