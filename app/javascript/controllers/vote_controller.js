import { csrfToken } from "rails-ujs";

import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ 'score' ]

  upvote = (event) => {
    const elementClass = this.scoreTarget.classList.value
    const elementId = parseInt(elementClass.replace(/\D/g,''),10);
    
    const votableType = this.data.get("type")
    fetch("/votes", {
      method: "POST", 
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        'X-CSRF-Token': csrfToken(),
      },
      // credentials: "same-origin",
      body: JSON.stringify({ votable_id: elementId, votable_type: votableType, upvote: true })
    })
    .then(response => response.json())
    .then((data) => {
 
      this.element.children[0].classList.remove("active")
      this.element.children[2].classList.remove("active")
      if (data.newvote === true) {
        if (data.type === true) {
          event.target.classList.add("active")
          this.scoreTarget.innerHTML = parseInt(data.all_votes,10)
        }
      } else {
        const typeOfVote = data.last_vote ? -1 : 0
        this.scoreTarget.innerHTML = parseInt(data.all_votes,10) + typeOfVote 
      }
      }
    )
  }
  downvote = (event) => {
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
      this.element.children[0].classList.remove("active")
      this.element.children[2].classList.remove("active")
      const active = data.type ? 'active' : ''
      if (data.newvote === true) {
        if (data.type === false) {
          this.element.children[2].classList.add("active")
          this.scoreTarget.innerHTML = parseInt(data.all_votes,10) - 1
        }
      } else {
        const typeOfVote = data.last_vote ? -1 : 0
        this.scoreTarget.innerHTML = parseInt(data.all_votes,10) + typeOfVote 
      }
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
  